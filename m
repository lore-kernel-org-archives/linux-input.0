From: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v6 4/9] Input: goodix - write configuration data to
 device
Date: Fri, 25 Sep 2015 21:18:20 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0E9963@irsmsx105.ger.corp.intel.com>
References: <1442327483-19407-1-git-send-email-irina.tirdea@intel.com>
	 <1442327483-19407-5-git-send-email-irina.tirdea@intel.com>
 <1443192040.17020.26.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443192040.17020.26.camel-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFzdGllbiBOb2NlcmEg
W21haWx0bzpoYWRlc3NAaGFkZXNzLm5ldF0NCj4gU2VudDogMjUgU2VwdGVtYmVyLCAyMDE1IDE3
OjQxDQo+IFRvOiBUaXJkZWEsIElyaW5hOyBEbWl0cnkgVG9yb2tob3Y7IEFsZWtzZWkgTWFtbGlu
OyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1hcmsgUnV0bGFuZDsgUHVyZGls
YSwgT2N0YXZpYW47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgNC85XSBJbnB1dDogZ29vZGl4
IC0gd3JpdGUgY29uZmlndXJhdGlvbiBkYXRhIHRvIGRldmljZQ0KPiANCj4gT24gVHVlLCAyMDE1
LTA5LTE1IGF0IDE3OjMxICswMzAwLCBJcmluYSBUaXJkZWEgd3JvdGU6DQo+ID4gR29vZGl4IGRl
dmljZXMgY2FuIGJlIGNvbmZpZ3VyZWQgYnkgd3JpdGluZyBjdXN0b20gZGF0YSB0byB0aGUgZGV2
aWNlDQo+ID4gYXQNCj4gPiBpbml0LiBUaGUgY29uZmlndXJhdGlvbiBkYXRhIGlzIHJlYWQgd2l0
aCByZXF1ZXN0X2Zpcm13YXJlIGZyb20NCj4gPiAiZ29vZGl4XzxpZD5fY2ZnLmJpbiIsIHdoZXJl
IDxpZD4gaXMgdGhlIHByb2R1Y3QgaWQgcmVhZCBmcm9tIHRoZQ0KPiA+IGRldmljZQ0KPiA+IChl
LmcuOiBnb29kaXhfOTExX2NmZy5iaW4gZm9yIEdvb2RpeCBHVDkxMSwgZ29vZGl4XzkyNzFfY2Zn
LmJpbiBmb3INCj4gPiBHVDkyNzEpLg0KPiA+DQo+ID4gVGhlIGNvbmZpZ3VyYXRpb24gaW5mb3Jt
YXRpb24gaGFzIGEgc3BlY2lmaWMgZm9ybWF0IGRlc2NyaWJlZCBpbiB0aGUNCj4gPiBHb29kaXgN
Cj4gPiBkYXRhc2hlZXQuIEl0IGluY2x1ZGVzIFgvWSByZXNvbHV0aW9uLCBtYXhpbXVtIHN1cHBv
cnRlZCB0b3VjaA0KPiA+IHBvaW50cywNCj4gPiBpbnRlcnJ1cHQgZmxhZ3MsIHZhcmlvdXMgc2Vz
aXRpdml0eSBmYWN0b3JzIGFuZCBzZXR0aW5ncyBmb3IgYWR2YW5jZWQNCj4gDQo+IHNlbnNpdGl2
aXR5Lg0KDQpXaWxsIGZpeCB0aGlzIGluIG5leHQgdmVyc2lvbiBvZiB0aGUgcGF0Y2hlcy4gSSB3
aWxsIHdhaXQgZm9yIHlvdSByZXBseSBvbg0KdGhlIGdwaW8gaXNzdWUgYmVmb3JlIHNlbmRpbmcg
YSBuZXcgdmVyc2lvbi4NCg0KVGhhbmtzLA0KSXJpbmENCg0K
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
