From: Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH 3/5] input: edt-ft5x06 - Call devm_of_device_links_add()
 to create links
Date: Thu, 25 Apr 2019 07:22:03 +0000
Message-ID: <769d2c1e-8a33-d4fe-a3d9-6de4772b67d4@st.com>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
 <20190424101913.1534-4-benjamin.gaignard@st.com>
 <20190424225235.GA225055@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424225235.GA225055@dtor-ws>
Content-Language: en-US
Content-ID: <FFB026A3F1B8D5459817496E3480153C@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "hadess@hadess.net" <hadess@hadess.net>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>, "agx@sigxcpu.org" <agx@sigxcpu.org>, Yannick FERTRE <yannick.fertre@st.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: linux-input@vger.kernel.org

DQpPbiA0LzI1LzE5IDEyOjUyIEFNLCBEbWl0cnkgVG9yb2tob3Ygd3JvdGU6DQo+IEhpIEJlbmph
bWluLA0KPg0KPiBPbiBXZWQsIEFwciAyNCwgMjAxOSBhdCAxMjoxOToxMVBNICswMjAwLCBCZW5q
YW1pbiBHYWlnbmFyZCB3cm90ZToNCj4+IEZyb206IFlhbm5pY2sgRmVydHLDg8KpIDx5YW5uaWNr
LmZlcnRyZUBzdC5jb20+DQo+Pg0KPj4gQWRkIGEgY2FsbCB0byBkZXZtX29mX2RldmljZV9saW5r
c19hZGQoKSB0byBjcmVhdGUgbGlua3Mgd2l0aCBzdXBwbGllcnMNCj4+IGF0IHByb2JlIHRpbWUu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWFubmljayBGZXJ0csOpIDx5YW5uaWNrLmZlcnRyZUBz
dC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2Fp
Z25hcmRAc3QuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vZWR0
LWZ0NXgwNi5jIHwgMiArKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vZWR0LWZ0NXgwNi5j
IGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9lZHQtZnQ1eDA2LmMNCj4+IGluZGV4IDcwMmJm
ZGE3ZWU3Ny4uYWM5ZjdlODVlZmIwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbnB1dC90b3Vj
aHNjcmVlbi9lZHQtZnQ1eDA2LmMNCj4+ICsrKyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4v
ZWR0LWZ0NXgwNi5jDQo+PiBAQCAtMTE2Nyw2ICsxMTY3LDggQEAgc3RhdGljIGludCBlZHRfZnQ1
eDA2X3RzX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQo+PiAgIA0KPj4gICAJaTJj
X3NldF9jbGllbnRkYXRhKGNsaWVudCwgdHNkYXRhKTsNCj4+ICAgDQo+PiArCWRldm1fb2ZfZGV2
aWNlX2xpbmtzX2FkZCgmY2xpZW50LT5kZXYpOw0KPj4gKw0KPiBUaGlzIHNlZW1zIHByZXR0eSBn
ZW5lcmljIGFjdGlvbiBhbmQgSSBiZWxpZXZlIGl0IHNob3VsZCBiZSBkb25lIGluDQo+IGdlbmVy
aWMgY29kZSwgZWl0aGVyIGJ1cyAoaTJjLCBzcGksIGV0YyksIG9yIGluIGRldmljZSBjb3JlLg0K
SXQgaXMgZG9uZSAob3IgY291bGQgYmUgZG9uZSkgaW4gbW9zdCBvZiB0aGUgYnVzZXMgb3IgZnJh
bWV3b3JrIChsaWtlIA0KZm9yIHJlZ3VsYXRvcikNCmJ1dCBJIHRoaW5rIHRoYXQgYWRkaW5nIGl0
IGluIGRldmljZSBjb3JlIGFkZCBhIGRldmljZS10cmVlIG5vZGUgcGFyc2luZyANCmZvciBhbGwg
dGhlDQpkcml2ZXJzIHdoaWxlIG9ubHkgYSBmZXcgb2YgdGhlbSB3aWxsIHJlYWxseSBuZWVkIHRo
aXMgZmVhdHVyZS4gVGhhdCB3aHkgDQpJIGhhdmUgcHV0IHRoZQ0KY2FsbCBoZXJlLg0KDQpCZW5q
YW1pbg0KPg0KPiBUaGFua3MuDQo+
