From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 1/3] hid: intel-ish-hid: ipc: remove unused macro
Date: Tue, 15 Nov 2016 18:09:38 +0000
Message-ID: <1479233376.6544.45.camel@intel.com>
References: <1478828413-31687-1-git-send-email-even.xu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:34117 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933528AbcKOSJo (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Nov 2016 13:09:44 -0500
In-Reply-To: <1478828413-31687-1-git-send-email-even.xu@intel.com>
Content-Language: en-US
Content-ID: <D94D3F27A85C7C4986E1FEA99F04DC95@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jikos@kernel.org" <jikos@kernel.org>, "Xu, Even" <even.xu@intel.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

T24gRnJpLCAyMDE2LTExLTExIGF0IDA5OjQwICswODAwLCBFdmVuIFh1IHdyb3RlOg0KPiBUaGUg
bWFjcm8gdGltZWRfd2FpdF9mb3IoKSBpbiB1dGlscy5oIGlzbid0IHVzZWQgaW4gY3VycmVudCBp
cGMNCj4gZHJpdmVyLCBzbyByZW1vdmUgaXQgZm9yIGF2b2lkaW5nIGNvbmZ1c2lvbi4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEV2ZW4gWHUgPGV2ZW4ueHVAaW50ZWwuY29tPg0KQWNrZWQtYnk6IFNy
aW5pdmFzIFBhbmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPg0K
DQo+IC0tLQ0KPiDCoGRyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL3V0aWxzLmggfCAyMSAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjEgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pcGMvdXRpbHMu
aA0KPiBiL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL3V0aWxzLmgNCj4gaW5kZXggNWE4
MjEyMy4uZGMzOWRmZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9p
cGMvdXRpbHMuaA0KPiArKysgYi9kcml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlkL2lwYy91dGlscy5o
DQo+IEBAIC0xOSwyNyArMTksNiBAQA0KPiDCoCNkZWZpbmUJV0FJVF9GT1JfQ09OTkVDVF9TTElD
RQkoSFogLyAxMCkNCj4gwqANCj4gwqAvKg0KPiAtICogV2FpdHMgZm9yIHNwZWNpZmllZCBldmVu
dCB3aGVuIGEgdGhyZWFkIHRoYXQgdHJpZ2dlcnMgZXZlbnQgY2FuJ3QNCj4gc2lnbmFsDQo+IC0g
KiBBbHNvLCB3YWl0cyAqYXRfbGVhc3QqIGB0aW1laW5jYCBhZnRlciBjb25kaXRpb24gaXMgc2F0
aXNmaWVkDQo+IC0gKi8NCj4gLSNkZWZpbmUJdGltZWRfd2FpdF9mb3IodGltZWluYywgY29uZGl0
aW9uKQkJCQ0KPiBcDQo+IC0JZG8gewkJCQkJCQkNCj4gXA0KPiAtCQlpbnQgY29tcGxldGVkID0g
MDsJCQkJXA0KPiAtCQlkbyB7CQkJCQkJDQo+IFwNCj4gLQkJCXVuc2lnbmVkIGxvbmcJajsJCQkN
Cj4gXA0KPiAtCQkJaW50CWRvbmUgPSAwOwkJCQ0KPiBcDQo+IC0JCQkJCQkJCVwNCj4gLQkJCWNv
bXBsZXRlZCA9IChjb25kaXRpb24pOwkJXA0KPiAtCQkJZm9yIChqID0gamlmZmllcywgZG9uZSA9
IDA7ICFkb25lOyApIHsJDQo+IFwNCj4gLQkJCQlzY2hlZHVsZV90aW1lb3V0KHRpbWVpbmMpOwlc
DQo+IC0JCQkJaWYgKHRpbWVfaXNfYmVmb3JlX2VxX2ppZmZpZXMoaiArDQo+IHRpbWVpbmMpKSBc
DQo+IC0JCQkJCWRvbmUgPSAxOwkJXA0KPiAtCQkJfQkJCQkJXA0KPiAtCQl9IHdoaWxlICghKGNv
bXBsZXRlZCkpOwkJCQkNCj4gXA0KPiAtCX0gd2hpbGUgKDApDQo+IC0NCj4gLQ0KPiAtLyoNCj4g
wqAgKiBXYWl0cyBmb3Igc3BlY2lmaWVkIGV2ZW50IHdoZW4gYSB0aHJlYWQgdGhhdCB0cmlnZ2Vy
cyBldmVudA0KPiDCoCAqIGNhbid0IHNpZ25hbCB3aXRoIHRpbWVvdXQgKHVzZSB3aGVuZXZlciB3
ZSBtYXkgaGFuZykNCj4gwqAgKi8=
