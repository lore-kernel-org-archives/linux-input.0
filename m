From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v9 9/9] Input: goodix - sort includes using inverse Xmas
 tree order
Date: Tue, 13 Oct 2015 06:42:53 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0FE45A@irsmsx105.ger.corp.intel.com>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
	<1444663477-30062-10-git-send-email-irina.tirdea@intel.com>
	<20151012153916.GF7452@leverpostej>	<1444664437.24103.1.camel@hadess.net>
	<20151012155132.GG7452@leverpostej>	<1444665210.24103.2.camel@hadess.net>
 <CAKdAkRQNZVJXxjDqsm_5AY-Qk2+gREjS-6g=L3cFFF84epWCPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19779 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbbJMGm6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2015 02:42:58 -0400
In-Reply-To: <CAKdAkRQNZVJXxjDqsm_5AY-Qk2+gREjS-6g=L3cFFF84epWCPg@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Purdila, Octavian" <octavian.purdila@intel.com>, lkml <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG1pdHJ5IFRvcm9raG92
IFttYWlsdG86ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbV0NCj4gU2VudDogMTIgT2N0b2Jlciwg
MjAxNSAxOTozMQ0KPiBUbzogQmFzdGllbiBOb2NlcmENCj4gQ2M6IE1hcmsgUnV0bGFuZDsgVGly
ZGVhLCBJcmluYTsgQWxla3NlaSBNYW1saW47IEthcnN0ZW4gTWVya2VyOyBsaW51eC1pbnB1dEB2
Z2VyLmtlcm5lbC5vcmc7IFB1cmRpbGEsIE9jdGF2aWFuOyBsa21sOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDkvOV0gSW5wdXQ6IGdvb2Rp
eCAtIHNvcnQgaW5jbHVkZXMgdXNpbmcgaW52ZXJzZSBYbWFzIHRyZWUgb3JkZXINCj4gDQo+IE9u
IE1vbiwgT2N0IDEyLCAyMDE1IGF0IDg6NTMgQU0sIEJhc3RpZW4gTm9jZXJhIDxoYWRlc3NAaGFk
ZXNzLm5ldD4gd3JvdGU6DQo+ID4gT24gTW9uLCAyMDE1LTEwLTEyIGF0IDE2OjUxICswMTAwLCBN
YXJrIFJ1dGxhbmQgd3JvdGU6DQo+ID4+IE9uIE1vbiwgT2N0IDEyLCAyMDE1IGF0IDA1OjQwOjM3
UE0gKzAyMDAsIEJhc3RpZW4gTm9jZXJhIHdyb3RlOg0KPiA+PiA+IE9uIE1vbiwgMjAxNS0xMC0x
MiBhdCAxNjozOSArMDEwMCwgTWFyayBSdXRsYW5kIHdyb3RlOg0KPiA+PiA+ID4gV2h5Pw0KPiA+
PiA+DQo+ID4+ID4gSXQgd2FzIGFscmVhZHkgZGlzY3Vzc2VkIGluIHRoZSB0aHJlYWQgZm9yIGEg
cHJldmlvdXMgdmVyc2lvbiwNCj4gPj4gPiBwbGVhc2UNCj4gPj4gPiByZWZlciB0byB0aGF0Lg0K
PiA+Pg0KPiA+PiBGaW5lLCBidXQgc3VyZWx5IHRoYXQgc2hvdWxkIGJlIGluIHRoZSBjb21taXQg
bWVzc2FnZSwgdG8gcHJldmVudA0KPiA+PiBvdGhlcnMNCj4gPj4gbGlrZSBteXNlbGYgcmVwZWF0
ZWRseSBhc2tpbmcgdGhlIHNhbWUgcXVlc3Rpb24/DQo+ID4NCj4gPiBGYWlyIHBvaW50LiBJcmlu
YT8NCj4gDQo+IE5vLCBsZXQncyBqdXN0IGxlYXZlIHBvb3IgaW5jbHVkZXMgYWxvbmUuDQo+IA0K
DQpPSywgd2lsbCBkcm9wIHRoaXMgOikNCg0KVGhhbmtzLA0KSXJpbmENCg0KPiAtLQ0KPiBEbWl0
cnkNCg==
