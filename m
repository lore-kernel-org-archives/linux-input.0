From: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH V3 3/3] devicetree: da9062: Add device tree bindings for
 DA9062 OnKey
Date: Tue, 28 Jul 2015 07:44:36 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B25C564@SW-EX-MBX02.diasemi.com>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
 <20150727224300.GG3613@dtor-ws> <20150728054024.GA4558@dtor-ws>
 <20150728074234.GM21114@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150728074234.GM21114@x1>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

DQoNCk9uIDI4IEp1bHkgMjAxNSAwODo0MyBMZWUgSm9uZXMgd3JvdGU6DQo+IFRvOiBEbWl0cnkg
VG9yb2tob3YNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMyAzLzNdIGRldmljZXRyZWU6IGRhOTA2
MjogQWRkIGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciBEQTkwNjIgT25LZXkNCj4gDQo+IE9uIE1v
biwgMjcgSnVsIDIwMTUsIERtaXRyeSBUb3Jva2hvdiB3cm90ZToNCj4gDQo+ID4gT24gTW9uLCBK
dWwgMjcsIDIwMTUgYXQgMDM6NDM6MDBQTSAtMDcwMCwgRG1pdHJ5IFRvcm9raG92IHdyb3RlOg0K
PiA+ID4gT24gVGh1LCBKdWwgMjMsIDIwMTUgYXQgMDU6MTc6NDFQTSArMDEwMCwgUyBUd2lzcyB3
cm90ZToNCj4gPiA+ID4gRnJvbTogUyBUd2lzcyA8c3R3aXNzLm9wZW5zb3VyY2VAZGlhc2VtaS5j
b20+DQo+ID4gPiA+DQo+ID4gPiA+IEFkZCBkZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgdGhlIERB
OTA2MiBPbktleSBkcml2ZXIgY29tcG9uZW50DQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFN0ZXZlIFR3aXNzIDxzdHdpc3Mub3BlbnNvdXJjZUBkaWFzZW1pLmNvbT4NCj4gPiA+ID4N
Cj4gPiA+ID4gLS0tDQo+ID4gPiA+IENoYW5nZXMgaW4gVjM6DQo+ID4gPiA+ICAtIENoaWxkIGRy
aXZlciBzcGVjaWZpY3Mgc2VwYXJhdGVkIG91dCBpbnRvIHNlcGFyYXRlIGRvY3VtZW50DQo+ID4g
PiA+ICAgIGluIHRoaXMgY2FzZSAuLi9pbnB1dC9kYTkwNjItb25rZXkudHh0DQo+ID4gPiA+IENo
YW5nZXMgaW4gVjI6DQo+ID4gPiA+ICAtIE5vIGNoYW5nZQ0KPiA+ID4gPg0KPiA+ID4gPiBUaGlz
IHBhdGNoIGFwcGxpZXMgYWdhaW5zdCBsaW51eC1uZXh0IGFuZCBuZXh0LTIwMTUwNzA4DQo+ID4g
PiA+DQo+ID4gPiA+DQo+ID4gPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC9kYTkw
NjItb25rZXkudHh0ICAgICB8IDM2DQo+ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4g
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvZGE5MDYyLnR4dCAgIHwgIDMg
KysNCj4gPiA+DQo+ID4gPiBJIGRyb3BwZWQgYml0cyBmb3IgbWZkL2RhOTA2Mi50eHQsIGNoYW5n
ZWQgdG8gbWVudGlvbiBib3RoIDkwNjIgYW5kDQo+ID4gPiA5MDYzLCBmb2xkZWQgaW50byB0aGUg
b25rZXkgcGF0Y2ggYW5kIGFwcGxpZWQuDQo+ID4NCj4gPiBBcmdoLCBkYTkwNjIgY29yZSBpcyBu
b3QgaW4gbWFpbmxpbmUgeWV0Li4uIE9LLCBiZWxvdyBpcyB0aGUgcGF0Y2ggSQ0KPiA+IGhhZDsg
aWYgTGVlIGRvZXMgbm90IHBpY2sgaXQgdXAgSSdsbCByZS1hcHBseSBpdCB3aGVuIGRhOTA2MiBj
b3JlIGhpdHMNCj4gPiBtYWlubGluZS4NCj4gDQo+IEkgZ3Vlc3MgYWxsIDMgcGF0Y2hlcyBzaG91
bGQgYmUgdGFrZW4gdGhvdWdoIG9uZSB0cmVlPyAgSGFwcHkgdG8gdGFrZQ0KPiB0aGVtIHRocm91
Z2ggTUZEIGlmIHRoYXQncyBva2F5IHdpdGggeW91Lg0KDQpUaGFua3MgTGVlIQ0KKHBsZWFzZSBp
Z25vcmUgbXkgb3RoZXIgZS1tYWlsIDspDQpSZWdhcmRzLA0KU3RlcGhlbg0K
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
