From: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH V1 6/6] devicetree: da9062: Add bindings for DA9062
 driver
Date: Wed, 29 Apr 2015 11:26:53 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B217AE3@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <94535acf974274822c5ac16d6427299778e11ccf.1429280614.git.stwiss.opensource@diasemi.com>
 <20150429105415.GX9169@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150429105415.GX9169@x1>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

DQpPbiAyOSBBcHJpbCAyMDE1IDExOjU0IExlZSBKb25lcyB3cm90ZSA6DQoNCj4gT24gRnJpLCAx
NyBBcHIgMjAxNSwgUyBUd2lzcyB3cm90ZToNCj4gPiBGcm9tOiBTIFR3aXNzIDxzdHdpc3Mub3Bl
bnNvdXJjZUBkaWFzZW1pLmNvbT4NCj4gPg0KPiA+IEFkZCBkZXZpY2UgdHJlZSBiaW5kaW5ncyBm
b3IgdGhlIERBOTA2MiBkcml2ZXINCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZXZlIFR3aXNz
IDxzdHdpc3Mub3BlbnNvdXJjZUBkaWFzZW1pLmNvbT4NCj4gPg0KPiA+IC0tLQ0KPiA+DQo+ID4g
VGhpcyBwYXRjaCBhcHBsaWVzIGFnYWluc3QgbGludXgtbmV4dCBhbmQgdjQuMA0KPiA+DQo+ID4g
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvZGE5MDYyLnR4dCB8IDEwNw0K
PiArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTA3IGluc2Vy
dGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZmQvZGE5MDYyLnR4dA0KPiANCj4gSSBkb24ndCBzZWUgYW55dGhpbmcgZ3Jv
dW5kYnJlYWtpbmcgb3Igb2ZmZW5zaXZlLg0KPiANCj4gQWNrZWQtYnk6IExlZSBKb25lcyA8bGVl
LmpvbmVzQGxpbmFyby5vcmc+DQo+IA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcgYW5kIEFj
ay4NCg0KSSBhbSBpbiB0aGUgcHJvY2VzcyBvZiB1cGRhdGluZyB0aGUgREE5MDYzIE9uS2V5IGRy
aXZlciBpbiBhIGRpZmZlcmVudCB0aHJlYWQuDQpUaGlzIGRyaXZlciBpcyBmdW5jdGlvbmFsbHkg
c2ltaWxhciB0byB0aGUgREE5MDYyIE9uS2V5IGRyaXZlciBhcyB3YXMgZGlzY3Vzc2VkIGluDQph
biBlYXJsaWVyIHRocmVhZCBmcm9tIERBOTA2My4NCg0KaHR0cDovL3d3dy5zcGluaWNzLm5ldC9s
aXN0cy9saW51eC1pbnB1dC9tc2czODEzNy5odG1sDQoNCkFsdGhvdWdoIHRoZSA2MyBhbmQgNjIg
Y2hpcHMgaGF2ZSBzZXF1ZW50aWFsIG51bWJlcnMgdGhleSBhcmUgbm90IHRoZSBzYW1lLA0KaG93
ZXZlciB0aGUgT25LZXkgZHJpdmVyIGlzIGZ1bmN0aW9uYWxseSB2ZXJ5IHNpbWlsYXIgYW5kIHNv
IEkgYW0gZ29pbmcgdG8gdHJ5IGFuZA0KbWVyZ2UgdGhlIGNvZGUgZm9yIGJvdGggZHJpdmVycyBp
biB0aGUgY2FzZSBvZiB0aGUgT25LZXkuDQoNCkR1ZSB0byB0aGUgREE5MDYzIGJlaW5nIGN1cnJl
bnRseSByZXZpZXdlZCwgcGVyaGFwcyBpdCB3b3VsZCBiZSBwcnVkZW50IG5vdA0KdG8gYWRkIHRo
aXMgZGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yIERBOTA2MiB0byB0aGUga2VybmVsIGp1c3QgeWV0
IC0tIHRoZSBkZXZpY2UgdHJlZQ0KYmluZGluZ3MgY291bGQgY2hhbmdlIGZvciB0aGUgT25LZXkg
aW4gbXkgREE5MDYzIHN1Ym1pc3Npb24gYW5kIHRoaXMgd291bGQgYWZmZWN0DQp0aGUgREE5MDYy
IGRyaXZlciB3aGVuIEkgbWVyZ2UgdGhlIHR3byBPbktleSBkcml2ZXJzLg0KDQpJIHdpbGwgcHV0
IGEgZnVsbCB2ZXJzaW9uIGhpc3RvcnkgaW4gbXkgbmV4dCBwYXRjaCBzZXQgdG8gZGVzY3JpYmUg
d2hhdCBjaGFuZ2VzIEkgaGF2ZQ0KbWFkZSB0byB0aGlzIGZpbGUgc28gdGhpcyByZXZpZXcgaXMg
bm90IGRlZW1lZCBhIHdhc3RlZCBlZmZvcnQuDQoNClJlZ2FyZHMsDQpTdGV2ZQ0KDQpbLi4uXQ0K
DQoNCg==
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
