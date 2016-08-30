From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] iio: fix pressure data output unit in
 hid-sensor-attributes
Date: Tue, 30 Aug 2016 19:49:52 +0000
Message-ID: <1472586592.5025.3.camel@intel.com>
References: <1472467856-14526-1-git-send-email-hock.leong.kweh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37710 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbcH3Ttz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 Aug 2016 15:49:55 -0400
In-Reply-To: <1472467856-14526-1-git-send-email-hock.leong.kweh@intel.com>
Content-Language: en-US
Content-ID: <18520B43B306E74ABE0EA48E64998F10@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jikos@kernel.org" <jikos@kernel.org>, "Kweh, Hock Leong" <hock.leong.kweh@intel.com>, "jic23@kernel.org" <jic23@kernel.org>
Cc: "Lay, Kuan Loon" <kuan.loon.lay@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "Ong, Boon Leong" <boon.leong.ong@intel.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "Ooi, Joyce" <joyce.ooi@intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Lim, Lee Booi" <lee.booi.lim@intel.com>

T24gTW9uLCAyMDE2LTA4LTI5IGF0IDE4OjUwICswODAwLCBLd2VoLCBIb2NrIExlb25nIHdyb3Rl
Og0KPiBGcm9tOiAiS3dlaCwgSG9jayBMZW9uZyIgPGhvY2subGVvbmcua3dlaEBpbnRlbC5jb20+
DQo+IA0KPiBBY2NvcmRpbmcgdG8gSUlPIEFCSSBkZWZpbml0aW9uLCBJSU9fUFJFU1NVUkUgZGF0
YSBvdXRwdXQgdW5pdCBpcw0KPiBraWxvcGFzY2FsOg0KPiBodHRwOi8vbHhyLmZyZWUtZWxlY3Ry
b25zLmNvbS9zb3VyY2UvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy0NCj4gYnVzLWlp
bw0KPiANCj4gVGhpcyBwYXRjaCBmaXggb3V0cHV0IHVuaXQgb2YgSElEIHByZXNzdXJlIHNlbnNv
ciBJSU8gZHJpdmVyIGZyb20NCj4gcGFzY2FsIHRvDQo+IGtpbG9wYXNjYWwgdG8gZm9sbG93IElJ
TyBBQkkgZGVmaW5pdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEt3ZWgsIEhvY2sgTGVvbmcg
PGhvY2subGVvbmcua3dlaEBpbnRlbC5jb20+DQpSZXZpZXdlZC1ieTogU3Jpbml2YXMgUGFuZHJ1
dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQoNCj4gLS0tDQo+IMKg
Li4uL2lpby9jb21tb24vaGlkLXNlbnNvcnMvaGlkLXNlbnNvci1hdHRyaWJ1dGVzLmMgfMKgwqDC
oMKgNCArKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9jb21tb24vaGlkLXNlbnNvcnMv
aGlkLXNlbnNvci1hdHRyaWJ1dGVzLmMNCj4gYi9kcml2ZXJzL2lpby9jb21tb24vaGlkLXNlbnNv
cnMvaGlkLXNlbnNvci1hdHRyaWJ1dGVzLmMNCj4gaW5kZXggZTgxZjQzNC4uZGMzM2MxZCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vY29tbW9uL2hpZC1zZW5zb3JzL2hpZC1zZW5zb3ItYXR0
cmlidXRlcy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2NvbW1vbi9oaWQtc2Vuc29ycy9oaWQtc2Vu
c29yLWF0dHJpYnV0ZXMuYw0KPiBAQCAtNTYsOCArNTYsOCBAQCBzdGF0aWMgc3RydWN0IHsNCj4g
wqAJe0hJRF9VU0FHRV9TRU5TT1JfQUxTLCAwLCAxLCAwfSwNCj4gwqAJe0hJRF9VU0FHRV9TRU5T
T1JfQUxTLCBISURfVVNBR0VfU0VOU09SX1VOSVRTX0xVWCwgMSwgMH0sDQo+IMKgDQo+IC0Je0hJ
RF9VU0FHRV9TRU5TT1JfUFJFU1NVUkUsIDAsIDEwMDAwMCwgMH0sDQo+IC0Je0hJRF9VU0FHRV9T
RU5TT1JfUFJFU1NVUkUsIEhJRF9VU0FHRV9TRU5TT1JfVU5JVFNfUEFTQ0FMLA0KPiAxLCAwfSwN
Cj4gKwl7SElEX1VTQUdFX1NFTlNPUl9QUkVTU1VSRSwgMCwgMTAwLCAwfSwNCj4gKwl7SElEX1VT
QUdFX1NFTlNPUl9QUkVTU1VSRSwgSElEX1VTQUdFX1NFTlNPUl9VTklUU19QQVNDQUwsDQo+IDAs
IDEwMDB9LA0KPiDCoH07DQo+IMKgDQo+IMKgc3RhdGljIGludCBwb3dfMTAodW5zaWduZWQgcG93
ZXIp
