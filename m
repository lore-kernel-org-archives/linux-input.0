From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: iio/hid-sensor-accel-3d: no output from /dev/iio:device*?
Date: Fri, 18 Dec 2015 02:50:52 +0000
Message-ID: <1450406943.3885.3.camel@intel.com>
References: <CAOhV88ODTazDA2jmn9DP5idMmXXQa9jKB9Ur_aWTD_3WYZM1fw@mail.gmail.com>
	 <1450399868.5427.11.camel@linux.intel.com>
	 <1450400312.5427.15.camel@intel.com>
	 <CAOhV88OinTE31-qp1vh-4XHT-TqMTTOYwHiLk0yptg0prwetjw@mail.gmail.com>
	 <1450400953.5427.18.camel@intel.com>
	 <CAOhV88Oqj+JrPsHqZmtmydUftSA9sUuCDErUOaAG_Erk+uDr1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17551 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966046AbbLRCuy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Dec 2015 21:50:54 -0500
In-Reply-To: <CAOhV88Oqj+JrPsHqZmtmydUftSA9sUuCDErUOaAG_Erk+uDr1g@mail.gmail.com>
Content-Language: en-US
Content-ID: <7207EE80DCFDBC47821DE4FD0683795A@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "nish.aravamudan@gmail.com" <nish.aravamudan@gmail.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "jic23@kernel.org" <jic23@kernel.org>, "cmo@melexis.com" <cmo@melexis.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jikos@kernel.org" <jikos@kernel.org>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>

T24gVGh1LCAyMDE1LTEyLTE3IGF0IDE4OjMzIC0wODAwLCBOaXNoIEFyYXZhbXVkYW4gd3JvdGU6
DQo+IE9uIFRodSwgRGVjIDE3LCAyMDE1IGF0IDU6MTEgUE0sIFBhbmRydXZhZGEsIFNyaW5pdmFz
DQo+IDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gT24gVGh1LCAy
MDE1LTEyLTE3IGF0IDE3OjA4IC0wODAwLCBOaXNoIEFyYXZhbXVkYW4gd3JvdGU6DQo+ID4gPiBP
biBUaHUsIERlYyAxNywgMjAxNSBhdCA1OjAwIFBNLCBQYW5kcnV2YWRhLCBTcmluaXZhcw0KPiA+
ID4gPHNyaW5pdmFzLnBhbmRydXZhZGFAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gSGkgQW5k
eSwNCj4gPiA+ID4gDQo+ID4gPiA+IEFzIHBlciBOaXNoIHRoZXNlIHBhdGNoZXMgYXJlIGltcGFj
dGluZyBzZW5zb3JzIG9uIFlvZ2EuDQo+ID4gPiA+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE1
LzExLzMwLzQ0MQ0KPiA+ID4gDQo+ID4gPiBUbyBiZSBjbGVhciwgd2l0aG91dCB0aGF0IHNlcmll
cywgdGhlIHRvdWNocGFkIGFuZCB0b3VjaHNjcmVlbiBvbg0KPiA+ID4gdGhlDQo+ID4gPiBZb2dh
IDkwMCBkb24ndCB3b3JrIGF0IGFsbC4gU28gdGhleSBhcmUgbmVjZXNzYXJ5IGZvcg0KPiA+ID4g
ZnVuY3Rpb25pbmcuIEkNCj4gPiA+IGRvbid0IGtub3cgKEkgd2lsbCB0ZXN0IGl0IG5vdyksIGlm
IHJlbW92aW5nIHRoZSBzZXJpZXMgbWFrZXMgdGhlDQo+ID4gPiBJSU8NCj4gPiA+IHNlbnNvcnMg
d29yayBwcm9wZXJseSBpbiAvZGV2Ly4NCj4gPiBUaGlzIGlzIGltcG9ydGFudCB0byBrbm93IGJl
Zm9yZSB3ZSB0YWtlIEFuZHkncyB0aW1lLg0KPiANCj4gSXQgc2VlbXMgbGlrZSBBbmR5J3MgcGF0
Y2hlcyBhcmUgbm90IHRoZSBwcm9ibGVtLiBUaGF0IGlzLCB3aXRoIHN0b2NrDQo+IDQuNC1yYzUs
IHRoZSBhY2NlbGVyb21tZXRlciAvZGV2IGZpbGVzIHN0aWxsIGRvIG5vdCB1cGRhdGUuDQo+IA0K
Q2FuIHlvdSBub3QgdXNlIHJhdyB2YWx1ZXMgYnkgcG9sbGluZyBmcm9tIHVzZXIgc3BhY2U/IFNl
bmQgbWUNCnJlcG9ydCBkZXNjcmlwdGlvbi4gSXQgc2hvdWxkIGJlIGluDQovc3lzL2tlcm5lbC9k
ZWJ1Zy9oaWQvICJ5b3VyIGRldmljZSBpZCIgL3JlZGVzYy4NCg0KQWxzbyBkZXZpY2UgaWQgKCJ5
b3VyIGRldmljZSBpZCIpIGFib3ZlLg0KDQpUaGFua3MsDQpTcmluaXZhcw0KDQoNCj4gLU5pc2g=
