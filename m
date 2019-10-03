From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Date: Thu, 3 Oct 2019 18:18:37 +0000
Message-ID: <PU1P153MB016904AA7BAC9255552A89E1BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
 <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190928003156.GU237523@dtor-ws>
 <PU1P153MB0169C315F7F9EBEBED4C7A7DBF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190930230652.GW237523@dtor-ws>
 <PU1P153MB01696258D9983DF59D68E748BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <PU1P153MB0169CC57749BF297F2581B02BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20191003174530.GB22365@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191003174530.GB22365@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
List-Id: linux-input@vger.kernel.org

PiBGcm9tOiBkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tIDxkbWl0cnkudG9yb2tob3ZAZ21haWwu
Y29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAzLCAyMDE5IDEwOjQ2IEFNDQo+ID4NCj4g
PiBJIHRoaW5rIEkgdW5kZXJzdG9vZCBub3c6IGl0IGxvb2tzIHRoZSB2bWJ1cyBkcml2ZXIgc2hv
dWxkIGltcGxlbWVudA0KPiA+IGEgcHJlcGFyZSgpIG9yIGZyZWV6ZSgpLCB3aGljaCBjYWxscyB0
aGUgaHlwZXJ2X2tleWJvYXJkIGRyaXZlcidzDQo+ID4gcHJlcGFyZSgpIG9yIGZyZWV6ZSgpLCB3
aGljaCBjYW4gc2V0IHRoZSBmbGFnIG9yIGRpc2FibGUgdGhlIGtleWJvYXJkDQo+ID4gZXZlbnQg
aGFuZGxpbmcuIFRoaXMgd2F5IHdlIGRvbid0IG5lZWQgdGhlIG5vdGlmaWVyLg0KPiANCj4gUmln
aHQuIEkgdGhpbmsgaW4gcHJhY3RpY2UgdGhlIGN1cnJlbnQgc3VzcGVuZCBpbXBsZW1lbnRhdGlv
biBjYW4gd29yaw0KPiBhcyBmcmVlemUoKSBmb3IgdGhlIEhWIGtleWJvYXJkLCBiZWNhdXNlIGlu
IHN1c3BlbmQgeW91IHNodXQgb2ZmIHZtYnVzDQo+IGNoYW5uZWwsIHNvIHRoZXJlIHNob3VsZCBu
b3QgYmUgd2FrZXVwIHNpZ25hbHMgYW55bW9yZS4gV2hhdCB5b3UgZG8gbm90DQo+IHdhbnQgaXMg
dG8gaGF2ZSB0aGUgY3VycmVudCByZXN1bWUgdG8gYmUgdXNlZCBpbiBwbGFjZSBvZiB0aGF3KCks
IGFzDQo+IHRoZXJlIHlvdSByZS1lbmFibGUgdGhlIHZtYnVzIGNoYW5uZWwgYW5kIHJlc3VtZSBz
ZW5kaW5nIHdha2V1cCByZXF1ZXN0cw0KPiBhcyB5b3UgYXJlIHdyaXRpbmcgb3V0IHRoZSBoaWJl
cm5hdGlvbiBpbWFnZSB0byBzdG9yYWdlLg0KPiANCj4gSSB0aGluayBpZiB2bWJ1cyBhbGxvd2Vk
IEhWIGtleWJvYXJkIGRyaXZlciB0byBzdXBwbHkgZW1wdHkgdGhhdygpIGFuZA0KPiBwb3dlcm9m
ZigpIGltcGxlbWVudGF0aW9ucywgd2hpbGUgdXNpbmcgc3VzcGVuZCgpIGFzIGZyZWV6ZSgpIGFu
ZA0KPiByZXN1bWUoKSBhcyByZXN0b3JlKCksIGl0IHdvdWxkIHNvbHZlIHRoZSBpc3N1ZSBmb3Ig
eW91Lg0KPiANCj4gRG1pdHJ5DQoNCkV4YWN0bHkuIEknbGwgaGF2ZSB0byBmaXggdm1idXMgZmly
c3QsIHRoZW4gcG9zdCBhIHYyIGZvciB0aGlzIHBhdGNoLg0KDQpUaGFua3MsDQotLSBEZXh1YW4N
Cg==
