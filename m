From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH V2 1/5] dt-bindings: fsl: scu: add scu power key binding
Date: Mon, 23 Sep 2019 02:31:56 +0000
Message-ID: <DB3PR0402MB391673C02411B57F815DE609F5850@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1567519424-32271-1-git-send-email-Anson.Huang@nxp.com>
 <20190922161347.GB1999@bug>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190922161347.GB1999@bug>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Andy Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "mripard@kernel.org" <mripard@kernel.org>, "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>
List-Id: linux-input@vger.kernel.org

SGksIFBhdmVsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAxLzVdIGR0LWJpbmRpbmdzOiBm
c2w6IHNjdTogYWRkIHNjdSBwb3dlciBrZXkgYmluZGluZw0KPiANCj4gSGkhDQo+IA0KPiA+IE5Y
UCBpLk1YOFFYUCBpcyBhbiBBUk12OCBTb0Mgd2l0aCBhIENvcnRleC1NNCBjb3JlIGluc2lkZSBh
cyBzeXN0ZW0NCj4gPiBjb250cm9sbGVyLCB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgaXMgaW4gY2hh
cmdlIG9mIHN5c3RlbSBwb3dlciwgY2xvY2sNCj4gPiBhbmQgcG93ZXIga2V5IGV2ZW50IGV0Yy4g
bWFuYWdlbWVudCwgTGludXgga2VybmVsIGhhcyB0byBjb21tdW5pY2F0ZQ0KPiA+IHdpdGggc3lz
dGVtIGNvbnRyb2xsZXIgdmlhIE1VIChtZXNzYWdlIHVuaXQpIElQQyB0byBnZXQgcG93ZXIga2V5
DQo+ID4gZXZlbnQsIGFkZCBiaW5kaW5nIGRvYyBmb3IgaS5NWCBzeXN0ZW0gY29udHJvbGxlciBw
b3dlciBrZXkgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFu
c29uLkh1YW5nQG54cC5jb20+DQo+IA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gQEAgLTE1Nyw2ICsxNTcs
MTUgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAgT3B0aW9uYWwgcHJvcGVydGllczoNCj4g
PiAgLSB0aW1lb3V0LXNlYzogY29udGFpbnMgdGhlIHdhdGNoZG9nIHRpbWVvdXQgaW4gc2Vjb25k
cy4NCj4gPg0KPiA+ICtQb3dlciBrZXkgYmluZGluZ3MgYmFzZWQgb24gU0NVIE1lc3NhZ2UgUHJv
dG9jb2wNCj4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4gKw0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICst
IGNvbXBhdGlibGU6IHNob3VsZCBiZToNCj4gPiArICAgICAgICAgICAgICAiZnNsLGlteDhxeHAt
c2MtcHdya2V5Ig0KPiA+ICsgICAgICAgICAgICAgIGZvbGxvd2VkIGJ5ICJmc2wsaW14LXNjLXB3
cmtleSI7DQo+ID4gKy0gbGludXgsa2V5Y29kZXM6IFNlZQ0KPiA+ICtEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaW5wdXQva2V5cy50eHQNCj4gDQo+IEFjdHVhbGx5IHRoZXJlJ3Mg
bm8gcmVhc29uIGZvciBoYXZpbmcgImxpbnV4LGtleWNvZGVzIiBwcm9wZXJ0eSB3aGVuIGl0IGlz
DQo+IGFsd2F5cyBhIHBvd2VyIGJ1dHRvbi4NClRoZSBsYXRlc3QgdmVyc2lvbiBvZiBwYXRjaCBh
bHJlYWR5IGNoYW5nZSB0aGUgY29tcGF0aWJsZSBuYW1lIHRvICotc2Mta2V5IHdoaWNoDQppcyBt
b3JlIGdlbmVyYWwgYXMga2V5IGRyaXZlciwgc28gdGhlICJsaW51eCxrZXljb2RlcyIgaXMgbmVl
ZGVkIG5vdyBmb3IgZHJpdmVyDQp0byBkZWZpbmUgdGhlIGtleSBmdW5jdGlvbi4NCg0KVGhhbmtz
LA0KQW5zb24gDQo=
