From: Christopher Heiny <Cheiny@synaptics.com>
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
Date: Tue, 4 Jun 2019 05:19:59 +0000
Message-ID: <580b73847333fa1866caaccc959bf8735b4f7524.camel@synaptics.com>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
         <17cd420ea32a9787c56ba25e36e7661541c2f65f.camel@synaptics.com>
         <a0f21198-5715-8858-8368-51e43092181e@canonical.com>
         <acd07f4d-1602-46c5-c486-c917f1868b59@canonical.com>
         <f4f7265d9ad06726bb2ef12ab6b7529d2fb06165.camel@synaptics.com>
         <9321df87-5bc5-0c75-2815-f8602ecf9d86@canonical.com>
         <2995b27a-9ec8-eebe-78b6-2d3bf5098af8@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2995b27a-9ec8-eebe-78b6-2d3bf5098af8@canonical.com>
Content-Language: en-US
Content-ID: <638EC2AFA5D20F40A4D2594806E4675A@namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

T24gVHVlLCAyMDE5LTA2LTA0IGF0IDEwOjQ1ICswODAwLCBBYXJvbiBNYSB3cm90ZToNCj4gSGkg
Q2hyaXN0b3BoZXI6DQo+IA0KPiBIYXZlIGdvdCB0aW1lIHRvIHJldmlldyB0aGVzZSAyIHBhdGNo
ZXM/DQo+IFVzZXJzIHJlcG9ydGVkIGl0IHdvcmtzIGZpbmUgc2luY2UgSSBzZW50IG91dCB0aGlz
IHBhdGNoLg0KDQpIaSBBYXJvbiwNCg0KSSd2ZSBiZWVuIHBva2luZyBhcm91bmQgd2l0aCB0aGlz
IG9mZiBhbmQgb24uICBVbmZvcnR1bmF0ZWx5LCBtb3JlIG9mZg0KdGhhbiBvbiA6LSggYnV0IGhl
cmUncyBteSBjdXJyZW50IHRha2U6DQoNCnJtaV9kcml2ZXJfc2V0X2lycV9iaXRzKCkgaXNuJ3Qg
Z29pbmcgdG8gYmUgY2FsbGVkIGFsbCB0aGF0IG9mdGVuLCBhbmQNCml0J3Mgbm90IGdvaW5nIHRv
IGJlIGNhbGxlZCBhdCBhbGwgZHVyaW5nIG5vcm1hbCBvcGVyYXRpb24sIHdoaWNoIGlzDQp3aGVy
ZSB0aGUgbW9zdCBzZXJpb3VzIHByb2JsZW0gd291bGQgb2NjdXIuDQoNCkkgaGF2ZW4ndCBlbnRp
cmVseSBjb252aW5jZWQgbXlzZWxmIHRoYXQgdGhlcmUgY291bGRuJ3QgYmUgYSBwcm9ibGVtDQpk
dXJpbmcgcmVwZWF0ZWQgc3BvbnRhbmVvdXMgZGV2aWNlIHJlc2V0cyAoZm9yIGV4YW1wbGUsIGR1
ZSB0byBFU0QsIGENCmRvZGd5IGNoYXJnZXIsIG9yIGZpcm13YXJlIGJ1ZywgYW1vbmcgb3RoZXIg
dGhpbmdzKS4gIE9uIHRoZSBvdGhlcg0KaGFuZCwgYWxsIHRoZSBzY2VuYXJpb3MgSSBoYXZlIGNv
bWUgdXAgd2l0aCBhcmUgYm90aCB1bmxpa2VseSBhbmQgc28NCmNvbnRyaXZlZCB0aGF0IHRoZSBz
eXN0ZW0gaXMgcHJvYmFibHkgaG9zZWQgcmVnYXJkbGVzcyBvZiB3aGF0IHdlIGRvIGluDQp0aGUg
ZHJpdmVyLg0KDQpHaXZlbiB0aGF0LCBJJ20gd2lsbGluZyB0byBhY2NlcHQgdGhlIHBhdGNoIGFz
IGlzLg0KDQoJCQkJCUNoZWVycywNCgkJCQkJCUNocmlzDQoNCg0KDQoNCg0KDQoNCj4gDQo+IFRo
YW5rcywNCj4gQWFyb24NCj4gDQo+IE9uIDQvMy8xOSA5OjU4IFBNLCBBYXJvbiBNYSB3cm90ZToN
Cj4gPiBTdXJlLCB0YWtlIHlvdXIgdGltZSwgaWYgeW91IGhhdmUgYW55IHF1ZXN0aW9ucyBsZXQg
bWUga25vdyBwbGVhc2UuDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IEFhcm9uDQoNCg0K
