From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH V2 1/5] dt-bindings: fsl: scu: add scu power key binding
Date: Mon, 23 Sep 2019 02:34:07 +0000
Message-ID: <DB3PR0402MB3916F48DA2A16E57C624432BF5850@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1567519424-32271-1-git-send-email-Anson.Huang@nxp.com>
 <20190922161415.GD1999@bug>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190922161415.GD1999@bug>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Andy Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "mripard@kernel.org" <mripard@kernel.org>, "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>
List-Id: linux-input@vger.kernel.org

SGksIFBhdmVsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAxLzVdIGR0LWJpbmRpbmdzOiBm
c2w6IHNjdTogYWRkIHNjdSBwb3dlciBrZXkgYmluZGluZw0KPiANCj4gT24gVHVlIDIwMTktMDkt
MDMgMTA6MDM6NDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IE5YUCBpLk1YOFFYUCBpcyBhbiBB
Uk12OCBTb0Mgd2l0aCBhIENvcnRleC1NNCBjb3JlIGluc2lkZSBhcyBzeXN0ZW0NCj4gPiBjb250
cm9sbGVyLCB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgaXMgaW4gY2hhcmdlIG9mIHN5c3RlbSBwb3dl
ciwgY2xvY2sNCj4gPiBhbmQgcG93ZXIga2V5IGV2ZW50IGV0Yy4gbWFuYWdlbWVudCwgTGludXgg
a2VybmVsIGhhcyB0byBjb21tdW5pY2F0ZQ0KPiA+IHdpdGggc3lzdGVtIGNvbnRyb2xsZXIgdmlh
IE1VIChtZXNzYWdlIHVuaXQpIElQQyB0byBnZXQgcG93ZXIga2V5DQo+ID4gZXZlbnQsIGFkZCBi
aW5kaW5nIGRvYyBmb3IgaS5NWCBzeXN0ZW0gY29udHJvbGxlciBwb3dlciBrZXkgZHJpdmVyLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSBWMToNCj4gPiAJLSByZW1vdmUgIndha2V1cC1z
b3VyY2UiIHByb3BlcnR5LCBhcyBpdCBpcyBOT1QgbmVlZGVkIGZvciBTQ1UNCj4gaW50ZXJydXB0
Ow0KPiA+IAktIHJlbW92ZSAic3RhdHVzIiBpbiBleGFtcGxlLg0KPiA+IC0tLQ0KPiA+ICAuLi4v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0ICAgICAgICAgIHwg
MTQNCj4gKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiA+IGluZGV4IGMx
NDlmYWQuLmY5M2UyZTQgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiA+IEBA
IC0xNTcsNiArMTU3LDE1IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gIE9wdGlvbmFsIHBy
b3BlcnRpZXM6DQo+ID4gIC0gdGltZW91dC1zZWM6IGNvbnRhaW5zIHRoZSB3YXRjaGRvZyB0aW1l
b3V0IGluIHNlY29uZHMuDQo+ID4NCj4gPiArUG93ZXIga2V5IGJpbmRpbmdzIGJhc2VkIG9uIFND
VSBNZXNzYWdlIFByb3RvY29sDQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICsNCj4gPiArUmVxdWlyZWQgcHJvcGVy
dGllczoNCj4gPiArLSBjb21wYXRpYmxlOiBzaG91bGQgYmU6DQo+ID4gKyAgICAgICAgICAgICAg
ImZzbCxpbXg4cXhwLXNjLXB3cmtleSINCj4gPiArICAgICAgICAgICAgICBmb2xsb3dlZCBieSAi
ZnNsLGlteC1zYy1wd3JrZXkiOw0KPiA+ICstIGxpbnV4LGtleWNvZGVzOiBTZWUNCj4gPiArRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L2tleXMudHh0DQo+IA0KPiBOb3Rl
IHlvdSBoYXZlIGtleWNvZGVfc18gaGVyZSwgYnV0IGtleWNvZGUgaW4gdGhlIGV4YW1wbGUgYW5k
IGluIHRoZSBkdHMNCj4gcGF0Y2guDQoNCk5PVCBxdWl0ZSB1bmRlcnN0YW5kIHlvdXIgcG9pbnQs
IGNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBtb3JlIGRldGFpbHM/DQoNClRoYW5rcywNCkFuc29u
DQo=
