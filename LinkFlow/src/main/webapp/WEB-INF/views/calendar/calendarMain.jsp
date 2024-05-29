<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calendarMain</title>

	<!-- fullcalendar CDN -->  
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
	<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.11/index.global.min.js'></script>


	<style>
 
     /*풀캘린더 style */
    #calendar {
      max-width: 90%;
      margin: auto;
      padding: 0;
      font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
      font-size: 14px;

    }

    .nav{
      font-weight: bold;
    }

    #cal_name {
      color: white;
      font-size: large;
    }

    .fc-day.fc-day-sat.fc-day-past.fc-daygrid-day,
    .fc-day.fc-day-sun.fc-day-past.fc-daygrid-day{
     background-color: rgba(236, 224, 232, 0.515);

    }    


    /*공휴일 스타일*/
    .holiday{
      background-color: transparent;
      border-color: transparent; /*투명화*/
      font-size: smaller; 
      font-weight: bolder; 
      text-align: end;
      margin-bottom: 5px;
			pointer-events: none;   
	 }

    /*휴지통 스타일*/
    
   .blue-button{
    background-color: rgba(5, 93, 209, 0.903) !important; 
    border: rgba(5, 93, 209, 0.903); 
    
   }
   
   .gray-button{
    background-color: gray !important; 
    border: gray;
    
   }
   
   .blue-button, .gray-button{
    display: flex;
    text-align: center;
    justify-content: center;
    color:white !important; 
   }
   

    /*상세 정보 모달 스타일*/

    .schDetailModal_content > div,
    .search, .schDetailModal_content > textarea, 
    .schDetailModal_content > form {
      margin:auto;
   }
	
	/*캘인더메인에서 일반 일정 커서 포인더 설정*/
	.fc-event {
 	   cursor: pointer;
	}
	
   </style>

    

</head>
<body>
<div class="wrapper">
	
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<div class="LinkFlowMainSection">
	            
	   <jsp:include page="/WEB-INF/views/common/sidebar/calendar/calendarSidebar.jsp"/>
	   
	    
	    <!-- 캘린더 header start -->
	    <div class="LinkFlowMainContent">
	      <section class="content-header">
	        <div class="row mb-2">
	          <div class="col-sm-6">
	              <h1 class="m-0 mx-5">캘린더</h1>
	          </div>
	    
	        </div>
	       <!-- /.container-fluid -->
	      </section>
	       <!-- 캘린더 header end -->
	
	        <!-- 캘린더 Main content start -->
	       <section class="content">
	         <div class="container-fluid"> 
	           <div id='calendar' style="margin-right: 100px;"></div>  
	         </div>
	       </section>
	            <!-- /캘린더 Main content end -->
	     </div>
	        <!-- /.content-wrapper -->
                
     </div>
    </div>
    

        	<jsp:include page="/WEB-INF/views/calendar/include/calendarModal.jsp"/>
    
    <script>

  //풀캘린더 script start
  var calendar; //풀캠 밖에서도 사용 가능하게 전역변수 지정
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');

        calendar = new FullCalendar.Calendar(calendarEl, {
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
            },
            //부트스트랩 more팝오버 
            initialView: 'dayGridMonth', //월간뷰 기본값
            moreLinkClick: "popover",
            //구글api로 공휴일 가져오기
            googleCalendarApiKey: 'AIzaSyABRUUYRcpsMexmdUBwypBZLh9Ft-8PgrA',
            timeZone: 'Asia/Seoul', //시간대 
            //locale : 'ko',
            dayMaxEvents: true, //5
            initialDate:  new Date(), //기준일
            navLinks: true, // 주/주말 이름을 클릭하여 뷰를 이동
            editable: false, // 이벤트를 드래그하여 이동할 수 있음(막기)
            //selectable: true, // 날짜 클릭시 등록
            //more 갯수 제한
            views: {
                timeGrid: {
                     dayMaxEventRows: 5 //5개만 보이고 나머지는 more보이게
                
                }
            },
            displayEventTime: false,
            //중요일정, 전사 부서 개인 일정 순으로 정렬 //다시보기!
            eventOrder: function(a, b) {
            	 
            	//중요일정일 때 a를 위로 //양수면 앞뒤 자리가 바뀌고 음수면 그대로 sort참고 
	            if (a.extendedProps.schImport === 'Y' && b.extendedProps.schImport !== 'Y') {
	                return -1; //반환값이 음수면 첫 뻔 째 일정이 두 번째 보다 우선, 양수면 두 번째 일정이 우선
	            } else if (a.extendedProps.schImport !== 'Y' && b.extendedProps.schImport === 'Y') {
	                return 1;
	            }
	
            	//중요일정 없을 때
	            var order = {
	                '01': 1, // 전사일정
	                '02': 2, // 부서일정
	                '03': 3  // 개인일정
	            };
           	 return order[a.extendedProps.schCalSubCode] - order[b.extendedProps.schCalSubCode]; //02 - 03 -1 - 음수 a가 위 //03 - 01 02 + b가 위  
       		 },                 
            
          	
						//중요일정 클릭시 클래스명 추가
      			eventDidMount: function(info) {
              if (info.event.extendedProps.schImport === 'Y') {
                 info.el.classList.add('important-event');
           	  	
              }  
	         	},
            eventClick: function(info) { //캘린더 메인에 있는 일정 클릭시에만 (나머지는 모달 버튼에 이벤트 걸어야함)
	            var event = info.event; 
	 						
            	if(event.url === ''){ //공휴일만 url 값이 있음. 공휴일 눌렀을 시 상세일정 실행 막기
	            //상세일정   
	            $('body').addClass('overflow-hidden'); 
	            schDetail(event);
            	}
	            // 일정 수정 폼 상세일정의 내용 끌어오기
	            schUpdateForm(event);
	            
	            //공휴일 클릭시 링크 이동 막기(기본 이벤트 막기)
              info.jsEvent.preventDefault();

		        },
            eventSources: [
            	
              //공휴일 
                {
                    googleCalendarId: 'ko.south_korea.official#holiday@group.v.calendar.google.com',
                    //backgroundColor: 'red', // 휴일 이벤트의 배경색을 빨간색으로 지정
                    //borderColor: 'black'
                    classNames: 'holiday',
                    textColor: 'rgba(190, 0, 50, 0.5)',
                    constraint: 'availableForMeeting' //일정 옮기지 못하게 제약조건 걸 때 필요
                }
            ]
        });
        calendar.render();
        
      /*   $(".calCheckbox").each(function(index, checkboxEl){
        	if($(checkboxEl).is(":checked")){
        		addEventAndShow($(checkboxEl).val());
        	}
        }) */
       
    });
    //풀캘린더 
    
    // 넘겨받은 그룹코드의 일정들을 조회해서 캘린더에 뿌리는 역할의함수
     function addEventAndShow(code){
    	$.ajax({
          url: "${contextPath}/calendar/schList.do",
          type: "get",
          //traditional: true,
          data: {
              schCalSubCode: code
          },
          contentType: "application/json",
          dataType: "json",
          success: function(calendarEvents) { // [{일정}, {일정}]
               for (var i = 0; i < calendarEvents.length; i++) {
                   var eventData = {
                   				title: calendarEvents[i].schTitle, //풀캠 필수속성
                           start: calendarEvents[i].startDate, 
                           end: calendarEvents[i].endDate, 
                           color: calendarEvents[i].calColor, 
                           extendedProps: { // 사용자 정의 속성
                               schTitle: calendarEvents[i].schTitle,
                               schImport: calendarEvents[i].schImport,
                               schCalSubCode: calendarEvents[i].schCalSubCode,
                               address: calendarEvents[i].address,
                               notifyYn: calendarEvents[i].notifyYn,
                               schContent: calendarEvents[i].schContent,
                               schNo: calendarEvents[i].schNo,
                               calNo: calendarEvents[i].calNo

                           }
                   };
                   //events.push(eventData);//addEvent로도 가능
                   calendar.addEvent(eventData);
               }
              
              //successCallback(events);
              //calendar.refetchEvents();
          },
          error: function() {
          }
      });
		}
 
    // 일정 상세 ******************
		function schDetail(event) {
        var extendedProps = event.extendedProps;
        
        $('#schNo').val(extendedProps.schNo); //삭제에서 쓰기위해 저장
		    $('#schDetailTitle').text(event.title);
		    $('#schImport').val(extendedProps.schImport);
		    $('#schCalSubCode').val(extendedProps.schCalSubCode);
			
		    //날짜 텍스트로 형식 맞춰넣기 위한 처리
		    var startDateChange = new Date(event.start);
		    var startDate = startDateChange.toLocaleString('ko-KR', {
		        year: 'numeric',
		        month: '2-digit',
		        day: '2-digit',
		        hour: '2-digit',
		        minute: '2-digit'
		    });
		    $('#startDate').text(startDate);
		
		    var endDateChange = new Date(event.end);
		    var endDate = endDateChange.toLocaleString('ko-KR', {
		        year: 'numeric',
		        month: '2-digit',
		        day: '2-digit',
		        hour: '2-digit',
		        minute: '2-digit'
		    });
		    $('#endDate').text(endDate === startDate ? '' : '~  ' + endDate);
		
		    $('#address').text(extendedProps.address);
		    $('#schDetailModal_content_text').text(extendedProps.schContent);
		
		    $('#schImport').prop('checked', extendedProps.schImport === 'Y');
		    $('#notifyYn').prop('checked', extendedProps.notifyYn === 'Y');
		
		    //캘린더명 처리
		    if (extendedProps.schCalSubCode == '03') {
		        $('#schCalSubCode').text('개인 캘린더');
		    } else if (extendedProps.schCalSubCode == '02') {
		        $('#schCalSubCode').text('부서 캘린더');
		    } else if (extendedProps.schCalSubCode == '01') {
		        $('#schCalSubCode').text('전사 캘린더');
		    }
		
		    //버튼 표시여부 처리(직급에 따라)
		    var spRight = '${loginUser.spRight}'; //전사
		    var deptRight = '${loginUser.deptRight}';//부서
		    var subCode = extendedProps.schCalSubCode;
		
		    if (spRight === 'Y' && subCode === '01' || subCode === '03' ) {
		        $('.schDetailModal_blueBtn, .schDetailModal_grayBtn').show();
		    } else if (deptRight === 'Y' && subCode === '02' || subCode === '03') {
		        $('.schDetailModal_blueBtn, .schDetailModal_grayBtn').show();
    		}else {
		        $('.schDetailModal_blueBtn, .schDetailModal_grayBtn').hide();
		    }
		    
		    $('#schDetailModal').modal('show');
		}
		    
    
    
		// 일정 수정 폼 ******************
		function schUpdateForm(event) {
	      var extendedProps = event.extendedProps;

		    $('.schDetailModal_blueBtn').click(function() {
		        $('#schUpdateModal').modal('show');

		        $('#schUpdateModal input[name="schTitle"]').val(event.title);
		        $('#schUpdateModal input[name="address"]').val(extendedProps.address);
		        $('#schUpdateModal textarea[name="schContent"]').val(extendedProps.schContent);
		        $('#schUpdateModal input[name="schImport"]').prop('checked', extendedProps.schImport === 'Y');
		        $('#schUpdateModal input[name="notifyYn"]').prop('checked', extendedProps.notifyYn === 'Y');
		        $('#schUpdateModal select[name="schCalSubCode"]').val(extendedProps.schCalSubCode).change();
		        $('#schUpdateModal input[name="schNo"]').val(extendedProps.schNo);
		        $('#schUpdateModal input[name="calNo"]').val(extendedProps.calNo);
		        var startDate = new Date(event.start).toISOString().slice(0, 16);
		        var endDate = event.end ? new Date(event.end).toISOString().slice(0, 16) : startDate;

		        $('#schUpdateModal input[name="startDate"]').val(startDate);
		        $('#schUpdateModal input[name="endDate"]').val(endDate);
		        console.log("schNo:", extendedProps.schNo);
		    });
		}
		

		
    //일정 삭제, 수정, 캘린더 체크박스 
		  $(document).ready(function() {
	  	  //일정 수정하기 모달 클릭시 more과 곂치지않도록 조정
        $('#schDetailModal').on('show.bs.modal', function() {
        	 $('.fc-popover').css({
        	        'z-index': '-1',
        	        'position': 'relative'
        	    });
	  	  });
			  
     // 일정 수정하기 모달에서 저장 버튼 클릭 시  ***************
        $('#schUpdateButton').click(function() {
        	 
            var data = {
                calNo: $('#schUpdateModal input[name="calNo"]').val(),
                schNo: $('#schUpdateModal input[name="schNo"]').val(),
                schTitle: $('#schUpdateModal input[name="schTitle"]').val(),
                schImport: $('#schUpdateModal input[name="schImport"]').is(':checked') ? 'Y' : 'N',
                schCalSubCode: $('#schUpdateModal select[name="schCalSubCode"]').val(),
                startDate: $('#schUpdateModal input[name="startDate"]').val(),
                endDate: $('#schUpdateModal input[name="endDate"]').val(),
                address: $('#schUpdateModal input[name="address"]').val(),
                notifyYn: $('#schUpdateModal input[name="notifyYn"]').is(':checked') ? 'Y' : 'N',
                schContent: $('#schUpdateModal textarea[name="schContent"]').val()
            };
            
            if (data.schTitle === '') {
                alert("제목을 입력하세요");
                event.preventDefault();
                return; 
            } else if (data.startDate >= data.endDate) {
	              alert("종료일이 시작일보다 같거나 작을 수 없습니다.");
	              return; 
	          }


            $.ajax({
                type: "POST",
                url: "${contextPath}/calendar/updateSch.do",
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "text",
                success: function(resultSch) {
                    if (resultSch === "success") {
                        alert("일정 수정 성공.");
                        $('#schUpdateModal').modal('hide');
                        $('#schDetailModal').modal('hide');

                       /*   // 수정된 일정의 기존 이벤트를 찾아 업데이트
                        var eventData = {
				                    title: data.schTitle,
				                    start: data.startDate,
				                    end: data.endDate,
				                    color: $('input[name="calColor"]').val(),
				                    extendedProps: {
				                        schTitle: data.schTitle,
				                        schImport: data.schImport,
				                        schCalSubCode: data.schCalSubCode,
				                        address: data.address,
				                        notifyYn: data.notifyYn,
				                        schContent: data.schContent
				                        
				                    }

                        };    */
                        //calendar.addEvent(eventData);
                        //calendar.addEvent(eventData);
                        addEventAndShow(data.schCalSubCode);
                        
                        CheckboxReSelect();
                       
                       /*  // 수정된 일정의 기존 이벤트를 찾아 업데이트
                        var event = calendar.getEventById(data.schNo);

                        // 일정 속성 업데이트
                        if (event) {
                            event.setProp('title', data.schTitle);
                            event.setStart(data.startDate);
                            event.setEnd(data.endDate);
                            event.setExtendedProp('schImport', data.schImport);
                            event.setExtendedProp('schCalSubCode', data.schCalSubCode);
                            event.setExtendedProp('address', data.address);
                            event.setExtendedProp('notifyYn', data.notifyYn);
                            event.setExtendedProp('schContent', data.schContent);
                            event.setExtendedProp('calNo', data.calNo);
                        }

                        CheckboxReSelect(); */
                    }
                },
                error: function() {
                    console.log("일정 수정 실패.");
                }
            });
        });

     
    		//수정모달에서 취소 클릭시
			  $('#schUpdateCancelBtn').click(function() {
           $('#schUpdateModal').modal('hide');
			  });
			  
			  //캘린더 재조회 수정에서 
		      function CheckboxReSelect(){
		     	  var events = calendar.getEvents(); 
		     	  var changeCheckboxVal = $(".calCheckbox").val();
		        events.forEach(function(event) {
		       	 event.extendedProps.schCalSubCode && event.extendedProps.schCalSubCode == changeCheckboxVal && event.remove();


		       });
		     }
    // 일정 삭제 *******************************
    	//삭제모달 html text
        $('.schDetailModal_grayBtn').click(function() {
          $('#detailBtn-modal-body').html('<div>일정을 삭제하시겠습니까?<p style="color:red; font-size:small; padding-top:10px;">삭제된 일정은 휴지통에서 복구 가능합니다.</p></div>');
        });
    
    	//삭제모달에서 삭제 버튼 클릭시 
        $('#schDeleteBtn').click(function() {
        
        	var schNo = $('#schNo').val(); 
        	
            $.ajax({
                url: "${contextPath}/calendar/deleteSch.do",
                type: "get",
                data: {
                    schNo: schNo
                },
                success: function(result) {
                    console.log("success:", result);

                    if (result === "success") {
                        alert("일정 삭제 성공");
                        $('#schDetailModal').modal('hide');
                        $('#detailBtn').modal('hide');
                        
                        //선택 일정만 삭제
                        var events = calendar.getEvents(); 
                        events.forEach(function(event) {
                        	event.extendedProps.schNo == schNo && event.remove();
                        });         
                        
                    } else {
                        alert("일정 삭제 실패.");
                    }
                },
                error: function(result) {
                	if (result === "fail") {
                        $('#schDetailModal').modal('hide');
                    } 
                }
            });
        });
    
	
		  // 중요일정 체크박스 클릭 시 조건
	    $('#schImportInsertBtn').click(function() {
	        var important = $(this).is(':checked') ? 'Y' : 'N';
	        $('input[name="schImport"]').val(important);
	        var mod = '${loginUser.userId}'; 
	        $('input[name="modId"]').val(mod); 
	        
	        // 일정 등록 버튼 클릭 시 모달 띄우기
	        if (mod === '') {
	            alert("일정을 등록하려면 로그인을 해 주세요.");
	            window.location.href = "/linkflow/member/loginout.me"; // 로그인 페이지 경로로 이동
	        } else {
	                $('#schInsertModal').modal('show');
	                $('body').addClass('modal-open'); 
	        }

	    });
		  
	    $('#notifyInsertBtn').click(function() {
	        var notify = $(this).is(':checked') ? 'Y' : 'N';
	        $('input[name="notifyYn"]').val(notify);
	    });
	    
    
      //삭제모달에서 취소버튼 클릭시
      $('#schDeleteCancelBtn').click(function() {
          $('#detailBtn').modal('hide');

      });

    // 개인캘린더, 부서캘린더, 전사캘린더 체크박스 클릭 시 일정 목록 조회
       $(".calCheckbox").change(function() {
       	
       		var changeCheckboxVal = $(this).val();
           if($(this).is(":checked")) {
               //calendar.refetchEvents();
           	addEventAndShow($(this).val());
           }else { // 체크해제일 경우
           	
               var events = calendar.getEvents(); // 현재보여지는 모든 일정을 다 가져오고 
               
               events.forEach(function(event) {
               	//console.log(event.extendedProps);
               	//console.log(event.extendedProps.schCalSubCode);
               	event.extendedProps.schCalSubCode == changeCheckboxVal && event.remove();
               });
               
               //calendar.refetchEvents();
           }
       });


  	});
   

          
 	 
	</script>
</body>
</html>