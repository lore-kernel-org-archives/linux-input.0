From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: iio/hid-sensor-accel-3d: no output from /dev/iio:device*?
Date: Fri, 18 Dec 2015 01:00:21 +0000
Message-ID: <1450400312.5427.15.camel@intel.com>
References: <CAOhV88ODTazDA2jmn9DP5idMmXXQa9jKB9Ur_aWTD_3WYZM1fw@mail.gmail.com>
	 <1450399868.5427.11.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14653 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932801AbbLRBAf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Dec 2015 20:00:35 -0500
In-Reply-To: <1450399868.5427.11.camel@linux.intel.com>
Content-Language: en-US
Content-ID: <09ED78FE2FC8344CBE959147AD67FD7F@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jikos@kernel.org" <jikos@kernel.org>, "nish.aravamudan@gmail.com" <nish.aravamudan@gmail.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "jic23@kernel.org" <jic23@kernel.org>, "cmo@melexis.com" <cmo@melexis.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>

SGkgQW5keSwNCg0KQXMgcGVyIE5pc2ggdGhlc2UgcGF0Y2hlcyBhcmUgaW1wYWN0aW5nIHNlbnNv
cnMgb24gWW9nYS4NCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE1LzExLzMwLzQ0MQ0KDQpDYW4g
eW91IGhlbHA/DQoNClRoYW5rcywNClNyaW5pdmFzDQoNCk9uIFRodSwgMjAxNS0xMi0xNyBhdCAx
Njo1MSAtMDgwMCwgU3Jpbml2YXMgUGFuZHJ1dmFkYSB3cm90ZToNCj4gT24gVGh1LCAyMDE1LTEy
LTE3IGF0IDE1OjM4IC0wODAwLCBOaXNoIEFyYXZhbXVkYW4gd3JvdGU6DQo+ID4gW1N0YXJ0aW5n
IGEgbmV3IHRocmVhZCBmcm9tIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE1LzEyLzE1LzY2MywN
Cj4gPiBhcw0KPiA+IG5vdyBteSBsYXB0b3AgaXMgZGlzcGxheWluZyB2YWx1ZXMgaW4gdGhlIHN5
c2ZzICpyYXcqIGZpbGVzLl0NCj4gPiANCj4gPiBTbyBJJ20gdHJ5aW5nIHRvIHVuZGVyc3RhbmQg
ZXhhY3RseSBob3cgdGhlIGhpZC1zZW5zb3ItYWNjZWwtM2QNCj4gPiBkcml2ZXIgd29ya3MuDQo+
ID4gDQo+ID4gSWYgSSB0dXJuIHVwIGRlYnVnZ2luZywgd2hlbiBJIGBjYXQNCj4gPiAvc3lzL2J1
cy9paW8vZGV2aWNlcy9kZXZpY2UqLypyYXcqYCwgSSBzZWUgImlpbyBpaW86ZGV2aWNlMzoNCj4g
PiBhY2NlbF8zZF9wcm9jX2V2ZW50IiBhbmQgSSB0aGluayB0aGF0IG1lYW5zIHRoYXQNCj4gPiBo
aWRfc2Vuc29yX3B1c2hfZGF0YSgpIGlzIGdldHRpbmcgY2FsbGVkLg0KPiA+IA0KPiA+IEJ1dCBy
ZWFkKCkncyBvbiAvZGV2L2lpbzpkZXZpY2UzIG5ldmVyIHByb2R1Y2VzIGFueXRoaW5nLCB3aGlj
aCBpcw0KPiA+IHdoYXQgaWlvLXNlbnNvci1wcm94eSB1c2VzIHRvIHRyYW5zbGF0ZSBldmVudHMg
dG8gZGJ1cy4NCj4gPiANCj4gPiBJcyBpdCBleHBlY3RlZCB0aGF0IHRoZSBkZXYtbm9kZSBpcyAi
c2lsZW50Ij8gSnVzdCB0cnlpbmcgdG8NCj4gPiB1bmRlcnN0YW5kIGlmIGFuIGV4dGVuc2lvbiB0
byB0aGUgZHJpdmVyIHRvIHN1cHBvcnQgYSBjaGFyZGV2IGJhc2VkDQo+ID4gb3V0cHV0IGlzIGFw
cHJvcHJpYXRlLCBvciBpZiBpaW8tc2Vuc29yLXByb3h5IG5lZWRzIHRvIGJlIGNoYW5nZWQNCj4g
PiB0bw0KPiA+IGhhbmRsZSB0aGlzIGRldmljZS4NCj4gDQo+IFlvdSBhcmUgc2F5aW5nIHRoZXJl
IGlzIHNvbWUgcmVncmVzc2lvbi4gVGhpcyB1c2VkIHRvIHdvcmsgYW5kIG5vdyBpdA0KPiBkb2Vz
bid0IHdvcmsuIElzIHJhdyB2YWx1ZXMgYXJlIGRpc3BsYXllZCBjb3JyZWN0bHksIHdoZW4geW91
IGRvDQo+ICJjYXQiPw0KPiBJZiBjYXQgb2YgcmF3IHZhbHVlcyBpcyB3b3JraW5nIHRoZW4gcG93
ZXIgb24gb2Ygc2Vuc29ycyBpcyB3b3JraW5nLg0KPiANCj4gVHVybiBvbiBISUQgZGVidWcgcHJp
bnRzLiBJZiBpdCBpcyByZWdyZXNzaW9uIHdlIGNhbiBkbyBnaXQgYmlzZWN0Lg0KPiBBbnkgQUNQ
SSBvciBQTSBjaGFuZ2VzIGNhbiBicmVhayB0aGlzLiBVc3VhbGx5IHRoZXJlIHdpbGwgYmUgR1BJ
T3MNCj4gd2hpY2ggd2lsbCBiZSBpbnZvbHZlZCBpbiBwb3dlciBvbiwgd2hlcmUgQUNQSSBjb21l
cyBpbnRvIHBsYXkuIFRoaXMNCj4gd2lsbCBiZSBkb25lIGJ5IGkyYy1oaWQuIFRoZXJlIGFyZSBz
b21lIHByaW50cyBpbiBpMmMtaGlkIHdoaWNoIGNhbg0KPiBiZQ0KPiBlbmFibGVkIGFsc28uDQo+
IA0KPiBUaGFua3MsDQo+IFNyaW5pdmFzDQo+IA0KPiA+IA==
