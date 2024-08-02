<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GH Bank - 예/적금상품</title>
    <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
    <style>
    		h2 {
            color: #003366;
            border-bottom: 2px solid #003366;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-family: "Noto Sans KR", sans-serif;
				   	font-optical-sizing: auto;
				   	font-weight: <weight>;
				   	font-style: normal;
        }
        h6 {
        	font-family: "Noto Sans KR", sans-serif;
			   	font-optical-sizing: auto;
			   	font-weight: <weight>;
			   	font-style: normal;
        }
        body {
            font-family: "Noto Sans KR", sans-serif;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            font-family: "Noto Sans KR", sans-serif;
				   	font-optical-sizing: auto;
				   	font-weight: <weight>;
				   	font-style: normal;
        }
        .product-box {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            position: relative;
				    overflow: hidden;
				    padding-bottom: 25px; /* 버튼 높이보다 약간 더 큰 값으로 설정 */
   					margin-bottom: 30px; /* 박스 간 간격 유지 */
 					 	overflow: hidden; /* 넘치는 내용 숨기기 */
        }
        .product-box:hover .detail-button {
            bottom: 0;
        }
        .product-box .product-info:last-of-type {
			    margin-bottom: 20px;
				}
        .product-title {
            color: #1a73e8;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .product-subtitle {
            font-size: 14px;
            color: #5f6368;
            margin-bottom: 15px;
        }
        .product-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        .info-item {
            font-size: 14px;
        }
        .rate-range {
            text-align: right;
            font-size: 16px;
            font-weight: bold;
            color: #1a73e8;
        }
        .product-icon {
            width: 50px;
            height: 50px;
            background-color: #e8f0fe;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }
        .product-header {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .icon {
            font-size: 25px;
        }
        .detail-button {
			    position: absolute;
			    bottom: -35px; /* 버튼 높이만큼 아래로 숨김 */
			    left: 0;
			    right: 0;
			    background-color: rgba(26, 115, 232, 0.8);
			    color: white;
			    text-align: center;
			    padding: 10px 0;
			    font-weight: bold;
			    transition: bottom 0.3s ease;
			    cursor: pointer;
			    font-size: 14px;
			    height: 40px; /* 버튼 높이 고정 */
			    display: flex;
			    align-items: center;
			    justify-content: center;
				}
        .modal-body {
            max-height: 70vh;
            overflow-y: auto;
        }
        .apply-button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #1a73e8;
            color: white;
            text-align: center;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }
				.modal-dialog {
				    display: flex;
				    align-items: center;
				    min-height: calc(100% - 1rem);
				    margin: 0 auto;
				}
				
				.modal-content {
				    width: 100%;
				    max-height: 90vh;
				    overflow-y: auto;
				}
				
				@media (min-width: 576px) {
				    .modal-dialog {
				        max-width: 500px;
				    }
				}
				
				.modal.fade .modal-dialog {
				    transition: transform .3s ease-out;
				    transform: translate(0, -50px);
				}
				
				.modal.show .modal-dialog {
				    transform: translate(0, 0);
				}
        .page-title {
            margin-top: 40px;
            margin-bottom: 30px;
        }
        .banner {
            background-color: #e8f0fe;
            padding: 15px;
            margin-bottom: 20px;
            text-align: center;
        }
        .modal-content-style {
			    font-family: "Noto Sans KR", sans-serif;
			    font-optical-sizing: auto;
			    font-weight: 400; /* 원하는 weight 값으로 변경 */
			    font-style: normal;
				}
    </style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/nav3.jsp" %>
<%@ include file = "/WEB-INF/views/include/nav4.jsp" %>
<div class="container">
<h2 class="mt-5">GH Bank 예/적금 상품소개</h2>
<h6>아래는 GH Bank의 예금 및 적금 상품입니다.</h6>
<h6 class="mb-5">각 상품 위에 마우스를 올리시면 '자세히 보기' 버튼이 나타납니다. 해당 버튼을 클릭하시면 상품의 상세 정보를 확인하실 수 있습니다.</h6><br/>
    <div class="product-box">
        <div class="product-header">
            <div class="product-icon">
                <i class="fa-solid fa-chart-line icon" style="color: #1a73e8;"></i>
            </div>
            <div>
                <div class="product-title">Smart 정기예금</div>
                <div class="product-subtitle">고객님의 꼼꼼한 자산 관리를 위해 특별히 준비했어요</div>
            </div>
        </div>
        <div class="product-info">
            <div class="info-item">상품개요 | 일정 기간 동안 예치된 금액에 대해 고정된 이자를 제공하는 저축 상품</div>
            <div class="rate-range">
                연 <span style="font-size: 20px;">2.5</span>%
            </div>
        </div>
        <div class="product-info">
            <div class="info-item">상품종류 | 정기예금</div>
            <div class="info-item">가입대상 | 만 19세 이상 개인 및 법인</div>
        </div>
        <div class="product-info">
            <div class="info-item">가입기간 | 6개월, 12개월, 24개월 중 선택가능</div>
            <div class="info-item">가입금액 | 1천원 부터 50만원 까지</div>
        </div>
        <div class="detail-button" onclick="showDetails('Smart 정기예금','Y')">자세히 보기</div>
    </div>
</div>
<div class="container">
    <div class="product-box">
        <div class="product-header">
            <div class="product-icon">
                <i class="fa-solid fa-people-roof icon" style="color: #1a73e8;"></i>
            </div>
            <div>
                <div class="product-title">Hello GH, 반가워 적금</div>
                <div class="product-subtitle">새롭게 금융거래를 시작하는 고객님을 위해 준비했어요</div>
            </div>
        </div>
        <div class="product-info">
            <div class="info-item">상품개요 | 일정 기간 동안 매월 일정 금액을 저축하여 이자를 받을 수 있는 저축 상품</div>
            <div class="rate-range">
                연 <span style="font-size: 20px;">2.8</span>%
            </div>
        </div>
        <div class="product-info">
            <div class="info-item">상품종류 | 정기적금</div>
            <div class="info-item">가입대상 | 만 19세 이상 개인 및 법인</div>
        </div>
        <div class="product-info">
            <div class="info-item">가입기간 | 12개월, 24개월, 36개월 중 선택가능</div>
            <div class="info-item">가입금액 | 1천원 부터 50만원 까지</div>
        </div>
        <div class="detail-button" onclick="showDetails('Hello GH, 반가워 적금','J')">자세히 보기</div>
    </div>
</div>

<!-- 상세 정보 모달 -->
<div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="detailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="detailModalLabel"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="detailModalBody">
                <!-- 상세 내용은 JavaScript에서 동적으로 채워집니다 -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" onclick="applyProduct()">신청하기</button>
                <input type="hidden" name="flagSw" id="flagSw" />
            </div>
        </div>
    </div>
</div>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
$(document).ready(function() {
    $('#detailModal').on('show.bs.modal', function () {
        var $this = $(this);
        var $modal_dialog = $this.find('.modal-dialog');
        $modal_dialog.css({
            'position': 'absolute',
            'top': '50%',
            'left': '50%',
            'transform': 'translate(-50%, -50%)'
        });
    });
});

function showDetails(productName,flagSw) {
    let modalTitle = document.getElementById('detailModalLabel');
    let modalBody = document.getElementById('detailModalBody');
    $("#flagSw").val(flagSw);
    
    modalTitle.textContent = productName;
    
 		// 모달 본문에 CSS 클래스 적용
    modalBody.classList.add('modal-content-style');
    
    if (productName === 'Smart 정기예금') {
        modalBody.innerHTML = `
            <h4>상품 특징</h4>
            <ul>
                <li>고정 금리로 예치 기간 동안 안정적인 이자 수익을 보장</li>
                <li>일정 기간 동안 인출이 제한되며 만기 시 원금과 이자를 함께 수령</li>
            </ul>
            <h4>가입 대상</h4>
            <p>만 19세 이상 개인 및 법인 (1인 1계좌)</p>
            <h4>예금종류</h4>
            <p>정기예금</p>
            <h4>저축 방법</h4>
            <p>일시 예치식</p>
        `;
    } else if (productName === 'Hello GH, 반가워 적금') {
        modalBody.innerHTML = `
            <h4>상품 특징</h4>
            <ul>
                <li>매월 일정 금액을 정기적으로 납입하여 목돈 마련이 가능한 상품</li>
                <li>목표 금액과 기간을 설정하여 계획적인 재정 관리를 도울 수 있음</li>
            </ul>
            <h4>가입 대상</h4>
            <p>만 19세 이상 개인 빛 법인 (1인 1계좌)</p>
            <h4>적금종류</h4>
            <p>정기적금</p>
            <h4>저축 방법</h4>
            <p>자유적립식 (월 1,000원 이상 50만원 이하)</p>
        `;
    }
    
    $('#detailModal').modal('show');
}

function applyProduct() {
    let productName = document.getElementById('detailModalLabel').textContent;
    let flagSw = document.getElementById('flagSw').value;
    if (confirm(productName + " 상품을 신청하시겠습니까?")) {
        alert("신청 페이지로 이동합니다.");
        location.href = '${ctp}/saving/savingSignup?flagSw='+flagSw;
    }
}
</script>
</body>
</html>