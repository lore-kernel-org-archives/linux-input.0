From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Staging: hv: mousevsc: Move the mouse driver out of
 staging
Date: Sat, 15 Oct 2011 13:24:05 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481AA0FE18@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1318658907-16698-1-git-send-email-kys@microsoft.com>
 <1318660596.6035.27.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailc.microsoft.com ([131.107.115.214]:45858 "EHLO
	smtp.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab1JONYH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Oct 2011 09:24:07 -0400
In-Reply-To: <1318660596.6035.27.camel@Joe-Laptop>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9lIFBlcmNoZXMgW21h
aWx0bzpqb2VAcGVyY2hlcy5jb21dDQo+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDE1LCAyMDEx
IDI6MzcgQU0NCj4gVG86IEtZIFNyaW5pdmFzYW4NCj4gQ2M6IGdyZWdraEBzdXNlLmRlOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZlbEBsaW51eGRyaXZlcnByb2plY3Qub3Jn
OyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5vc2RsLm9yZzsNCj4gZG1pdHJ5LnRvcm9raG92QGdtYWls
LmNvbTsgbGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnOyBIYWl5YW5nIFpoYW5nDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMS8xXSBTdGFnaW5nOiBodjogbW91c2V2c2M6IE1vdmUgdGhlIG1vdXNl
IGRyaXZlciBvdXQgb2YNCj4gc3RhZ2luZw0KPiANCj4gT24gRnJpLCAyMDExLTEwLTE0IGF0IDIz
OjA4IC0wNzAwLCBLLiBZLiBTcmluaXZhc2FuIHdyb3RlOg0KPiA+IEluIHByZXBhcmF0aW9uIGZv
ciBtb3ZpbmcgdGhlIG1vdXNlIGRyaXZlciBvdXQgb2Ygc3RhZ2luZywgc2VlayBjb21tdW5pdHkN
Cj4gPiByZXZpZXcgb2YgdGhlIG1vdXNlIGRyaXZlciBjb2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSy4gWS4gU3Jpbml2YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4NCj4gDQo+IEp1c3Qg
c29tZSBzdHlsaXN0aWMgdGhpbmdzLCBub25lIG9mIHdoaWNoIHNob3VsZA0KPiBwcmV2ZW50IGFu
eSBjb2RlIG1vdmVtZW50Lg0KDQpUaGFua3MgSm9lLiBJIHdpbGwgZml4IHRoZSBpc3N1ZXMgeW91
IGhhdmUgbm90ZWQgZWl0aGVyIGJlZm9yZSBvciBhZnRlcg0KbW92aW5nIHRoZSBjb2RlIG91dCBv
ZiBzdGFnaW5nIGJhc2VkIG9uIG90aGVyIHJldmlldyBjb21tZW50cy4NCg0KUmVnYXJkcywNCg0K
Sy4gWSANCg==
