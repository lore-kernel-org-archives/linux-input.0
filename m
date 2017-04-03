From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V7 4/7] mfd: da9061: MFD core support
Date: Mon, 3 Apr 2017 15:56:22 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD6B207@SW-EX-MBX02.diasemi.com>
References: <cover.1490712213.git.stwiss.opensource@diasemi.com>
 <8987877cc54940358c5b7a65ca003cedc5586f0d.1490712213.git.stwiss.opensource@diasemi.com>
 <20170403141214.q6ndii6c47pqfqx6@dell>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD6B183@SW-EX-MBX02.diasemi.com>
 <20170403143049.qyi4dagwi4cdenok@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.171]:55350 "EHLO
        mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753936AbdDCP4j (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 3 Apr 2017 11:56:39 -0400
In-Reply-To: <20170403143049.qyi4dagwi4cdenok@dell>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>

T24gMDMgQXByaWwgMjAxNyAxNTozMSwgTGVlIEpvbmVzIHdyb3RlOg0KDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggVjcgNC83XSBtZmQ6IGRhOTA2MTogTUZEIGNvcmUgc3VwcG9ydA0KPiANCj4gT24g
TW9uLCAwMyBBcHIgMjAxNywgU3RldmUgVHdpc3Mgd3JvdGU6DQo+ID4gT24gMDMgQXByaWwgMjAx
NyAxNToxMiwgTGVlIEpvbmVzIHdyb3RlOg0KPiA+DQo+ID4gPiA+IEBAIC00NzUsNyArODU1LDI1
IEBAIHN0YXRpYyBpbnQgZGE5MDYyX2kyY19wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqaTJjLA0K
PiA+ID4gPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+ID4gIAl9DQo+ID4gPiA+DQo+ID4gPiA+
IC0JY2hpcC0+cmVnbWFwID0gZGV2bV9yZWdtYXBfaW5pdF9pMmMoaTJjLCAmZGE5MDYyX3JlZ21h
cF9jb25maWcpOw0KPiA+ID4gPiArCXN3aXRjaCAoY2hpcC0+Y2hpcF90eXBlKSB7DQo+ID4gPiA+
ICsJY2FzZShDT01QQVRfVFlQRV9EQTkwNjEpOg0KPiA+ID4NCj4gPiA+IEJyYWNrZXRzIGFyb3Vu
ZCB0aGUgY2FzZSB2YWx1ZT8NCj4gPiA+DQo+ID4gPiBUaGF0J3MgYSBuZXcgb25lIG9uIG1lLg0K
PiA+DQo+ID4gSG0uIERvIHlvdSB3YW50IG1lIHRvIHJlc2VuZCBpdCB3aXRob3V0IGJyYWNlcz8N
Cj4gDQo+IFllcyBwbGVhc2UuICBBbmQgYSBzcGFjZSBhZnRlciB0aGUgJ2Nhc2UnLg0KDQpIaSBM
ZWUsDQoNCkkgaGF2ZSByZXNlbnQgUEFUQ0ggVjcgdG8gY2hhbmdlICJjYXNlKFgpOiIgdG8gYmUg
ImNhc2UgWDoiLg0KLSBSZW1vdmVkIGJyYWNrZXRzIHN1cnJvdW5kaW5nIGNhc2Ugc3RhdGVtZW50
cyBmb3INCiAgICBjYXNlIENPTVBBVF9UWVBFX0RBOTA2MToNCiAgICBjYXNlIENPTVBBVF9UWVBF
X0RBOTA2MjoNCg0KTmV3IHBhdGNoIGlzIGhlcmU6DQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAx
Ny80LzMvNDYyDQoNClRoZSBwYXRjaCBpdCBpcyBjYWxsZWQgYnkgdGhlIHNhbWUgdGl0bGUgIltQ
QVRDSCBWNyA0LzddIG1mZDogZGE5MDYxOiBNRkQgY29yZSBzdXBwb3J0Ii4NCkkndmUgbm90IHVw
ZGF0ZWQgdGhlIHdob2xlIHBhdGNoLXNldCBvciBjaGFuZ2VkIHRoZSBwYXRjaCB2ZXJzaW9uIG51
bWJlciBmcm9tIFY3Lg0KDQpSZWdhcmRzLA0KU3RldmUNCg==
