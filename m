From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V1 1/2] input: misc: da9063: OnKey driver
Date: Thu, 9 Apr 2015 10:12:07 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B2139E2@SW-EX-MBX02.diasemi.com>
References: <cover.1428504804.git.stwiss.opensource@diasemi.com>
	 <0219212ab4e2b01256f2dac92d9a0d848c44197a.1428504804.git.stwiss.opensource@diasemi.com>
 <1428569273.14000.17.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428569273.14000.17.camel@x220>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-input@vger.kernel.org

T24gMDkgQXByaWwgMjAxNSAwOTo0OCBQYXVsIEJvbGxlIHdyb3RlOg0KDQo+ID4gVGhpcyBwYXRj
aCBpcyBkZXBlbmRlbnQgb24gUEFUQ0ggVjEgMi8yDQo+ICAgICBUaGlzIHBhdGNoIGlzIGRlcGVu
ZGVudCBvbiBQQVRDSCBWMSAxLzINCj4gV2hpY2ggbWFrZXMgaXQgYWxsIHJhdGhlciBjb25mdXNp
bmcuDQoNCkl0IGlzIGEgYml0IGNpcmN1bGFyLCBJJ2xsIHRha2UgdGhhdCBvdXQgZm9yIHRoZSBu
ZXh0IHBhdGNoDQoNCj4gPiArKysgYi9kcml2ZXJzL2lucHV0L21pc2MvZGE5MDYzLW9ua2V5LmMN
Cj4gPiBAQCAtMCwwICsxLDIyNyBAQA0KPiA+ICsvKiBkYTkwNjMtb25rZXkuYyAtIE9ua2V5IGRl
dmljZSBkcml2ZXIgZm9yIERBOTA2Mw0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTMgIERpYWxv
ZyBTZW1pY29uZHVjdG9yIEx0ZC4NCj4gPiArICoNCj4gPiArICogVGhpcyBsaWJyYXJ5IGlzIGZy
ZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcg0KPiA+ICsgKiBtb2Rp
ZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgTGlicmFyeSBHZW5lcmFsIFB1YmxpYw0K
PiA+ICsgKiBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0
aW9uOyBlaXRoZXINCj4gPiArICogdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvciAoYXQgeW91
ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLg0KPiA+ICsgKg0KPiA+ICsgKiBUaGlzIGxpYnJh
cnkgaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCj4g
PiArICogYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQg
d2FycmFudHkgb2YNCj4gPiArICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFS
VElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQ0KPiBHTlUNCj4gPiArICogTGlicmFyeSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQo+ID4gKyAqLw0KPiANCj4gVGhpcyBz
dGF0ZXMgdGhlIGxpY2Vuc2UgaXMgR1BMIHYyIG9yIGxhdGVyLg0KPiANCj4gPiArTU9EVUxFX0xJ
Q0VOU0UoIkdQTCB2MiIpOw0KPiANCj4gQW5kIChhY2NvcmRpbmcgdG8gaW5jbHVkZS9saW51eC9t
b2R1bGUuaCkgdGhpcyBzdGF0ZXMgdGhlIGxpY2Vuc2UgaXMNCj4gKGp1c3QpIEdQTCB2Mi4NCg0K
QWgsIEknbGwgZml4IHRoYXQgZm9yIHRoZSBmdXR1cmUuDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1l
bnRzLA0KUmVnYXJkcywNClN0ZXZlDQo=
