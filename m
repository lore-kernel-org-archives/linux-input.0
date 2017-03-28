From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V6 4/7] mfd: da9061: MFD core support
Date: Tue, 28 Mar 2017 10:42:42 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD69ECA@SW-EX-MBX02.diasemi.com>
References: <539b8756120ab3558c906f7457e65f94dbe37425.1490608293.git.stwiss.opensource@diasemi.com>
 <201703272258.hWlipe1g%fengguang.wu@intel.com>
 <20170328082141.u2rgnhei5yhhzxdn@dell>
 <CAMuHMdX8WH959h50zGQCV7o4E249xBKDn_cVtRbFwYVsVebu9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdX8WH959h50zGQCV7o4E249xBKDn_cVtRbFwYVsVebu9w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Lee Jones <lee.jones@linaro.org>
Cc: kbuild test robot <lkp@intel.com>, Steve Twiss <stwiss.opensource@diasemi.com>, "kbuild-all@01.org" <kbuild-all@01.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

T24gMjggTWFyY2ggMjAxNyAwOTozNywgR2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIFY2IDQvN10gbWZkOiBkYTkwNjE6IE1GRCBjb3JlIHN1cHBvcnQNCj4g
DQo+IEhpIExlZSwNCj4gDQo+IE9uIFR1ZSwgTWFyIDI4LCAyMDE3IGF0IDEwOjIxIEFNLCBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPiB3cm90ZToNCj4gPj4gW2F1dG8gYnVpbGQgdGVz
dCBXQVJOSU5HIG9uIGxqb25lcy1tZmQvZm9yLW1mZC1uZXh0XQ0KPiA+PiBbYWxzbyBidWlsZCB0
ZXN0IFdBUk5JTkcgb24gdjQuMTEtcmM0IG5leHQtMjAxNzAzMjddDQo+ID4+IGJhc2U6ICAgaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbGVlL21mZC5naXQg
Zm9yLW1mZC1uZXh0DQo+ID4+IGNvbmZpZzogeDg2XzY0LXJhbmRjb25maWcteDAwOS0yMDE3MTMg
KGF0dGFjaGVkIGFzIC5jb25maWcpDQo+ID4+IGNvbXBpbGVyOiBnY2MtNiAoRGViaWFuIDYuMi4w
LTMpIDYuMi4wIDIwMTYwOTAxDQo+ID4+IHJlcHJvZHVjZToNCj4gPj4gICAgICAgICAjIHNhdmUg
dGhlIGF0dGFjaGVkIC5jb25maWcgdG8gbGludXggYnVpbGQgdHJlZQ0KPiA+PiAgICAgICAgIG1h
a2UgQVJDSD14ODZfNjQNCj4gPj4NCj4gPj4gQWxsIHdhcm5pbmdzIChuZXcgb25lcyBwcmVmaXhl
ZCBieSA+Pik6DQo+ID4+DQo+ID4+ICAgIGRyaXZlcnMvL21mZC9kYTkwNjItY29yZS5jOiBJbiBm
dW5jdGlvbiAnZGE5MDYyX2kyY19wcm9iZSc6DQo+ID4+ID4+IGRyaXZlcnMvL21mZC9kYTkwNjIt
Y29yZS5jOjg0NToyMTogd2FybmluZzogY2FzdCBmcm9tIHBvaW50ZXIgdG8gaW50ZWdlciBvZiBk
aWZmZXJlbnQgc2l6ZSBbLVdwb2ludGVyLXRvLWludC1jYXN0XQ0KPiA+PiAgICAgICBjaGlwLT5j
aGlwX3R5cGUgPSAoaW50KW1hdGNoLT5kYXRhOw0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAg
IF4NCj4gPg0KPiA+IFBsZWFzZSB1c2UgbG9uZ3Mgb3IgZW51bXMuDQo+IA0KPiBFbnVtcyB3b3Vs
ZCBzdGlsbCBnaXZlIGEgd2FybmluZyBvbiA2NC1iaXQuDQo+IFRoZSBzaW1wbGUgZml4IGlzIGNo
YW5nZSB0aGUgY2FzdCBmcm9tIChpbnQpIHRvICh1aW50cHRyX3QpLg0KDQpIaSBMZWUgYW5kIEdl
ZXJ0LA0KDQpIb3cgYWJvdXQgdGhpcz8gRml4IGJ5IHJlZGVmaW5pbmcgdGhlIGVudW0gY2hpcF90
eXBlIHRvIGJlIGFuIGludC4NClRoZW4sIGp1c3QgdXNlIHN1YnN0aXR1dGlvbjoNCiNkZWZpbmUg
Q09NUEFUX1RZUEVfREE5MDYxICAxDQojZGVmaW5lIENPTVBBVF9UWVBFX0RBOTA2MiAgMg0KDQpU
aGF0IHdvdWxkIGJlIHNpbXBsZS4NCkFyZSB0aGVyZSBhbnkgcmVhc29ucyB0aGlzIHdvdWxkIG5v
dCBiZSBhY2NlcHRhYmxlPw0KDQpSZWdhcmRzLA0KU3RldmUNCg==
