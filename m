From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V2 05/10] mfd: da9061: MFD core support
Date: Fri, 11 Nov 2016 15:50:12 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE9AB0@SW-EX-MBX02.diasemi.com>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <bf02595c2fa32ba0c4311e2d480321b811fc9cf5.1477501000.git.stwiss.opensource@diasemi.com>
 <20161111103734.GD13638@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161111103734.GD13638@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

T24gMTEgTm92ZW1iZXIgMjAxNiAxMDozOCwgTGVlIEpvbmVzIHdyb3RlOg0KPiANCj4gPiArc3Rh
dGljIHN0cnVjdCByZXNvdXJjZSBkYTkwNjFfY29yZV9yZXNvdXJjZXNbXSA9IHsNCj4gPiArCURF
RklORV9SRVNfTkFNRUQoREE5MDYxX0lSUV9WRERfV0FSTiwgMSwgIlZERF9XQVJOIiwgSU9SRVNP
VVJDRV9JUlEpLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCByZXNvdXJjZSBk
YTkwNjFfcmVndWxhdG9yc19yZXNvdXJjZXNbXSA9IHsNCj4gPiArCURFRklORV9SRVNfTkFNRUQo
REE5MDYxX0lSUV9MRE9fTElNLCAxLCAiTERPX0xJTSIsIElPUkVTT1VSQ0VfSVJRKSwNCj4gPiAr
fTsNCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcmVzb3VyY2UgZGE5MDYxX3RoZXJtYWxfcmVz
b3VyY2VzW10gPSB7DQo+ID4gKwlERUZJTkVfUkVTX05BTUVEKERBOTA2MV9JUlFfVEVNUCwgMSwg
IlRIRVJNQUwiLCBJT1JFU09VUkNFX0lSUSksDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMg
c3RydWN0IHJlc291cmNlIGRhOTA2MV93ZHRfcmVzb3VyY2VzW10gPSB7DQo+ID4gKwlERUZJTkVf
UkVTX05BTUVEKERBOTA2MV9JUlFfV0RHX1dBUk4sIDEsICJXRF9XQVJOIiwgSU9SRVNPVVJDRV9J
UlEpLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCByZXNvdXJjZSBkYTkwNjFf
b25rZXlfcmVzb3VyY2VzW10gPSB7DQo+ID4gKwlERUZJTkVfUkVTX05BTUVEKERBOTA2MV9JUlFf
T05LRVksIDEsICJPTktFWSIsIElPUkVTT1VSQ0VfSVJRKSwNCj4gPiArfTsNCj4gDQo+IFRoZXNl
IHNob3VsZCBhbCBiZTogREVGSU5FX1JFU19JT19OQU1FRCgpDQoNCkhhdmUgYWx0ZXJlZCB0aGVz
ZSB0byBERUZJTkVfUkVTX0lSUV9OQU1FRCgpDQoNCj4gPiBAQCAtMTQyLDcgKzI1Nyw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbWZkX2NlbGwgZGE5MDYyX2RldnNbXSA9IHsNCj4gPiAgCQkubmFt
ZQkJPSAiZGE5MDYyLXdhdGNoZG9nIiwNCj4gPiAgCQkubnVtX3Jlc291cmNlcwk9IEFSUkFZX1NJ
WkUoZGE5MDYyX3dkdF9yZXNvdXJjZXMpLA0KPiA+ICAJCS5yZXNvdXJjZXMJPSBkYTkwNjJfd2R0
X3Jlc291cmNlcywNCj4gPiAtCQkub2ZfY29tcGF0aWJsZSAgPSAiZGxnLGRhOTA2Mi13ZHQiLA0K
PiA+ICsJCS5vZl9jb21wYXRpYmxlICA9ICJkbGcsZGE5MDYyLXdhdGNoZG9nIiwNCj4gDQo+IFRo
aXMgc2hvdWxkIGJlIGEgc2VwYXJhdGUgY2hhbmdlLg0KDQpPay4gcmV2ZXJ0ZWQuDQoNCj4gPiBA
QCAtMjA4LDYgKzMyNCw3IEBAIHN0YXRpYyBpbnQgZGE5MDYyX2dldF9kZXZpY2VfdHlwZShzdHJ1
Y3QgZGE5MDYyICpjaGlwKQ0KPiA+ICAJCWRldl9lcnIoY2hpcC0+ZGV2LCAiQ2Fubm90IHJlYWQg
Y2hpcCBJRC5cbiIpOw0KPiA+ICAJCXJldHVybiAtRUlPOw0KPiA+ICAJfQ0KPiA+ICsNCj4gDQo+
IFNuZWFreSENCg0KUmVtb3ZlZCB0aGUgd2hpdGVzcGFjZS4NCg==
