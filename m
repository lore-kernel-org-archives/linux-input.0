From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] hid: hid-sensor-prox: Add more data field for
 hysteresis parsing
Date: Tue, 21 Feb 2017 10:30:20 +0000
Message-ID: <1487673016.12632.2.camel@intel.com>
References: <1486979692-44878-1-git-send-email-hongyan.song@intel.com>
         <a27a7238-c825-b2d9-733e-0c7a7919a3d6@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:62035 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbdBUKaW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Feb 2017 05:30:22 -0500
In-Reply-To: <a27a7238-c825-b2d9-733e-0c7a7919a3d6@kernel.org>
Content-Language: en-US
Content-ID: <B35F200F4F8A824A9DBAD786D307F2B6@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Song, Hongyan" <hongyan.song@intel.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "jic23@kernel.org" <jic23@kernel.org>
Cc: "jikos@kernel.org" <jikos@kernel.org>

T24gU3VuLCAyMDE3LTAyLTE5IGF0IDExOjUwICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiAxMy8wMi8xNyAwOTo1NCwgU29uZyBIb25neWFuIHdyb3RlOg0KPiA+IEFkZCBISURf
VVNBR0VfU0VOU09SX0hVTUFOX1BSRVNFTkNFIHN1cHBvcnQgZm9yIEh1bWFuIFByZXNlbmNlDQo+
ID4gc2Vuc2l0aXZpdHkNCj4gPiBwYXJzaW5nLCBpbiBjYXNlIHNvbWUgaW1wbGVtZW50YXRpb24g
dXNlcyBpdCBhcyBzZW5zaXRpdml0eQ0KPiA+IG1vZGlmaWVyLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFNvbmcgSG9uZ3lhbiA8aG9uZ3lhbi5zb25nQGludGVsLmNvbT4NCkFja2VkLWJ5OiBT
cmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4N
Cg0KPiANCj4gRG8gd2Ugd2FudCB0byBwZXJoYXBzIGluZGljYXRlIHRvIHVzZXJzcGFjZSBpbiBz
b21lIHdheSB0aGF0IHRoaXMgaXMNCj4gd2hhdCBpcyBiZWluZw0KPiByZXBvcnRlZD8gKG5vdCB0
aGF0IEkgaGF2ZSBhbnkgaWRlYSBob3cgYSBwcm94aW1pdHkgc2Vuc29yIGNvdWxkDQo+IHBvdGVu
dGlhbGx5IHRlbGwNCj4gYSBodW1hbiBmcm9tIGEgcGFzc2luZyBjYXQgZm9yIGV4YW1wbGUgOykN
Cj4gDQo+IE90aGVyd2lzZSwgSSdtIGZpbmUgd2l0aCB0aGlzIGJ1dCB3b3VsZCBsaWtlIGFuIEFj
ayBmcm9tIFNyaW5pdmFzLg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9paW8vbGlnaHQvaGlkLXNl
bnNvci1wcm94LmMgfCA3ICsrKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vbGlnaHQvaGlkLXNlbnNv
ci1wcm94LmMNCj4gPiBiL2RyaXZlcnMvaWlvL2xpZ2h0L2hpZC1zZW5zb3ItcHJveC5jDQo+ID4g
aW5kZXggNDVjYTA1Ni4uNzNmY2VkOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9saWdo
dC9oaWQtc2Vuc29yLXByb3guYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2xpZ2h0L2hpZC1zZW5z
b3ItcHJveC5jDQo+ID4gQEAgLTI0MCw2ICsyNDAsMTMgQEAgc3RhdGljIGludCBwcm94X3BhcnNl
X3JlcG9ydChzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ID4gwqAJCQlzdC0+
Y29tbW9uX2F0dHJpYnV0ZXMuc2Vuc2l0aXZpdHkuaW5kZXgsDQo+ID4gwqAJCQlzdC0NCj4gPiA+
Y29tbW9uX2F0dHJpYnV0ZXMuc2Vuc2l0aXZpdHkucmVwb3J0X2lkKTsNCj4gPiDCoAl9DQo+ID4g
KwlpZiAoc3QtPmNvbW1vbl9hdHRyaWJ1dGVzLnNlbnNpdGl2aXR5LmluZGV4IDwgMCkNCj4gPiAr
CQlzZW5zb3JfaHViX2lucHV0X2dldF9hdHRyaWJ1dGVfaW5mbyhoc2RldiwNCj4gPiArCQkJSElE
X0ZFQVRVUkVfUkVQT1JULCB1c2FnZV9pZCwNCj4gPiArCQkJSElEX1VTQUdFX1NFTlNPUl9EQVRB
X01PRF9DSEFOR0VfU0VOU0lUSVZJDQo+ID4gVFlfQUJTIHwNCj4gPiArCQkJSElEX1VTQUdFX1NF
TlNPUl9IVU1BTl9QUkVTRU5DRSwNCj4gPiArCQkJJnN0LT5jb21tb25fYXR0cmlidXRlcy5zZW5z
aXRpdml0eSk7DQo+ID4gKw0KPiA+IMKgCXJldHVybiByZXQ7DQo+ID4gwqB9DQo+ID4gwqANCj4g
PiANCj4gDQo+IA==
