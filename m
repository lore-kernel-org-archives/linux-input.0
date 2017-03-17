From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] iio: hid: hid-sensor-accel-3d: Add second ACC sensor
 support
Date: Fri, 17 Mar 2017 16:22:09 +0000
Message-ID: <1489767728.88966.8.camel@intel.com>
References: <1489659652-35608-1-git-send-email-hongyan.song@intel.com>
         <1489716812.10281.4.camel@intel.com> <1489756594.18490.22.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1117 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbdCQQXB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Mar 2017 12:23:01 -0400
In-Reply-To: <1489756594.18490.22.camel@hadess.net>
Content-Language: en-US
Content-ID: <1C10F0641FD4E643818B8EF58F04B1F2@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Song, Hongyan" <hongyan.song@intel.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "hadess@hadess.net" <hadess@hadess.net>
Cc: "jikos@kernel.org" <jikos@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>

T24gRnJpLCAyMDE3LTAzLTE3IGF0IDE0OjE2ICswMTAwLCBCYXN0aWVuIE5vY2VyYSB3cm90ZToN
Cj4gT24gRnJpLCAyMDE3LTAzLTE3IGF0IDAyOjEzICswMDAwLCBQYW5kcnV2YWRhLCBTcmluaXZh
cyB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIDIwMTctMDMtMTYgYXQgMTg6MjAgKzA4MDAsIFNv
bmcgSG9uZ3lhbiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gQXMgYWNjZWxlcm9tZXRlciBzZW5zb3Ig
YmVjb21lcyBtb3JlIGFuZCBtb3JlIHBvcHVsYXIsIHRoZXJlIGFyZQ0KPiA+ID4gbW9yZQ0KPiA+
ID4gdXNlciBzY2VuYXJpb3MgaGF2ZSBiZWVuIGRldmVsb3BlZCwgIkhpbmdlIiBpcyBhIHZlcnkg
aW1wb3J0YW50DQo+ID4gPiB1c2VjYXNlDQo+ID4gPiB3aGljaCBuZWVkcyB0d28gYWNjZWxlcm9t
ZXRlciBzZW5zb3JzIHRvIGNhbGN1bGF0ZSB0aGUgaW5jbHVkZWQNCj4gPiA+IGFuZ2xlDQo+ID4g
PiBvZiBrZXlib2FyZCBhbmQgc2NyZWVuLg0KPiA+ID4gSW4gdGhpcyBjYXNlLCB0d28gYWNjZWxl
cm9tZXRlciBzZW5zb3JzIHdpbGwgYmUgZXhwb3NlZC4NCj4gPiA+IEN1cnJlbnRseSwNCj4gPiA+
IElJTyBpbnRlcmZhY2UgaGFzbid0IG90aGVyIHdheSB0byBkaXN0aW5ndWlzaCB0d28gc2Vuc29y
cyB3aXRoDQo+ID4gPiBzYW1lDQo+ID4gPiBzZW5zb3IgdHlwZSwgZXhjZXB0IHNlbnNvciBuYW1l
LiBTbyBhIG5ldyBzZW5zb3IgbmFtZQ0KPiA+ID4gImFjY2VsXzJuZF8zZCINCj4gPiA+IGlzIGFk
ZGVkIGZvciBzZWNvbmRhcnkgYWNjZWxlcm9tZXRlciBzZW5zb3IuDQo+ID4gDQo+ID4gVGhpcyB0
eXBlIG9mIGludGVyZmFjZSB3aWxsIG5vdCBzYXRpc2Z5IGFsbCBjYXNlcy4gV2UgaGF2ZSBzb21l
DQo+ID4gaHVicw0KPiA+IHdpdGjCoMKgbWFueSBhY2NlbGVyb21ldGVycyBhdHRhY2hlZC4gU2Ft
ZSBjYXNlIGlzIGFsc28gdHJ1ZSBldmVuIGZvcg0KPiA+IGRpc2NyZXRlIHNlbnNvcnMuIFNvIHRo
ZXJlIHNob3VsZCBiZSBzb21lIGZyYW1ld29yayB3YXkgdG8gZXhwb3NlDQo+ID4gbG9jYXRpb24g
b2Ygc2Vuc29ycy4NCj4gDQo+IFNvIHlvdSdyZSBuYWNraW5nIGFzIHdlbGw/DQpZZXMuDQoNCj4g
DQo+ID4gDQo+ID4gQUNQSSBoYXMgc3BlY2lhbCBtZXRob2QgY2FsbGVkIF9QTEQgKFBoeXNpY2Fs
IERldmljZSBMb2NhdGlvbiksDQo+ID4gd2hpY2gNCj4gPiBjYW7CoMKgYmUgdXNlZCB0byBzcGVj
aWZ5IGxvY2F0aW9uIG9mIGFueSBkZXZpY2UuIFNvIHdlIG5lZWQgdG8gYmUNCj4gPiBhYmxlDQo+
ID4gdG8gZXhwb3J0IHN1Y2ggaW5mb3JtYXRpb24gdG8gdXNlciBzcGFjZS4gV2UgY2FuIGFkZCBm
b3IgZWFjaA0KPiA+IHNlbnNvcg0KPiA+IHRoZSBsb2NhdGlvbiBpbmZvcm1hdGlvbi4NCj4gPiAN
Cj4gPiBJIGNhbiBwcm9wb3NlIHNvbWUgQUJJIGZvciBleHBvcnRpbmcgbG9jYXRpb24gaW5mb3Jt
YXRpb24uDQo+IA0KPiBUaGVyZSB3ZXJlIHBhdGNoZXMgZmxvYXRpbmcgYXJvdW5kIHRvIGRvIHRo
aXMsIGJ1dCB0aGV5IHdlcmUgbmV2ZXINCj4gZmluaXNoZWQ6DQo+IGh0dHA6Ly93d3cuc3Bpbmlj
cy5uZXQvbGlzdHMvbGludXgtYWNwaS9tc2c1MTU0MC5odG1sDQpXZSBuZWVkIHRvIGFkZCBzb21l
IG9mIHRob3NlIGVsZW1lbnQgcmVsYXRlZCB0byBzZW5zb3JzIHRvIElJTyBBQkkuDQpJIHdpbGwg
cHJvcG9zZSBhbiBBQkkgYXMgSm9uYXRoYW4gc3VnZ2VzdGVkLg0KDQpUaGFua3MsDQpTcmluaXZh
cw0K
