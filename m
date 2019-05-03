From: Fabien DESSENNE <fabien.dessenne@st.com>
Subject: Re: [PATCH] HID: rmi: fix devm_add_action_or_reset() parameter
Date: Fri, 3 May 2019 12:38:18 +0000
Message-ID: <9628edde-5270-d5a5-7db6-c9ec3f47c742@st.com>
References: <1555073657-24386-1-git-send-email-fabien.dessenne@st.com>
 <nycvar.YFH.7.76.1905031418510.10635@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1905031418510.10635@cbobk.fhfr.pm>
Content-Language: en-US
Content-ID: <8C93354F4F1B5C4394EE04057F7F1250@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

DQpPbiAwMy8wNS8yMDE5IDI6MTkgUE0sIEppcmkgS29zaW5hIHdyb3RlOg0KPiBPbiBGcmksIDEy
IEFwciAyMDE5LCBGYWJpZW4gRGVzc2VubmUgd3JvdGU6DQo+DQo+PiBUaGUgc2Vjb25kIHBhcmFt
ZXRlciBvZiBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoKSBzaGFsbCBiZSBhIGZ1bmN0aW9uLA0K
Pj4gbm90IGEgZnVuY3Rpb24gYWRkcmVzcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGYWJpZW4g
RGVzc2VubmUgPGZhYmllbi5kZXNzZW5uZUBzdC5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9o
aWQvaGlkLXJtaS5jIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLXJtaS5j
IGIvZHJpdmVycy9oaWQvaGlkLXJtaS5jDQo+PiBpbmRleCA5ZTMzMTY1Li44NzQ4ZDRkIDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9oaWQvaGlkLXJtaS5jDQo+PiArKysgYi9kcml2ZXJzL2hpZC9o
aWQtcm1pLmMNCj4+IEBAIC02MjMsNyArNjIzLDcgQEAgc3RhdGljIGludCBybWlfc2V0dXBfaXJx
X2RvbWFpbihzdHJ1Y3QgaGlkX2RldmljZSAqaGRldikNCj4+ICAgCWlmICghaGRhdGEtPmRvbWFp
bikNCj4+ICAgCQlyZXR1cm4gLUVOT01FTTsNCj4+ICAgDQo+PiAtCXJldCA9IGRldm1fYWRkX2Fj
dGlvbl9vcl9yZXNldCgmaGRldi0+ZGV2LCAmcm1pX2lycV90ZWFyZG93biwgaGRhdGEpOw0KPj4g
KwlyZXQgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoJmhkZXYtPmRldiwgcm1pX2lycV90ZWFy
ZG93biwgaGRhdGEpOw0KPiBXaHkgZG8geW91IHRoaW5rIHRoaXMgaXMgd3JvbmcgQz8NCg0KDQpC
ZWNhdXNlIEkgd2FzIG5vdCBhd2FyZSB0aGF0IGJvdGggZnVuYyBhbmQgJmZ1bmMgcmVmZXIgdG8g
dGhlIHNhbWUgDQpmdW5jdGlvbiBwb2ludGVyLg0KDQpOb3cgSSBrbm93IDopDQoNCg0KPg==
