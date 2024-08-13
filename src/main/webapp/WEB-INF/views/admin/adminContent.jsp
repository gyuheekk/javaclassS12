<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GH Bank - 관리자메뉴</title>
  
  <!-- Favicon 링크 추가 -->
  <link rel="icon" type="image/png" href="${ctp}/images/TitleLogo.png">
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f4f7f9;
    }
    .content {
      padding: 20px;
    }
    .card {
      border: none;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      margin-bottom: 20px;
    }
    .card-header {
      background-color: #115C8B;
      color: white;
      border-radius: 10px 10px 0 0;
      padding: 15px;
    }
    .card-body {
      padding: 20px;
    }
    .btn-custom {
      background-color: #115C8B;
      color: white;
      border: none;
      padding: 8px 15px;
      border-radius: 5px;
    }
    .btn-custom:hover {
      background-color: #0056b3;
      color: white;
    }
    /* .btn-white {
      background-color: #FFFFFF;
      color: black;
      border: none;
      padding: 8px 15px;
      border-radius: 5px;
    } */
    .btn-white:hover {
      background-color: #EEEEEE;
      color: black;
    }
  </style>
</head>
<body>
<div class="content">
  <h3 class="mb-4"><i class="fa-solid fa-user-gear icon-spacing mr-2"></i>관리자 메인화면</h3>
  <div class="row mb-4">
    <div class="col-md-3">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0"><i class="fas fa-envelope mr-2"></i>신규 문의</h5>
        </div>
        <div class="card-body">
          <p>처리 대기 중 : ${boardCnt}건</p>
          <a href="${ctp}/admin/board/boardList?part=문의사항" class="btn btn-custom">자세히 보기</a>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0"><i class="fas fa-user-plus mr-2"></i>신규 회원</h5>
        </div>
        <div class="card-body">
          <p>최근 7일 내 가입 : ${newMemberCnt}명</p>
          <a href="${ctp}/admin/member/memberList?level=1" class="btn btn-custom">자세히 보기</a>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0"><i class="fa-solid fa-user-slash mr-2"></i>탈퇴 신청</h5>
        </div>
        <div class="card-body">
          <p>탈퇴 신청 회원 : ${userNoCnt}명</p>
          <a href="${ctp}/admin/member/memberList?level=99" class="btn btn-custom">자세히 보기</a>
        </div>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0"><i class="fas fa-money-bill-wave mr-2"></i>일일 거래량</h5>
        </div>
        <div class="card-body">
          <p>오늘의 총 거래 건수 : ${accountDaily}건</p>
          <a href="${ctp}/admin/dailyAccount" class="btn btn-custom">자세히 보기</a>
        </div>
      </div>
    </div>
  </div>

  <div class="card mb-4">
    <div class="card-header">
    	<div class="d-flex justify-content-between align-items-center">
      	<h5 class="mb-0">금융 서비스 이용 현황</h5>
      	<!-- <a href="#" class="btn btn-white">이용 현황 자세히 보기</a> -->
      </div>
    </div>
    <div class="card-body">
      <canvas id="salesChart"></canvas>
    </div>
  </div>
</div>


 <script>
var ctx = document.getElementById('salesChart').getContext('2d');
var salesChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: ['입금', '출금', '계좌이체', '대출', '예금', '적금', '카드', '기타'],
    datasets: [
      {
        label: '기본 서비스',
        data: [65, 59, 78, 0, 56, 55, 0, 42],
        backgroundColor: 'rgba(17, 92, 139, 0.8)',
        borderColor: '#115C8B',
        borderWidth: 1
      },
      {
        label: '신용대출',
        data: [0, 0, 0, 40, 0, 0, 0, 0],
        backgroundColor: 'rgba(41, 128, 185, 0.8)',
        borderColor: '#2980B9',
        borderWidth: 1
      },
      {
        label: '학자금대출',
        data: [0, 0, 0, 25, 0, 0, 0, 0],
        backgroundColor: 'rgba(52, 152, 219, 0.8)',
        borderColor: '#3498DB',
        borderWidth: 1
      },
      {
        label: '신용카드',
        data: [0, 0, 0, 0, 0, 0, 74, 0],
        backgroundColor: 'rgba(133, 193, 233, 0.8)',
        borderColor: '#85C1E9',
        borderWidth: 1
      },
      {
        label: '체크카드',
        data: [0, 0, 0, 0, 0, 0, 64, 0],
        backgroundColor: 'rgba(174, 214, 241, 0.8)',
        borderColor: '#AED6F1',
        borderWidth: 1
      }
    ]
  },
  options: {
    responsive: true,
    scales: {
      y: {
        beginAtZero: true,
        title: {
          display: true,
          text: '이용 건수'
        }
      },
      x: {
        title: {
          display: true,
          text: '금융 서비스'
        },
        barPercentage: 0.9,
        categoryPercentage: 0.8
      }
    },
    plugins: {
      title: {
        display: true,
        text: '금융 서비스 이용 분석',
        font: {
          size: 18,
          weight: 'bold'
        },
        color: '#115C8B'
      },
      subtitle: {
        display: true,
        text: '서비스 종류별 이용 현황',
        font: {
          size: 14
        },
        color: '#2980B9'
      },
      tooltip: {
        callbacks: {
          label: function(context) {
            let label = context.dataset.label || '';
            if (label) {
              label += ': ';
            }
            if (context.parsed.y !== null) {
              label += context.parsed.y + ' 건';
            }
            return label;
          }
        }
      },
      legend: {
        labels: {
          color: '#115C8B'
        }
      }
    }
  }
});
</script>
</body>
</html>