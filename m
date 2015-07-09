From: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH RFC V1 0/3] da9062: Add DA9062 RTC support using the
 existing DA9063 RTC driver
Date: Thu, 9 Jul 2015 08:42:16 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B23FDDA@SW-EX-MBX02.diasemi.com>
References: <cover.1436427954.git.stwiss.opensource@diasemi.com>
 <CAMuHMdU_AUZ9nxo25NeaFq1MeeSDZErqkNnDtXsdr7=jLm1kTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdU_AUZ9nxo25NeaFq1MeeSDZErqkNnDtXsdr7=jLm1kTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

T24gMDkgSnVseSAyMDE1IDA5OjAyLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQoNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCBSRkMgVjEgMC8zXSBkYTkwNjI6IEFkZCBEQTkwNjIgUlRDIHN1cHBv
cnQgdXNpbmcgdGhlDQo+IGV4aXN0aW5nIERBOTA2MyBSVEMgZHJpdmVyDQo+IA0KPiBIaSBTdGV2
ZSwNCj4gDQo+IE9uIFRodSwgSnVsIDksIDIwMTUgYXQgOTo0NSBBTSwgUyBUd2lzcyA8c3R3aXNz
Lm9wZW5zb3VyY2VAZGlhc2VtaS5jb20+DQo+IHdyb3RlOg0KPiA+IEZyb206IFMgVHdpc3MgPHN0
d2lzcy5vcGVuc291cmNlQGRpYXNlbWkuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXQgYWRk
cyBSVEMgc3VwcG9ydCBmb3IgdGhlIERpYWxvZyBEQTkwNjIgUG93ZXIgTWFuYWdlbWVudCBJQy4N
Cj4gPiBDaGFuZ2VzIGFyZSBtYWRlIHRvIHRoZSBleGlzdGluZyBEQTkwNjMgUlRDIGNvbXBvbmVu
dCBzbyB0aGF0IGZ1bmN0aW9uYWxpdHkNCj4gPiBpbiB0aGlzIGRldmljZSBkcml2ZXIgY2FuIGJl
IHJlLXVzZWQgdG8gc3VwcG9ydCB0aGUgREE5MDYyIFJUQy4NCj4gDQo+IFsuLi5dDQo+IA0KPiA+
IFMgVHdpc3MgKDMpOg0KPiA+ICAgbWZkOiBkYTkwNjI6IFN1cHBvcnQgZm9yIHRoZSBEQTkwNjMg
UlRDIGluIHRoZSBEQTkwNjIgY29yZQ0KPiANCj4gIkRBOTA2MiBSVEMiPw0KPiANCg0KSGkgR2Vl
cnQsDQoNCkl0J3MgdGhlIHN1cHBvcnQgZm9yIHRoZSAiREE5MDYzIFJUQyAqZHJpdmVyKiBpbiB0
aGUgREE5MDYyIE1GRCBkcml2ZXIgY29yZSIuDQoNCkknbSByZS13b3JraW5nIHRoZSBEQTkwNjMg
UlRDIGRyaXZlciB0byBzdXBwb3J0IERBOTA2MiBSVEMgaGFyZHdhcmUuIFRoaXMgd2lsbCBtYWtl
DQp0aGUgbmFtZSAiREE5MDYzIFJUQyBkcml2ZXIiIGludGVyY2hhbmdlYWJsZSB3aXRoICJEQTkw
NjIgUlRDIGRyaXZlciIsIGJlY2F1c2UgaWYgdGhpcw0KcGF0Y2ggZ29lcyB0aHJvdWdoIHRoZXkg
d2lsbCBib3RoIGJlIHVzaW5nIHRoZSBvcmlnaW5hbCAiREE5MDYzIFJUQyBkcml2ZXIiLg0KDQpD
b25mdXNlZD8gIDotLw0KDQpJIHN1cHBvc2UgSSBjb3VsZCBhbHNvIGhhdmUgY2FsbGVkIHRoaXMg
cGF0Y2ggInN1cHBvcnQgZm9yIHRoZSBEQTkwNjIgUlRDIEgvVyBpbiB0aGUNCkRBOTA2MiBNRkQg
ZHJpdmVyIGNvcmUiLg0KDQpUaGlzIGNvbWVzIGZyb20gYSBwcmV2aW91cyB0aHJlYWQgaGVyZToN
Cmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE1LzUvMTMvNDA2DQpodHRwczovL2xrbWwub3JnL2xr
bWwvMjAxNS81LzEzLzUyOA0KDQpSZWdhcmRzLA0KU3RldmUNCg0KWy4uLl0NCg==
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
