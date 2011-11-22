From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH TRIVIAL 1/5] Input: keyboard: use macro
 module_platform_driver()
Date: Tue, 22 Nov 2011 14:15:09 -0600
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3E96DA6B1@AUSP01VMBX24.collaborationhost.net>
References: <1321952446-7591-1-git-send-email-jj_ding@emc.com.tw>
 <1321952446-7591-2-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail209.messagelabs.com ([216.82.255.3]:54646 "EHLO
	mail209.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab1KVUPq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Nov 2011 15:15:46 -0500
In-Reply-To: <1321952446-7591-2-git-send-email-jj_ding@emc.com.tw>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Grant Likely <grant.likely@secretlab.ca>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, JJ Ding <dgdunix@gmail.com>

T24gVHVlc2RheSwgTm92ZW1iZXIgMjIsIDIwMTEgMjowMSBBTSwgSkogRGluZyB3cm90ZToNCj4g
DQo+IENvbW1pdCA5NDBhYjg4OTYyYmMxYWZmMzI3M2E4MzU2ZDY0NTc3YTZlMzg2NzM2IGludHJv
ZHVjZWQgYSBuZXcgbWFjcm8gdG8NCj4gc2F2ZSBzb21lIHBsYXRmb3JtX2RyaXZlciBib2lsZXJw
bGF0ZSBjb2RlLiBVc2UgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKSiBEaW5nIDxkZ2R1bml4
QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lucHV0L2tleWJvYXJkL2VwOTN4eF9rZXlw
YWQuYyAgICAgIHwgICAxNCArLS0tLS0tLS0tLS0tLQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW5wdXQva2V5Ym9hcmQvZXA5M3h4X2tleXBhZC5jIGIvZHJpdmVycy9pbnB1dC9rZXlib2Fy
ZC9lcDkzeHhfa2V5cGFkLmMNCj4gaW5kZXggNDY2MmM1ZC4uMGJhNjlmMyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9lcDkzeHhfa2V5cGFkLmMNCj4gKysrIGIvZHJpdmVy
cy9pbnB1dC9rZXlib2FyZC9lcDkzeHhfa2V5cGFkLmMNCj4gQEAgLTM5MCwxOSArMzkwLDcgQEAg
c3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgZXA5M3h4X2tleXBhZF9kcml2ZXIgPSB7DQo+
ICAJLnN1c3BlbmQJPSBlcDkzeHhfa2V5cGFkX3N1c3BlbmQsDQo+ICAJLnJlc3VtZQkJPSBlcDkz
eHhfa2V5cGFkX3Jlc3VtZSwNCj4gIH07DQo+IC0NCj4gLXN0YXRpYyBpbnQgX19pbml0IGVwOTN4
eF9rZXlwYWRfaW5pdCh2b2lkKQ0KPiAtew0KPiAtCXJldHVybiBwbGF0Zm9ybV9kcml2ZXJfcmVn
aXN0ZXIoJmVwOTN4eF9rZXlwYWRfZHJpdmVyKTsNCj4gLX0NCj4gLQ0KPiAtc3RhdGljIHZvaWQg
X19leGl0IGVwOTN4eF9rZXlwYWRfZXhpdCh2b2lkKQ0KPiAtew0KPiAtCXBsYXRmb3JtX2RyaXZl
cl91bnJlZ2lzdGVyKCZlcDkzeHhfa2V5cGFkX2RyaXZlcik7DQo+IC19DQo+IC0NCj4gLW1vZHVs
ZV9pbml0KGVwOTN4eF9rZXlwYWRfaW5pdCk7DQo+IC1tb2R1bGVfZXhpdChlcDkzeHhfa2V5cGFk
X2V4aXQpOw0KPiArbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihlcDkzeHhfa2V5cGFkX2RyaXZlcik7
DQo+ICANCj4gIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gIE1PRFVMRV9BVVRIT1IoIkggSGFy
dGxleSBTd2VldGVuIDxoc3dlZXRlbkB2aXNpb25lbmdyYXZlcnMuY29tPiIpOw0KDQpBY2tlZC1i
eTogSCBIYXJ0bGV5IFN3ZWV0ZW4gPGhzd2VldGVuQHZpc2lvbmVuZ3JhdmVycy5jb20+DQoNClRo
YW5rcyE=
