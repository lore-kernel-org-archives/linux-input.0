From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 3/3] hid: intel-ish-hid: ipc: use msleep_interrupt() for
 wait
Date: Tue, 15 Nov 2016 18:10:27 +0000
Message-ID: <1479233425.6544.47.camel@intel.com>
References: <1478828433-31779-1-git-send-email-even.xu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43486 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932462AbcKOSK6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Nov 2016 13:10:58 -0500
In-Reply-To: <1478828433-31779-1-git-send-email-even.xu@intel.com>
Content-Language: en-US
Content-ID: <8D2BF1CCA57AE544B49CB5AA32D4D6D9@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jikos@kernel.org" <jikos@kernel.org>, "Xu, Even" <even.xu@intel.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

T24gRnJpLCAyMDE2LTExLTExIGF0IDA5OjQwICswODAwLCBFdmVuIFh1IHdyb3RlOg0KPiBzZXRf
Y3VycmVudF90YXNrKCkgbXVzdCBiZSBjYWxsZWQgYmVmb3JlIHNjaGVkdWxlX3RpbWVvdXQoKSwg
Zm9yIHRoaXMNCj4gZHJpdmVyLCBpbiBvcmRlciB0byBhdm9pZCBpbmNvcnJlY3QgdXNhZ2UsIHVz
ZSBtc2xlZXBfaW50ZXJydXB0KCkNCj4gaW5zdGVhZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEV2
ZW4gWHUgPGV2ZW4ueHVAaW50ZWwuY29tPg0KQWNrZWQtYnk6IFNyaW5pdmFzIFBhbmRydXZhZGEg
PHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiDCoGRyaXZl
cnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL2lwYy5jIHwgNCArKystDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL2lwYy5jIGIvZHJpdmVycy9oaWQvaW50ZWwtDQo+
IGlzaC1oaWQvaXBjL2lwYy5jDQo+IGluZGV4IDgxOTRjMzUuLjg2YTM2ZWIgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL2lwYy5jDQo+ICsrKyBiL2RyaXZlcnMv
aGlkL2ludGVsLWlzaC1oaWQvaXBjL2lwYy5jDQo+IEBAIC01MzksNiArNTM5LDggQEAgc3RhdGlj
IGludCBpc2hfZndfcmVzZXRfaGFuZGxlcihzdHJ1Y3QNCj4gaXNodHBfZGV2aWNlICpkZXYpDQo+
IMKgCXJldHVybgkwOw0KPiDCoH0NCj4gwqANCj4gKyNkZWZpbmUgVElNRU9VVF9GT1JfSFdfUkRZ
X01TCQkJMzAwDQo+ICsNCj4gwqAvKioNCj4gwqAgKiBpc2hfZndfcmVzZXRfd29ya19mbigpIC0g
RlcgcmVzZXQgd29ya2VyIGZ1bmN0aW9uDQo+IMKgICogQHVudXNlZDogbm90IHVzZWQNCj4gQEAg
LTU1Miw3ICs1NTQsNyBAQCBzdGF0aWMgdm9pZCBmd19yZXNldF93b3JrX2ZuKHN0cnVjdCB3b3Jr
X3N0cnVjdA0KPiAqdW51c2VkKQ0KPiDCoAlydiA9IGlzaF9md19yZXNldF9oYW5kbGVyKGlzaHRw
X2Rldik7DQo+IMKgCWlmICghcnYpIHsNCj4gwqAJCS8qIElTSCBpcyBJTFVQICYgSVNIVFAtcmVh
ZHkuIFJlc3RhcnQgSVNIVFAgKi8NCj4gLQkJc2NoZWR1bGVfdGltZW91dChIWiAvIDMpOw0KPiAr
CQltc2xlZXBfaW50ZXJydXB0aWJsZShUSU1FT1VUX0ZPUl9IV19SRFlfTVMpOw0KPiDCoAkJaXNo
dHBfZGV2LT5yZWN2ZF9od19yZWFkeSA9IDE7DQo+IMKgCQl3YWtlX3VwX2ludGVycnVwdGlibGUo
JmlzaHRwX2Rldi0+d2FpdF9od19yZWFkeSk7DQo+IMKg
