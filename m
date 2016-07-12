From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 4/4] ACPI / button: Add document for ACPI control
 method lid device restrictions
Date: Tue, 12 Jul 2016 07:06:00 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC02868@SHSMSX101.ccr.corp.intel.com>
References: <cover.1467717304.git.lv.zheng@intel.com>
	 <cover.1467875142.git.lv.zheng@intel.com>
	 <3f24a00df89f06661a64af6b4679a99bfff09aa7.1467875143.git.lv.zheng@intel.com>
	 <CAN+gG=G5p6ztJODQBBAF7MY0kBNGVpexY-+a8RQY9JKuY1AB1Q@mail.gmail.com>
	 <1AE640813FDE7649BE1B193DEA596E883BC02198@SHSMSX101.ccr.corp.intel.com>
 <1468234721.2277.35.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468234721.2277.35.camel@hadess.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

SGksDQoNCj4gRnJvbTogQmFzdGllbiBOb2NlcmEgW21haWx0bzpoYWRlc3NAaGFkZXNzLm5ldF0N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA0LzRdIEFDUEkgLyBidXR0b246IEFkZCBkb2N1bWVu
dCBmb3IgQUNQSSBjb250cm9sDQo+IG1ldGhvZCBsaWQgZGV2aWNlIHJlc3RyaWN0aW9ucw0KPiAN
Cj4gT24gTW9uLCAyMDE2LTA3LTExIGF0IDAzOjIwICswMDAwLCBaaGVuZywgTHYgd3JvdGU6DQo+
ID4NCj4gPHNuaXA+DQo+ID4gPiBUaGlzIHdvcnJpZXMgbWUgYXMgdGhlcmUgaXMgbm8gcGxhbiBh
ZnRlciAiRHVyaW5nIHRoZSBwZXJpb2QgdGhlDQo+ID4gPiB1c2Vyc3BhY2UgaGFzbid0IGJlZW4g
c3dpdGNoZWQgdG8gdXNlIHRoZSBuZXcgZXZlbnQiLg0KPiA+ID4NCj4gPiA+IEkgcmVhbGx5IGhv
cGUgeW91J2xsIGtlZXAgc2VuZGluZyBTV19MSUQgZm9yIHJlbGlhYmxlIExJRA0KPiA+ID4gcGxh
dGZvcm1zLA0KPiA+ID4gYW5kIG5vdCByZW1vdmUgaXQgZW50aXJlbHkgYXMgeW91IHdpbGwgYnJl
YWsgcGxhdGZvcm1zLg0KPiA+DQo+ID4gW0x2IFpoZW5nXQ0KPiA+IFdlIHdvbid0IHJlbW92ZSBT
V19MSUQgZnJvbSB0aGUga2VybmVsIDopLg0KPiA+DQo+ID4gQW5kIHdlIGhhdmVuJ3QgcmVtb3Zl
ZCBTV19MSUQgZnJvbSB0aGUgYWNwaSBidXR0b24gZHJpdmVyLg0KPiA+IFdlJ2xsIGp1c3Qgc3Rv
cCBzZW5kaW5nICJpbml0aWFsIGxpZCBzdGF0ZSIgZnJvbSBhY3BpIGJ1dHRvbiBkcml2ZXIsDQo+
ID4gaS5lLiwgdGhlIGJlaGF2aW9yIGNhcnJpZWQgb3V0IGJ5ICJidXR0b24ubGlkX2luaXRfc3Rh
dGU9aWdub3JlIi4NCj4gPg0KPiA+IE1heWJlIGl0IGlzIG5vdCBzdWZmaWNpZW50LCBhZnRlciB0
aGUgdXNlcnNwYWNlIGhhcyBiZWVuIGNoYW5nZWQgdG8NCj4gPiBzdXBwb3J0IHRoZSBuZXcgZXZl
bnQsIHdlIHNob3VsZCBzdG9wIHNlbmRpbmcgU1dfTElEIGZyb20gYWNwaSBidXR0b24NCj4gPiBk
cml2ZXIuDQo+IA0KPiBGb3IgdGhlIGFmZmVjdGVkIGRldmljZXM/IFN1cmUsIGJ1dCBJIGRvbid0
IHRoaW5rIHRoYXQncyBhIHJlYXNvbmFibGUNCj4gdGhpbmcgdG8gZG8gZm9yICJhbGwiIHRoZSBk
ZXZpY2VzLiBXZSBoYXZlIGEgbWFqb3JpdHkgb2YgbGFwdG9wcyB3aGVyZQ0KPiB0aGlzIGlzbid0
IGEgcHJvYmxlbSwgYW5kIGl0J3Mgbm90IGV2ZW4gYSBwcm9ibGVtIGFueSBtb3JlIG9uIG9uZSBv
Zg0KPiB0aGUgZGV2aWNlcyB0aGF0IHRyaWdnZXJlZCB0aGlzIGRpc2N1c3Npb24gKHRoZXJlJ3Mg
YSBwYXRjaCBmb3IgbWFrZQ0KPiB0aGUgTElEIHN0YXR1cyBtYXRjaCByZWFsaXR5IGZvciB0aGUg
U3VyZmFjZSAzKS4NCltMdiBaaGVuZ10gDQpJdCBsb29rcywgZXZlbiB3aXRoIHRoaXMgZml4ZWQs
IHRoZXJlIGFyZSB0YWJsZXMgbmV2ZXIgZ2VuZXJhdGluZyAibGlkIG9wZW4iIGV2ZW50Lg0KVGh1
cyB0aGUgbGlkIG5vdGlmaWNhdGlvbiBpcyBkZWZpbml0ZWx5IG5vdCBhICJzd2l0Y2ggZXZlbnQi
Lg0KDQpUaGFua3MgYW5kIGJlc3QgcmVnYXJkcw0KLUx2DQoNCg==
