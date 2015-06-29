From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V3 1/4] mfd: da9062: DA9062 MFD core driver
Date: Mon, 29 Jun 2015 08:01:36 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B233463@SW-EX-MBX02.diasemi.com>
References: <cover.1432041031.git.stwiss.opensource@diasemi.com>
 <ecf72b79429e6758111a908fd1ded29c0b96da15.1432041031.git.stwiss.opensource@diasemi.com>
 <20150526161024.GQ11677@x1>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22F4C4@SW-EX-MBX02.diasemi.com>
 <20150611085653.GG2982@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.107]:38498 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752075AbbF2IBm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2015 04:01:42 -0400
In-Reply-To: <20150611085653.GG2982@x1>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: LINUXKERNEL <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>

T24gMTEgSnVuZSAyMDE1IDA5OjU3LCBMZWUgSm9uZXMgd3JvdGU6DQoNCj4gVG86IE9wZW5zb3Vy
Y2UgW1N0ZXZlIFR3aXNzXQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDEvNF0gbWZkOiBkYTkw
NjI6IERBOTA2MiBNRkQgY29yZSBkcml2ZXINCj4gDQo+ID4gPiA+ID4gU3RldmUgVHdpc3Mgd3Jv
dGU6DQo+ID4gPiA+ID4gKyNkZWZpbmUgREE5MDYyQUFfUEFHRV9TSElGVAkJMA0KPiA+ID4gPiA+
ICsjZGVmaW5lIERBOTA2MkFBX1BBR0VfTUFTSwkJKDB4M2YgPDwgMCkNCj4gPiA+ID4gPiArI2Rl
ZmluZSBEQTkwNjJBQV9XUklURV9NT0RFX1NISUZUCTYNCj4gPiA+ID4gPiArI2RlZmluZSBEQTkw
NjJBQV9XUklURV9NT0RFX01BU0sJKDB4MDEgPDwgNikNCj4gPiA+ID4NCj4gPiA+ID4gTGVlIEpv
bmVzIHdyb3RlOg0KPiA+ID4gPiBGb3IgMSA8PCBYLCB5b3Ugc2hvdWxkIHVzZSBCSVQoWCkuDQo+
ID4gPg0KPiA+ID4gU3RldmUgVHdpc3Mgd3JvdGU6DQo+ID4gPiBUaGUgd2hvbGUgb2YgdGhpcyBm
aWxlIGlzIGF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIGJ5IG91ciBoYXJkd2FyZSBkZXNpZ25lcnMN
Cj4gPiA+IEkgd291bGQgcHJlZmVyIGl0IGlmIHRoZSByZWdpc3RlciBkZWZpbml0aW9ucyBhbmQg
Yml0IGZpZWxkcyBhcmUgbm90IGFsdGVyZWQgWy4uLl0NCg0KWy4uLl0NCg0KPiBMZWUgSm9uZXMg
d3JvdGU6DQo+IFRvIGJlIGhvbmVzdCwgaXQncyBwcm9iYWJseSBub3QgYSBibG9ja2VyIGZvciBh
Y2NlcHRhbmNlLCBidXQgaWYgc29tZW9uZQ0KPiB3cml0ZXMgYSBwYXRjaCBuZXh0IHdlZWsgdG8g
Y2hhbmdlIGFsbCBvZiB0aGUgKDB4MDEgPDwgWCkgbGluZXMgdG8NCj4gc3RhcnQgdXNpbmcgdGhl
IEJJVCgpIG1hY3JvLCBJIHdpbGwgYWNjZXB0IGl0LiAgQmV0dGVyIHRvIGluZmx1ZW5jZWQNCj4g
eW91ciBndXlzIHNvIHlvdSBhcmUgbm90IG92ZXJseSBpbmNvbnZlbmllbmNlZC4NCj4gRldJVywg
d2hlbiB1cHN0cmVhbWluZyBjb2RlLCB0aGUgZXhjdXNlICJzb21lb25lIGVsc2Ugd3JvdGUgaXQi
LCBoYXMNCj4gbmV2ZXIgYmVlbiBhIGdvb2Qgb25lIHRvIHVzZSBvbiB0aGUgbGlzdHMuICAgQmVs
aWV2ZSBtZSwgSSd2ZQ0KPiB0cmllZC4gOykNCg0KSGkgTGVlLA0KDQpEZXBlbmRpbmcgb24geW91
ciBuZXh0IHN0ZXAgLi4NCkkgY2FuIGVpdGhlciBzZW5kIGEgcGF0Y2ggdG8gdGhpcyBub3cgb3Ig
d2FpdCB1bnRpbCB5b3UgaGF2ZSByZXZpZXdlZCB0aGUgTUZEDQpjb3JlOiBpZiB0aGVyZSBhcmUg
YW55IGZ1cnRoZXIgY29tbWVudHMgb24gdGhpcywgSSBjYW4gdXBkYXRlIHRoZSBzdWJtaXNzaW9u
DQpyZXRyb3NwZWN0aXZlbHkuDQoNClJlZ2FyZHMsDQpTdGV2ZQ0K
