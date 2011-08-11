From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH RESEND] Input: tegra-kbc - correct call to
 input_free_device
Date: Thu, 11 Aug 2011 09:42:54 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AEA24C0A@HQMAIL01.nvidia.com>
References: <1313052569.2139.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:11146 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab1HKQm5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Aug 2011 12:42:57 -0400
In-Reply-To: <1313052569.2139.1.camel@phoenix>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rakesh Iyer <riyer@nvidia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

QXhlbCBMaW4gd3JvdGUgYXQgVGh1cnNkYXksIEF1Z3VzdCAxMSwgMjAxMSAyOjQ5IEFNOg0KPiBJ
ZiBremFsbG9jIGZvciBrYmMgZmFpbHMsIHRoZW4gd2UgaGF2ZSBOVUxMIHBvaW50ZXIgZGVyZWZl
cmVuY2Ugd2hpbGUNCj4gY2FsbGluZyBpbnB1dF9mcmVlX2RldmljZShrYmMtPmlkZXYpIGluIHRo
ZSBlcnJvciBoYW5kbGluZy4NCj4gU28gaXQgaXMgc2FmZXIgdG8gYWx3YXlzIHVzZSB0aGUgb3Jp
Z2luYWwgbmFtZSwgaW5wdXRfZGV2Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXhlbCBMaW4gPGF4
ZWwubGluQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFN0ZXBoZW4gV2FycmVuIDxzd2FycmVu
QG52aWRpYS5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2lucHV0L2tleWJvYXJkL3RlZ3JhLWti
Yy5jIHwgICAgMiArLQ0KPiAgMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC90ZWdy
YS1rYmMuYyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvdGVncmEta2JjLmMNCj4gaW5kZXggMmIz
YjczZS4uOGU0MGYyYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC90ZWdy
YS1rYmMuYw0KPiArKysgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL3RlZ3JhLWtiYy5jDQo+IEBA
IC03MDEsNyArNzAxLDcgQEAgZXJyX2lvdW5tYXA6DQo+ICBlcnJfZnJlZV9tZW1fcmVnaW9uOg0K
PiAgCXJlbGVhc2VfbWVtX3JlZ2lvbihyZXMtPnN0YXJ0LCByZXNvdXJjZV9zaXplKHJlcykpOw0K
PiAgZXJyX2ZyZWVfbWVtOg0KPiAtCWlucHV0X2ZyZWVfZGV2aWNlKGtiYy0+aWRldik7DQo+ICsJ
aW5wdXRfZnJlZV9kZXZpY2UoaW5wdXRfZGV2KTsNCj4gIAlrZnJlZShrYmMpOw0KPiANCj4gIAly
ZXR1cm4gZXJyOw0KPiAtLQ0KPiAxLjcuNC4xDQoNCi0tIA0KbnZwdWJsaWMNCg0K
