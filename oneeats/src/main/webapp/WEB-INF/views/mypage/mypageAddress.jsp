<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="UTF-8" isELIgnored="false"%> <%@ taglib prefix ="fmt" uri
="http://java.sun.com/jsp/jstl/fmt" %> <%@ taglib prefix ="c" uri
="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
      function execDaumPostCode_(num) {
        new daum.Postcode({
          oncomplete: function (data) {
            var addr = ""; // 주소 변수
            var extraAddr = ""; // 참고항목 변수

            if (data.userSelectedType === "R") {
              addr = data.roadAddress;
            } else {
              addr = data.jibunAddress;
            }

            if (data.userSelectedType === "R") {
              if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
                extraAddr += data.bname;
              }

              if (data.buildingName !== "" && data.apartment === "Y") {
                extraAddr +=
                  extraAddr !== ""
                    ? ", " + data.buildingName
                    : data.buildingName;
              }

              if (extraAddr !== "") {
                extraAddr = " (" + extraAddr + ")";
              }

              document.getElementById("address_extra_input" + num).value =
                extraAddr; //참고항목
            } else {
              document.getElementById("address_extra_input" + num).value = "";
            }

            document.getElementById("h_input_zipcode" + num).value =
              data.zonecode; // 우편번호
            document.getElementById("address_input" + num).value = addr;

            document.getElementById("address_detail_input" + num).focus(); // 상세주소
          },
        }).open();
      }
    </script>
    <style>
      .address_add_form {
        max-width: 400px;
        margin: auto;
      }
      .address_add_form .input-tall {
        height: 60px;
      }
      .address_add_form .input-group-append > button {
        min-width: 120px;
      }
      .address_table {
        width: 100%;
      }
      .address_table :first-child {
        border-bottom: 1px solid #333333;
      }
      .address_table :nth-child(2) {
        font-weight: 600;
      }
    </style>
    <script>
      function fn_openAddressModForm(num) {
        var row = $(".delivery_address_row_" + num);
        var address = row.find(".h_row_address").val();
        var address_detail = row.find(".h_row_address_detail").val();
        var receiver_name = row.find(".h_row_receiver_name").val();
        var receiver_phone = row.find(".h_row_receiver_phone").val();
        var zipCode = row.find(".h_row_zipCode").val();

        var modForm = $("#address_mod_form");
        modForm.find("input[name=address]").val(address);
        modForm.find("input[name=address_detail]").val(address_detail);
        modForm.find("input[name=receiver_name]").val(receiver_name);
        modForm.find("input[name=receiver_phone]").val(receiver_phone);
        modForm.find("input[name=zipCode]").val(zipCode);
        modForm.find("input[name=deliveryNo]").val(num);
        if (modForm.parent().css("display") == "none") {
          modForm.parent().slideToggle();
        }
      }

      $(document).ready(function () {
        $("#modFormExit").on("click", function () {
          var modForm = $("#address_mod_form");
          modForm.parent().slideToggle();
        });
      });
    </script>
    <link rel="stylesheet" href="${contextPath}/css/mina.css" />
  </head>
  <body>
    <div class="div-p1">
      <div class="text-left">
        <span class="textbold">배송지 관리</span>
        <a class="textsize-1 toggle-btn" style="float: right">
          +새 배송지 추가
        </a>
        <div class="clear"></div>
        <hr class="linebold" />
        <div class="toggle-content">
          <form
            action="${contextPath}/mypage/addAddress.do"
            class="address_add_form"
          >
            <div class="row">
              <div class="col textsize-2 textbold">배송지 추가</div>
            </div>
            <div class="row">&nbsp;</div>
            <div class="row">
              <div class="col">
                <div class="row">
                  <div class="col text-left textsize-2">받는 분 성함</div>
                </div>
                <div class="row">
                  <div class="col input-group">
                    <input
                      type="text"
                      class="form-control"
                      name="receiver_name"
                      value="${memberInfo.name}"
                      required
                    />
                  </div>
                </div>
                <div class="row">
                  <div class="col text-left textsize-2">받는 분 전화번호</div>
                </div>
                <div class="row">
                  <div class="col">
                    <input
                      type="text"
                      class="form-control"
                      name="receiver_phone"
                      value="${memberInfo.phone}"
                      required
                    />
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col input-group">
                    <input
                      type="text"
                      id="address_input1"
                      name="address"
                      class="form-control"
                      placeholder="주소"
                      readonly
                      required
                    />
                    <div class="input-group-append">
                      <button
                        type="button"
                        class="bg-lightgreen textsize-2 border-0"
                        onclick="execDaumPostCode_(1)"
                      >
                        주소검색
                      </button>
                    </div>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col">
                    <input
                      id="address_detail_input1"
                      class="form-control"
                      name="address_detail"
                      placeholder=" 상세 주소를 입력해주세요."
                      type="text"
                    />
                    <input
                      type="hidden"
                      id="h_input_zipcode1"
                      placeholder="우편번호"
                      name="zipCode"
                    />
                    <input
                      type="hidden"
                      id="address_extra_input1"
                      placeholder="참고주소"
                    />
                  </div>
                </div>
                <div class="row">&nbsp;</div>
                <div class="row">
                  <div class="col">
                    <button class="btn-long bg-lightgreen border-0">
                      추가
                    </button>
                  </div>
                </div>
                <div class="row">&nbsp;</div>
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="toggle-content">
        <form
          id="address_mod_form"
          action="${contextPath}/mypage/modAddress.do"
          class="address_add_form"
        >
          <input type="hidden" name="deliveryNo" />
          <div class="row">
            <div class="col textsize-2 textbold">배송지 수정</div>
          </div>
          <div class="row">&nbsp;</div>
          <div class="row">
            <div class="col">
              <div class="row">
                <div class="col text-left textsize-2">받는 분 성함</div>
              </div>
              <div class="row">
                <div class="col input-group">
                  <input
                    type="text"
                    class="form-control"
                    name="receiver_name"
                    value=""
                    required
                  />
                </div>
              </div>
              <div class="row">
                <div class="col text-left textsize-2">받는 분 전화번호</div>
              </div>
              <div class="row">
                <div class="col">
                  <input
                    type="text"
                    class="form-control"
                    name="receiver_phone"
                    value="${memberInfo.phone}"
                    required
                  />
                </div>
              </div>
              <div class="row">&nbsp;</div>
              <div class="row">
                <div class="col input-group">
                  <input
                    type="text"
                    id="address_input2"
                    name="address"
                    class="form-control"
                    placeholder="주소"
                    readonly
                    required
                  />
                  <div class="input-group-append">
                    <button
                      type="button"
                      class="bg-lightgreen textsize-2 border-0"
                      onclick="execDaumPostCode_(2)"
                    >
                      주소검색
                    </button>
                  </div>
                </div>
              </div>
              <div class="row">&nbsp;</div>
              <div class="row">
                <div class="col">
                  <input
                    id="address_detail_input2"
                    class="form-control"
                    name="address_detail"
                    placeholder=" 상세 주소를 입력해주세요."
                    type="text"
                  />
                  <input
                    id="h_input_zipcode2"
                    type="hidden"
                    placeholder="우편번호"
                    name="zipCode"
                  />
                  <input
                    id="address_extra_input2"
                    type="hidden"
                    placeholder="참고주소"
                  />
                </div>
              </div>
              <div class="row">&nbsp;</div>
              <div class="row">
                <div class="col">
                  <input type="checkbox" name="isBasicAddress" value="yes" />
                  기본 배송지로 저장
                </div>
              </div>
              <div class="row">&nbsp;</div>
              <div class="row">
                <div class="col">
                  <button class="btn-long bg-lightgreen border-0">수정</button>
                </div>
                <div class="col">
                  <button
                    type="button"
                    id="modFormExit"
                    class="bg-lightgray btn-long border-0"
                  >
                    닫기
                  </button>
                </div>
              </div>
              <div class="row">&nbsp;</div>
              <div class="row"></div>
            </div>
          </div>
        </form>
      </div>
      <table class="address_table textsize-2">
        <tr class="address_header textbold">
          <td class="addresstd2">주소</td>
          <td class="addresstd3">받으실 분</td>
          <td class="addresstd4">연락처</td>
          <td>수정</td>
          <td>삭제</td>
        </tr>
        <c:choose>
          <c:when test="${empty myAddress}">
            <tr>
              <td colspan="5">주소지 정보가 없습니다.</td>
            </tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="item" items="${myAddress}" varStatus="status">
              <tr class="delivery_address_row_${item.deliveryNo}">
                <input
                  type="hidden"
                  class="h_row_address"
                  value="${item.address}"
                />
                <input
                  type="hidden"
                  class="h_row_address_detail"
                  value="${item.address_detail}"
                />
                <input
                  type="hidden"
                  class="h_row_receiver_name"
                  value="${item.receiver_name}"
                />
                <input
                  type="hidden"
                  class="h_row_receiver_phone"
                  value="${item.receiver_phone}"
                />
                <input
                  type="hidden"
                  class="h_row_zipCode"
                  value="${item.zipCode}"
                />
                <td class="addresstd2">
                  ${item.address} &nbsp ${item.address_detail}
                </td>
                <td class="addresstd3">${item.receiver_name}</td>
                <td class="addresstd4">${item.receiver_phone}</td>
                <td>
                  <button
                    class="border-0"
                    type="button"
                    onclick="fn_openAddressModForm('${item.deliveryNo}')"
                  >
                    <i class="bi bi-brush"></i>
                  </button>
                </td>
                <td>
                  <c:if test="${status.index > 0}">
                    <button
                      class="border-0"
                      onclick="fn_openalert('삭제하시겠습니까?','${contextPath}/mypage/deleteAddress.do?deliveryNo=${item.deliveryNo}')"
                      type="button"
                    >
                      <i class="bi bi-trash3"></i>
                    </button>
                  </c:if>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </table>
      <br />
      <br />
      <br />
    </div>
  </body>
</html>
