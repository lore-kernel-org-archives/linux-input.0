From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
Subject: RE: [PATCHv4 4/5] Input: edt-ft5x06: Ignore touchdown events
Date: Thu, 20 Mar 2014 05:22:01 +0000
Message-ID: <872e4d7ea1ed455592b0bf828d69fb26@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1395234563-11034-1-git-send-email-LW@KARO-electronics.de>
 <1395234563-11034-5-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1395234563-11034-5-git-send-email-LW@KARO-electronics.de>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, Henrik Rydberg <rydberg@euromail.se>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jg1.han@samsung.com>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Rob Landley <rob@landley.net>, Sachin Kamat <sachin.kamat@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Budig <simon.budig@kernelconcepts.de>
List-Id: linux-input@vger.kernel.org

RnJvbTogTG90aGFyIFdhw59tYW5uIDxMV0BLQVJPLWVsZWN0cm9uaWNzLmRlPg0KRGF0YTogV2Vk
bmVzZGF5LCBNYXJjaCAxOSwgMjAxNCA5OjA5IFBNDQoNCj5UbzogRG1pdHJ5IFRvcm9raG92OyBE
dWFuIEZ1Z2FuZy1CMzg2MTE7IEdyYW50IExpa2VseTsgSGVucmlrIFJ5ZGJlcmc7IElhbg0KPkNh
bXBiZWxsOyBKaW5nb28gSGFuOyBLdW1hciBHYWxhOyBNYXJrIFJ1dGxhbmQ7IFBhd2VsIE1vbGw7
IFJvYiBIZXJyaW5nOyBSb2INCj5MYW5kbGV5OyBTYWNoaW4gS2FtYXQ7IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOw0KPmxpbnV4LWlucHV0QHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2ltb24gQnVkaWc7
IExvdGhhcg0KPldhw59tYW5uDQo+U3ViamVjdDogW1BBVENIdjQgNC81XSBJbnB1dDogZWR0LWZ0
NXgwNjogSWdub3JlIHRvdWNoZG93biBldmVudHMNCj4NCj5UaGUgY2hpcCBtYXkgcmVwb3J0IGlu
dmFsaWQgY29vcmRpbmF0ZXMgb24gdG91Y2hkb3duIGV2ZW50cywgc28gZG9uJ3QgcmVwb3J0DQo+
dGhlIGluaXRpYWwgdG91Y2hkb3duIGV2ZW50Lg0KPg0KPlNpZ25lZC1vZmYtYnk6IExvdGhhciBX
YcOfbWFubiA8TFdAS0FSTy1lbGVjdHJvbmljcy5kZT4NCj4tLS0NCj4gZHJpdmVycy9pbnB1dC90
b3VjaHNjcmVlbi9lZHQtZnQ1eDA2LmMgfCAgICA0ICsrKysNCj4gMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKQ0KPg0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVu
L2VkdC1mdDV4MDYuYw0KPmIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9lZHQtZnQ1eDA2LmMN
Cj5pbmRleCAyN2RjY2ZjLi5hZjczNmU0IDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvaW5wdXQvdG91
Y2hzY3JlZW4vZWR0LWZ0NXgwNi5jDQo+KysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9l
ZHQtZnQ1eDA2LmMNCj5AQCAtMTc1LDYgKzE3NSwxMCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgZWR0
X2Z0NXgwNl90c19pc3IoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiAJCWlmICh0eXBlID09IFRP
VUNIX0VWRU5UX1JFU0VSVkVEKQ0KPiAJCQljb250aW51ZTsNCj4NCj4rCQkvKiBpZ25vcmUgVE9V
Q0hfRE9XTiBldmVudHMsIG1pZ2h0IGhhdmUgYm9ndXMgY29vcmRpbmF0ZXMgKi8NCj4rCQlpZiAo
dHlwZSA9PSBUT1VDSF9FVkVOVF9ET1dOKQ0KPisJCQljb250aW51ZTsNCj4rDQo+IAkJeCA9ICgo
YnVmWzBdIDw8IDgpIHwgYnVmWzFdKSAmIDB4MGZmZjsNCj4gCQl5ID0gKChidWZbMl0gPDwgOCkg
fCBidWZbM10pICYgMHgwZmZmOw0KPiAJCWlkID0gKGJ1ZlsyXSA+PiA0KSAmIDB4MGY7DQo+LS0N
Cj4xLjcuMTAuNA0KPg0KPg0KDQpBY2tlZC1ieTogRnVnYW5nIER1YW4gPEIzODYxMUBmcmVlc2Nh
bGUuY29tPg0K
