From: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH V4 3/3] mfd: da9063: MFD support for OnKey driver
Date: Wed, 13 May 2015 10:47:21 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22A375@SW-EX-MBX02.diasemi.com>
References: <cover.1431437466.git.stwiss.opensource@diasemi.com>
 <81dec245f0d1a3a0713e6e2966d2278e422208f2.1431437466.git.stwiss.opensource@diasemi.com>
 <20150513103442.GG3394@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150513103442.GG3394@x1>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

T24gMTMgTWF5IDIwMTUgMTE6MzUgTGVlIEpvbmVzIHdyb3RlOg0KDQo+ID4gRnJvbTogU3RldmUg
VHdpc3MgPHN0d2lzcy5vcGVuc291cmNlQGRpYXNlbWkuY29tPg0KPiA+DQo+ID4gQWRkIE1GRCBz
dXBwb3J0IGZvciB0aGUgREE5MDYzIE9uS2V5IGRyaXZlcg0KPiA+DQo+ID4gVGhlIGZ1bmN0aW9u
IGRhOTA2M19jbGVhcl9mYXVsdF9sb2coKSBpcyBhZGRlZCB0byBtaXRpZ2F0ZSB0aGUgY2FzZSBv
ZiBhDQo+ID4gaGFyZHdhcmUgcG93ZXItY3V0IGFmdGVyIGEgbG9uZy1sb25nIE9uS2V5IHByZXNz
LiBBbHRob3VnaCB0aGVyZSBpcyBubw0KPiA+IHNvZnR3YXJlIGludGVydmVudGlvbiBpbiB0aGlz
IGNhc2UgKGJ5IGRlZmluaXRpb24pIHN1Y2ggYSBzaHV0ZG93biB3b3VsZA0KPiA+IGNhdXNlIHBl
cnNpc3RlbnQgaW5mb3JtYXRpb24gd2l0aGluIHRoZSBEQTkwNjMgRkFVTFRfTE9HIHRoYXQgd291
bGQgYmUNCj4gPiBhdmFpbGFibGUgZHVyaW5nIHRoZSBuZXh0IGRldmljZSByZXN0YXJ0Lg0KPiA+
DQo+ID4gQ2xlYXJhbmNlIG9mIHRoaXMgcGVyc2lzdGVudCByZWdpc3RlciBtdXN0IGJlIGNvbXBs
ZXRlZCBhZnRlciBzdWNoIGENCj4gPiBoYXJkd2FyZSBwb3dlci1jdXQgb3BlcmF0aW9uIGhhcyBo
YXBwZW5lZCBzbyB0aGF0IHRoZSBGQVVMVF9MT0cgZG9lcyBub3QNCj4gPiBjb250aW51ZSB3aXRo
IHByZXZpb3VzIHZhbHVlcy4gVGhlIGNsZWFyYW5jZSBmdW5jdGlvbiBoYXMgYmVlbiBhZGRlZCBo
ZXJlDQo+ID4gaW4gdGhlIGtlcm5lbCBkcml2ZXIgYmVjYXVzZSB3aXBpbmcgdGhlIGZhdWx0LWxv
ZyBjYW5ub3QgYmUgY291bnRlZCBvbg0KPiA+IG91dHNpZGUgdGhlIExpbnV4IGtlcm5lbC4NCj4g
Pg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RldmUgVHdpc3MgPHN0d2lzcy5vcGVuc291cmNl
QGRpYXNlbWkuY29tPg0KPiA+DQoNClsuLi5dDQoNCj4gPiAgZHJpdmVycy9tZmQvZGE5MDYzLWNv
cmUuYyAgICAgICAgfCA1NA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIGluY2x1ZGUvbGludXgvbWZkL2RhOTA2My9wZGF0YS5oIHwgIDEgKw0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKykNCj4gDQo+IEknbGwgd2FpdCB0byBzZWUg
d2hhdCBEbWl0cnkgaGFzIHRvIHNheSBiZWZvcmUgYXBwbHlpbmcsIGJ1dCBmb3IgbXkNCj4gb3du
IHJlZmVyZW5jZToNCg0KVW5kZXJzdG9vZC4NClRoYW5rIHlvdS4NCg0KPiBBY2tlZC1ieTogTGVl
IEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4NCg0KVGhhbmtzIGZvciB0aGlzIEFjay4NCkFu
ZCBmb3IgW1BBVENIIFY0IDIvM10gZGV2aWNldHJlZTogQWRkIGJpbmRpbmdzIGZvciBEQTkwNjMg
T25LZXkNCg0KUmVnYXJkcywNClN0ZXZlDQoNCg==
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
