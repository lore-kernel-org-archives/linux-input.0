From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [patch] Input: remove a duplicative NULL test
Date: Sun, 23 Feb 2014 23:23:42 +0000 (GMT)
Message-ID: <22951681.102711393197819005.JavaMail.weblogic@epml01>
Reply-To: jg1.han@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:12871 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbaBWXXn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 18:23:43 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1H00NHV2BI2390@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 24 Feb 2014 08:23:42 +0900 (KST)
MIME-version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "fugang.duan@freescale.com" <fugang.duan@freescale.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Jingoo Han <jg1.han@samsung.com>

T24gRnJpZGF5LCBGZWJydWFyeSAyMSwgMjAxNCA2OjE1IFBNLCBmdWdhbmcuZHVhbkBmcmVlc2Nh
bGUuY29tIHdyb3RlOg0KPiANCj4gRnJvbTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBv
cmFjbGUuY29tPg0KPiBEYXRhOiBGcmlkYXksIEZlYnJ1YXJ5IDIxLCAyMDE0IDQ6NTUgUE0NCj4g
DQo+ID5UbzogRG1pdHJ5IFRvcm9raG92DQo+ID5DYzogUGF1bCBHb3J0bWFrZXI7IEppbmdvbyBI
YW47IER1YW4gRnVnYW5nLUIzODYxMTsgQmVuc29uIExldW5nOyBEYW5pZWwgS3VydHo7DQo+ID5s
aW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5v
cmcNCj4gPlN1YmplY3Q6IFtwYXRjaF0gSW5wdXQ6IHJlbW92ZSBhIGR1cGxpY2F0aXZlIE5VTEwg
dGVzdA0KPiA+DQo+ID4icGRhdGEiIGlzIG5vbi1OVUxMIGhlcmUuICBXZSB2ZXJpZmllZCB0aGF0
IGF0IHRoZSBzdGFydCBvZiB0aGUgZnVuY3Rpb24uDQo+ID4NCj4gPlNpZ25lZC1vZmYtYnk6IERh
biBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gPg0KPiA+ZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vYXRtZWxfbXh0X3RzLmMNCj4gPmIvZHJpdmVy
cy9pbnB1dC90b3VjaHNjcmVlbi9hdG1lbF9teHRfdHMuYw0KPiA+aW5kZXggYTcwNDAwNzU0ZTky
Li40MGFiZTkwY2M5MjQgMTAwNjQ0DQo+ID4tLS0gYS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVu
L2F0bWVsX214dF90cy5jDQo+ID4rKysgYi9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2F0bWVs
X214dF90cy5jDQo+ID5AQCAtMTE0Niw3ICsxMTQ2LDcgQEAgc3RhdGljIGludCBteHRfcHJvYmUo
c3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4gPiAJCWdvdG8gZXJyX2ZyZWVfbWVtOw0KPiA+
IAl9DQo+ID4NCj4gPi0JZGF0YS0+aXNfdHAgPSBwZGF0YSAmJiBwZGF0YS0+aXNfdHA7DQo+ID4r
CWRhdGEtPmlzX3RwID0gcGRhdGEtPmlzX3RwOw0KPiA+DQo+ID4gCWlucHV0X2Rldi0+bmFtZSA9
IChkYXRhLT5pc190cCkgPyAiQXRtZWwgbWFYVG91Y2ggVG91Y2hwYWQiIDoNCj4gPiAJCQkJCSAg
IkF0bWVsIG1hWFRvdWNoIFRvdWNoc2NyZWVuIjsNCj4gPg0KPiBBZ3JlZSwgaXQgaXMgcmVkdW5k
YW50LiBBbmQgaWYgeW91IGhhdmUgZnJlZSB0aW1lLCB5b3UgY2FuIGNvbnZlcnQgdGhlIGRyaXZl
ciB0byBzdXBwb3J0IGRldmljZXRyZWUuDQo+IA0KPiBBY2tlZC1ieTogRnVnYW5nIER1YW4gPEIz
ODYxMUBmcmVlc2NhbGUuY29tPg0KDQpSZXZpZXdlZC1ieTogSmluZ29vIEhhbiA8amcxLmhhbkBz
YW1zdW5nLmNvbT4NCg0KQmVzdCByZWdhcmRzLA0KSmluZ29vIEhhbg0K


