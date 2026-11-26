Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.247.34.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685289;
	b=1Ao8wkYvtronyk7VFVgJx53D/WE0kET8NnO5ASBfkT+5pqnIw+c+0koV/ZvdnHrj1mp1
	 ECepQq1272mZ7qvii9m5qwQkQT1xuVJRng9jUq3Eajse4WB+YYUQATvOI5akbM4yYVhR9
	 wh+PLfSGeFT0kGPZcbAdxKQIcNHS/yReGMlSTqFVxiT6wJH91T9VdCQhfd5VvQI4VGroa
	 x2SCKc7Ysn6xm3JCI75XNPQeHHKh6KDxBXCC6jCenEc7O0hOVAe4KtFdJKw2qYzLJOAFN
	 d2PXxUln5YSueXJRAZnH8QLFwwqyPK5xar+KInumzIeVL1Mf0CDe6T1sdq0AT4qnulA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685289;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-ID:Content-Transfer-Encoding:MIME-Version:X-SM-outgoing;
	bh=svWs/aM38Vlawjp8seZdqmsqok/OpRYqNFaPL6I7pEA=;
	b=zsQSGPLE3A77a0az3BIDjzzmDFzJijZGEcxELtbFaCpVd7dLlGUhOMVd1wFoZn3w7BN5
	 qc0ABaouoVl9+oJqG1ZRkxMO/wA5PPsJnJKXFEpRfE8w8sQNSuGl8LYFY8HyiPYWKXpn5
	 OMLpIoZhvrv77RmaHi3oyUS1LmhC7Sunp6pM4TqT0HhVZK6FfIPaPzQwWZzconPF3AcY+
	 9ad9WPwhNQB7Er/TBnRlr+fWsB5Pf4YhAz9DWqU1UiyyPUKogzOYY7IqW3DXwTvhJsP3h
	 2T1PO/RMKykga8xMdrqPxSc726t5o5VgKSx751gkXLPqhg5d+wMGy/JYH4D4jbV3I8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stiftung-kifa.ch;
	spf=pass smtp.mailfrom=stiftung-kifa.ch;
	dkim=pass header.d=stiftung-kifa.ch header.i=@stiftung-kifa.ch header.a=rsa-sha256 header.s=default header.b=qPRELP+m;
	arc=none smtp.remote-ip=46.247.34.138
Received: from hin.itze.ch (hin.itze.ch [46.247.34.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7377606A31E;
	Thu, 26 Nov 2026 09:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7377606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stiftung-kifa.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stiftung-kifa.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stiftung-kifa.ch header.i=@stiftung-kifa.ch header.a=rsa-sha256 header.s=default header.b=qPRELP+m
Received: from hin (localhost [127.0.0.1])
	by hin.itze.ch (Postfix) with SMTP id 4jZrnC5qhSz1wsv;
	Thu, 26 Nov 2026 10:27:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=stiftung-kifa.ch; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=default; bh=svWs/aM38Vlawjp8seZdqmsqok/OpRYqNFaPL6I7pEA=; b=q
	PRELP+mB9j3QpEmFCd8GgxnWJWFoj/quSythpZbhq95jIqhIT5FKS3evyuhyVit0
	GgjElkaudUccOLrezItpS8snZ+m8d9U2TptNGZfphMjZd1We5p4HiCXgECpnkIFe
	YOcl5hTX+PF0PHdJd7KwL6L8OIpW0LjJBSqV2nIeDWqVtZQnZSUahn0xPoVvotgu
	SH7x2i7IF6yCzZG0p3lHPa8r1kDF1+pACjreHSjDX7Q3/bMWnx+tAmqpQ9rwlXGV
	kLQ9yPl3RGqzyZPGOTr1SZmqGQWslY9BtlZ9QmbZEfS8g+gM+YZnxXJkQABAS20t
	N062rg7TAh+IRMSqFyq6A==
Received: from owa.itze.ch (unknown [10.200.0.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hin.itze.ch (Postfix) with ESMTPS;
	Thu, 26 Nov 2026 10:27:58 +0100 (CET)
Received: from owa.itze.ch (ITZE-EXC-42.intranet.itze.ch [10.200.0.152])
	by itze-smtp-02.intranet.itze.ch (Postfix) with ESMTPS id 907DC380104;
	Thu, 26 Nov 2026 10:27:58 +0100 (CET)
Received: from ITZE-EXC-42.intranet.itze.ch (10.200.0.152) by
 ITZE-EXC-42.intranet.itze.ch (10.200.0.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 10:27:58 +0100
Received: from ITZE-EXC-42.intranet.itze.ch ([fe80::423d:c966:8c82:e690]) by
 ITZE-EXC-42.intranet.itze.ch ([fe80::423d:c966:8c82:e690%9]) with mapi id
 15.02.2562.057; Thu, 26 Nov 2026 10:27:58 +0100
From: Kettler Christian <christian.kettler@stiftung-kifa.ch>
To: "michal.pecio@gmail.com" <michal.pecio@gmail.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Subject: Re: Logitech BRIO (046d:085e) stops answering control requests when
 hot-plugged together with a USB-C hub; usbhid probe blocks hub_wq for 60 s
Thread-Topic: Logitech BRIO (046d:085e) stops answering control requests when
 hot-plugged together with a USB-C hub; usbhid probe blocks hub_wq for 60 s
Thread-Index: AQHdfE3oSkrSsszgEUuTDYAdvXeAA7c+zRyAgAAHjwCAAEsGgIAA58eA
Date: Thu, 26 Nov 2026 09:27:58 +0000
Message-ID: <cf179ae63e1a3fabc1a1869e0bc1b158ca62d1be.camel@stiftung-kifa.ch>
References: <3cd5f994a6260960cf7751d6383f2b9afc1baeb5.camel@stiftung-kifa.ch>
		<6118ad01-65a0-4357-8118-3122479b554d@rowland.harvard.edu>
		<2ced9c1fb45e08a94f56b0f569b01369044b5553.camel@stiftung-kifa.ch>
	 <20261125203823.15fc4478.michal.pecio@gmail.com>
In-Reply-To: <20261125203823.15fc4478.michal.pecio@gmail.com>
Accept-Language: de-CH, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D30050BA81E86B43B5746C58E226F464@intranet.itze.ch>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-SM-outgoing: yes

QW0gTWl0dHdvY2gsIGRlbSAyNS4xMS4yMDI2IHVtIDIwOjM4ICswMTAwIHNjaHJpZWIgTWljaGFs
IFBlY2lvOg0KPiBPbiBXZWQsIDI1IE5vdiAyMDI2IDE1OjA5OjUyICswMDAwLCBLZXR0bGVyIENo
cmlzdGlhbiB3cm90ZToNCj4gPiBUaGUgdGltZW91dHMgYXJlIG5vdCBsaW1pdGVkIHRvIHRoZSBC
UklPLCB0aG91Z2guIER1cmluZyB0aGVzZSBydW5zDQo+ID4gdGhlIGh1YiBpdHNlbGYgKFZJQSAy
MTA5OjA4MjQpIG9uY2UgZmFpbGVkIHdpdGggImRldmljZSBkZXNjcmlwdG9yDQo+ID4gcmVhZC9h
bGwsIGVycm9yIC0xMTAiLCB0aGUgUmVhbHRlayBMQU4gYWRhcHRlciBpbnNpZGUgdGhlIGh1YiBn
b3QgYQ0KPiA+IC0xMTAgYW5kIHdhcyByZXNldCwgYW5kIHRoZSBodWIncyBjYXJkIHJlYWRlciB3
YXMgcmVzZXQgYXMgd2VsbC4NCj4gPiBSZS1hdXRob3JpemluZyB0aGUgaHViIChhdXRob3JpemVk
IDAvMSkgbmV2ZXIgdHJpZ2dlcnMgdGhlIGhhbmcsDQo+ID4gb25seQ0KPiA+IHBoeXNpY2FsbHkg
cGx1Z2dpbmcgaXQgaW4gZG9lcy4gT24gdGhlIGxhcHRvcCdzIG93biBwb3J0cyB0aGUgQlJJTw0K
PiA+IG5ldmVyIGh1bmcgKDE0IHBsdWdzLCA0IG9mIHRoZW0gb24gdGhlIFVTQi1DIHBvcnQgb24g
dGhlIHNhbWUgeEhDSQ0KPiA+IGNvbnRyb2xsZXIsIHdpdGggdGhlIHNhbWUgY2FibGUgYW5kIHBs
dWcgYWRhcHRlcikuDQo+ID4gDQo+ID4gU28gdGhpcyBsb29rcyBsaWtlIGEgcHJvYmxlbSB3aXRo
IHRoaXMgaHViIHJhdGhlciB0aGFuIHdpdGggdGhlDQo+ID4gY2FtZXJhLiBJJ20gdXNpbmcgdGhl
IEJSSU8gZGlyZWN0bHkgb24gdGhlIGxhcHRvcCBub3cgYW5kIGNvbnNpZGVyDQo+ID4gdGhpcyBj
bG9zZWQgb24gbXkgc2lkZS4NCj4gDQo+IEhpLA0KPiANCj4gTXVsdGlwbGUgZGV2aWNlcyBtaXNi
ZWhhdmluZyBjb3VsZCBiZSB0aGUgaHViIG9yIHBlcmhhcHMgdGhlIHhIQ0kNCj4gY29udHJvbGxl
ciAobG9va3MgbGlrZSBzb21lIEludGVsIGNoaXBzZXQ/KS4gWW91IGNvdWxkIHRyeSBhDQo+IGRp
ZmZlcmVudA0KPiBvbmUgaWYgeW91IGhhdmUgYW4gb3Bwb3J0dW5pdHkuDQo+IA0KPiBUaG91Z2gg
SSBoYXZlIG5vIGV4cGxhbmF0aW9uIHdoeSB0aGUgY2FtZXJhIHdvcmtzIG9uIHRoZSBzYW1lIHBv
cnQgaWYNCj4gdGhlIGh1YiBpcyByZW1vdmVkIGZyb20gdGhlIGNoYWluLiBJdCBtYXkgYmUgdGhl
IGh1YiBhZnRlciBhbGwuDQo+IA0KPiBSZWdhcmRzLA0KPiBNaWNoYWwNCg0KSGkgTWljaGFsLA0K
DQpUaGFua3MuIEkgZG9uJ3QgaGF2ZSBhIFVTQi1DIHBvcnQgb24gYW5vdGhlciBjb250cm9sbGVy
LCBidXQgdGhlDQprZXJuZWwgbG9nIHNpbmNlIE9jdCAzMCBhbHJlYWR5IGhhcyBhIGNvbXBhcmlz
b24gb24gdGhlIHNhbWUNCmNvbnRyb2xsZXIgKDAwMDA6MDA6MGQuMCwgc2FtZSBwb3J0KTogYXQg
d29yayB0aGUgbGFwdG9wIGdvZXMgaW50bw0KYW4gSFAgVVNCLUMgRG9jayBHNSAoTWljcm9jaGlw
IGh1YnMpLCBhdCBob21lIGludG8gdGhpcyBWSUEtYmFzZWQNCmFkYXB0ZXIuDQoNCiAgVklBIGFk
YXB0ZXI6IDk4IGVudW1lcmF0aW9ucywgdGhlIGh1YiBpdHNlbGYgZmFpbGVkIDE0IHRpbWVzDQog
ICAgKCJEZXZpY2Ugbm90IHJlc3BvbmRpbmcgdG8gc2V0dXAgYWRkcmVzcyIgb3IgImRldmljZSBk
ZXNjcmlwdG9yDQogICAgcmVhZC9hbGwsIGVycm9yIC0xMTAiKSwgdGhlIHI4MTUyIGJlaGluZCBp
dCB0aW1lZCBvdXQgMjkgdGltZXMNCiAgSFAgZG9jazogNDUgZW51bWVyYXRpb25zLCBub25lIG9m
IHRoZXNlIGVycm9ycywgaW5jbHVkaW5nIGl0cw0KICAgIHI4MTUyIChzYW1lIFJlYWx0ZWsgMGJk
YTo4MTUzIGNoaXApDQoNClRoZSBWSUEgZXJyb3JzIGdvIGJhY2sgd2Vla3MgYmVmb3JlIEkgZmly
c3QgcGx1Z2dlZCB0aGUgQlJJTyBpbnRvDQppdC4gU28gSSdtIGZhaXJseSBzdXJlIGl0J3MgdGhl
IGh1Yiwgbm90IHRoZSBjb250cm9sbGVyLiBJJ20gZ29pbmcNCnRvIHJlcGxhY2UgdGhlIGFkYXB0
ZXIsIHNvIHRoaXMgaXMgY2xvc2VkIG9uIG15IHNpZGUuDQoNClRoYW5rcyB0byBib3RoIG9mIHlv
dSBmb3IgeW91ciBoZWxwLg0KDQpDaHJpc3RpYW4NCg==
