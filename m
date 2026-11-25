Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.247.34.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619399;
	b=LgvBThwYySiFT8bwELngAg8EI/XE+XdQwzTi7yQ67+q+PEXVEGWyt4fThQRoE4N5nv5L
	 hK34zLkjThaqtB8QyakYiK27v3++8psDVk+2/O1vw9A3xzynsIfYX9E4EWkm20uUaXUiN
	 C9Ax73C//4gZFhSDll0JlfZMLYmTXF5eKJxi3RnajBxFAVKACoP7wRTVS12En/dq+PK6d
	 a5jRQ/+MHMipcYkXH61MPYFNd9f3osWCSMh0mDN3k06EeylH1Gog0vadPtvJU54oCpaLp
	 53IWZUzplaIZh46FUIMjIx49uIO8I6kt8kNnJ0Vll3zC4LxVIrIkaE+JbxJP+5JJvpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619399;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:
	 x-tm-as-product-ver:x-tm-as-result:x-tmase-matchedrid:
	 x-tm-as-user-approved-sender:x-tm-as-user-blocked-sender:
	 x-tmase-result:x-tmase-version:x-tm-snts-smtp:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-SM-outgoing;
	bh=hNDwGs4JY92qM5GuwlXsa5+R2yd/EgIrf3P9H2V2YnI=;
	b=xqNqyAO//HPNNLUUAtdtOFF+o6uWm53SlR+xzzVvICFN0se6obd6oKU7rog16qvCSX+U
	 VS3zWN67IUbANb3Tt7mcXhIXpRaI5xGpzu4kvg7sepjBtwkSLq6vtCVz7Tvq/56PkOdzM
	 65bMKAn4tukSbIAD2e4AgxkzsecfBK1/Y/rCuYgrAVYix6OC5p1Lobizxd7ZtN/Ml6UAP
	 zmS4t00hRdyL4bPpw/gHYRIkOk2QF3NOyIh30I3MbmiLeb0pm/0dPi8i88+oBzENAMVbs
	 prs9XZ1hWuD5WPWdL8txwOZBey9aOlUJInWzCjJQa9b+lxYhdQOANJeMAV67+600MXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stiftung-kifa.ch;
	spf=pass smtp.mailfrom=stiftung-kifa.ch;
	dkim=pass header.d=stiftung-kifa.ch header.i=@stiftung-kifa.ch header.a=rsa-sha256 header.s=default header.b=tmRPKkh3;
	arc=none smtp.remote-ip=46.247.34.138
Received: from hin.itze.ch (hin.itze.ch [46.247.34.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA1606A321;
	Wed, 25 Nov 2026 15:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FBA1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stiftung-kifa.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stiftung-kifa.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stiftung-kifa.ch header.i=@stiftung-kifa.ch header.a=rsa-sha256 header.s=default header.b=tmRPKkh3
Received: from hin (localhost [127.0.0.1])
	by hin.itze.ch (Postfix) with SMTP id 4jZNQC1BWTz1wt1;
	Wed, 25 Nov 2026 16:09:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=stiftung-kifa.ch; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=default; bh=hNDwGs4JY92qM5GuwlXsa5+R2yd/EgIrf3P9H2V2YnI=; b=t
	mRPKkh3q5dCjykVvVphXN2E4SfCUffPTTAsXYgMCTJw0qBMrLJb3bR2zeZglRZwd
	BnQWiS0zaGoDKM0iA7OKddNMb3xZMcTVz9Z70RfBM2Af6sD8SRmR+mC6i6ruqitm
	8EdrlKjoVo4yWEhb2msIXREA6uOEPeEaUfHt8V8TNSS2svDl44DlEexjLD1XzYTK
	ecrT60dYb5SBaGg+X0Fr4VC2muJqi6TXq29d1kHdTRYidvk1DtNp0E7asU4hI8wm
	qxeg06Bz/89zV3znfGJmkoKZAauL8VYzTaVcCkyhd3wc9+FnEZbgwh9l92gq1ZfD
	UlpGB6dubJsWB2/D8477w==
Received: from owa.itze.ch (unknown [10.200.0.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hin.itze.ch (Postfix) with ESMTPS;
	Wed, 25 Nov 2026 16:09:54 +0100 (CET)
Received: from owa.itze.ch (ITZE-EXC-32.intranet.itze.ch [10.200.0.157])
	by itze-smtp-02.intranet.itze.ch (Postfix) with ESMTPS id BB11838029E;
	Wed, 25 Nov 2026 16:09:53 +0100 (CET)
Received: from ITZE-EXC-42.intranet.itze.ch (10.200.0.152) by
 ITZE-EXC-32.intranet.itze.ch (10.200.0.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 16:09:52 +0100
Received: from ITZE-EXC-42.intranet.itze.ch ([fe80::423d:c966:8c82:e690]) by
 ITZE-EXC-42.intranet.itze.ch ([fe80::423d:c966:8c82:e690%9]) with mapi id
 15.02.2562.057; Wed, 25 Nov 2026 16:09:52 +0100
From: Kettler Christian <christian.kettler@stiftung-kifa.ch>
To: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: Logitech BRIO (046d:085e) stops answering control requests when
 hot-plugged together with a USB-C hub; usbhid probe blocks hub_wq for 60 s
Thread-Topic: Logitech BRIO (046d:085e) stops answering control requests when
 hot-plugged together with a USB-C hub; usbhid probe blocks hub_wq for 60 s
Thread-Index: AQHdfE3oSkrSsszgEUuTDYAdvXeAA7c+zRyAgAAHjwA=
Date: Wed, 25 Nov 2026 15:09:52 +0000
Message-ID: <2ced9c1fb45e08a94f56b0f569b01369044b5553.camel@stiftung-kifa.ch>
References: <3cd5f994a6260960cf7751d6383f2b9afc1baeb5.camel@stiftung-kifa.ch>
	 <6118ad01-65a0-4357-8118-3122479b554d@rowland.harvard.edu>
In-Reply-To: <6118ad01-65a0-4357-8118-3122479b554d@rowland.harvard.edu>
Accept-Language: de-CH, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3239-9.1.2019-30344.000
x-tm-as-result: No-10--22.376900-4.000000
x-tmase-matchedrid: OcgHo5wAKs4uv++HU7VXr4kiMwVwGI5YN0X64jGy2dZa78hB0x+GaWrB
	IjJ00a+8v77u9R/aB9qlugByZXPyC2s4la5Zj25PnRTJpY7VAKdWC9fz8m/BCup5tGJpTGx+ehd
	Z/bwq3VZhbKuwJkPkeBvbmZvUlTFCiJPaA+9YMuoRTDvoAtlgqbsXVhBSg7MsM4EUfzJw8Z7NwE
	HRsS7DKuzUC9+2W8CH27VTKqjamRkDcBI2JS3GLQvpq/ti8dx8+HAk4j3F9/QY5qQDqF7ovga0/
	l8gU1kEx7b1Bc6N2azdt0Uq15xuqRYs+VEpi6SZ0RneM2u5ms9Xbgp6+gO14VXOqMYNeYhmES46
	qCSbf/X5gNZJP+k/L6JYuGaIjh0/7lupSRApbpZ8SAso7jsI54s3wSS0wttw6QLge8Tcpn0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--22.376900-4.000000
x-tmase-version: SMEX-14.0.0.3239-9.1.2019-30344.000
x-tm-snts-smtp: 2F701C539FBD8CD0309A777ED42DCEDA819B603622EB2FB055EB049195D4C7A22002:9
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4BCCAE8F42D9F498FC93825EAD752FA@intranet.itze.ch>
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

QW0gTWl0dHdvY2gsIGRlbSAyNS4xMS4yMDI2IHVtIDA5OjQyIC0wNTAwIHNjaHJpZWIgQWxhbiBT
dGVybjoNCj4gT24gVHVlLCBOb3YgMjQsIDIwMjYgYXQgMDc6NTY6MzVQTSArMDAwMCwgS2V0dGxl
ciBDaHJpc3RpYW4gd3JvdGU6DQo+ID4gU3ViamVjdDogTG9naXRlY2ggQlJJTyAoMDQ2ZDowODVl
KSBzdG9wcyBhbnN3ZXJpbmcgY29udHJvbCByZXF1ZXN0cw0KPiA+IHdoZW4gaG90LXBsdWdnZWQg
dG9nZXRoZXIgd2l0aCBhIFVTQi1DIGh1YjsgdXNiaGlkIHByb2JlIGJsb2Nrcw0KPiA+IGh1Yl93
cQ0KPiA+IGZvciA2MCBzDQo+IA0KPiA+IDEuIElzIHRoZXJlIGEga25vd24gaXNzdWUgd2l0aCB0
aGUgQlJJTyBzdG9wcGluZyB0byBhbnN3ZXIgY29udHJvbA0KPiA+IMKgwqAgdHJhbnNmZXJzIHNo
b3J0bHkgYWZ0ZXIgZW51bWVyYXRpb24gKHdpdGggdGhlIHVzYmhpZCBwcm9iZSBiZWluZw0KPiA+
IG9ubHkNCj4gPiDCoMKgIHRoZSBmaXJzdCByZXF1ZXN0IHRoYXQgd2FpdHMpPyBXb3VsZCBhIHF1
aXJrIChlLmcuDQo+ID4gwqDCoCBVU0JfUVVJUktfREVMQVlfQ1RSTF9NU0cgZm9yIDA0NmQ6MDg1
ZSwgb3IgYW4gc25kLXVzYi1hdWRpbw0KPiA+IMKgwqAgY29udHJvbC1tZXNzYWdlIGRlbGF5KSBi
ZSB3b3J0aCB0ZXN0aW5nPyBJZ25vcmluZyB0aGUgSElEDQo+ID4gaW50ZXJmYWNlDQo+ID4gwqDC
oCBhbG9uZSBkb2VzIG5vdCBoZWxwLg0KPiANCj4gTm8gc2ltaWxhciBpc3N1ZXMgYXJlIGtub3du
IHRvIG1lLg0KPiANCj4gR28gYWhlYWQgYW5kIHRlc3QgYW55IHF1aXJrcyB5b3UgdGhpbmsgbWln
aHQgYmUgcmVsZXZhbnQuwqAgQXMgZm9yIA0KPiB3aGV0aGVyIHRoYXQgd2lsbCBiZSB3b3J0aHdo
aWxlIC0tIHdobyBrbm93cz8NCj4gDQo+ID4gMi4gQ2FuIHRoZSBrZXJuZWwgcmVjb3ZlciBmcm9t
IGEgZGV2aWNlIHRoYXQgc3RvcHMgYW5zd2VyaW5nDQo+ID4gY29udHJvbA0KPiA+IMKgwqAgcmVx
dWVzdHMgZHVyaW5nIHByb2JlIHdpdGhvdXQgYmxvY2tpbmcgaHViX3dxIGZvciBldmVyeQ0KPiA+
IGludGVyZmFjZSBpbg0KPiA+IMKgwqAgdHVybj8NCj4gDQo+IE5vLsKgIFRoZSByZWFzb24gaXMg
YmVjYXVzZSB0aGUgZGV2aWNlIG1pZ2h0IHN0b3AgYW5zd2VyaW5nIHJlcXVlc3RzDQo+IG9uIA0K
PiBvbmUgaW50ZXJmYWNlIG9ubHksIGJ1dCBnbyBvbiBhbnN3ZXJpbmcgdGhlbSBvbiBvdGhlciBp
bnRlcmZhY2VzLsKgDQo+IE9uZSANCj4gbm9uLXdvcmtpbmcgaW50ZXJmYWNlIHNob3VsZG4ndCBw
cmV2ZW50IG90aGVyIGludGVyZmFjZXMgZnJvbSBiZWluZyANCj4gcHJvYmVkLCBpZiB0aGV5IG1p
Z2h0IGJlIHdvcmtpbmcuDQo+IA0KPiBBbGFuIFN0ZXJuDQoNClRoYW5rcyBmb3IgdGhlIHJlcGx5
Lg0KDQpJIHRlc3RlZCB0aGUgdGhyZWUgcXVpcmtzIG9uZSBhdCBhIHRpbWUgYXQgcnVudGltZSAo
MDQ2ZDowODVlOmssIDpuDQphbmQgOmcgdmlhIC9zeXMvbW9kdWxlL3VzYmNvcmUvcGFyYW1ldGVy
cy9xdWlya3MsIGNvbmZpcm1lZCBpbiB0aGUNCmRldmljZSdzIHF1aXJrcyBhdHRyaWJ1dGUpIGFu
ZCB0aGVuIHBsdWdnZWQgaW4gdGhlIGh1YiB3aXRoIHRoZSBCUklPDQphdHRhY2hlZC4gTm9uZSBv
ZiB0aGVtIGhlbHBlZDsgZXZlcnkgcnVuIGh1bmcgb24gdGhlIGZpcnN0IHBsdWcuDQoNClRoZSB0
aW1lb3V0cyBhcmUgbm90IGxpbWl0ZWQgdG8gdGhlIEJSSU8sIHRob3VnaC4gRHVyaW5nIHRoZXNl
IHJ1bnMNCnRoZSBodWIgaXRzZWxmIChWSUEgMjEwOTowODI0KSBvbmNlIGZhaWxlZCB3aXRoICJk
ZXZpY2UgZGVzY3JpcHRvcg0KcmVhZC9hbGwsIGVycm9yIC0xMTAiLCB0aGUgUmVhbHRlayBMQU4g
YWRhcHRlciBpbnNpZGUgdGhlIGh1YiBnb3QgYQ0KLTExMCBhbmQgd2FzIHJlc2V0LCBhbmQgdGhl
IGh1YidzIGNhcmQgcmVhZGVyIHdhcyByZXNldCBhcyB3ZWxsLg0KUmUtYXV0aG9yaXppbmcgdGhl
IGh1YiAoYXV0aG9yaXplZCAwLzEpIG5ldmVyIHRyaWdnZXJzIHRoZSBoYW5nLCBvbmx5DQpwaHlz
aWNhbGx5IHBsdWdnaW5nIGl0IGluIGRvZXMuIE9uIHRoZSBsYXB0b3AncyBvd24gcG9ydHMgdGhl
IEJSSU8NCm5ldmVyIGh1bmcgKDE0IHBsdWdzLCA0IG9mIHRoZW0gb24gdGhlIFVTQi1DIHBvcnQg
b24gdGhlIHNhbWUgeEhDSQ0KY29udHJvbGxlciwgd2l0aCB0aGUgc2FtZSBjYWJsZSBhbmQgcGx1
ZyBhZGFwdGVyKS4NCg0KU28gdGhpcyBsb29rcyBsaWtlIGEgcHJvYmxlbSB3aXRoIHRoaXMgaHVi
IHJhdGhlciB0aGFuIHdpdGggdGhlDQpjYW1lcmEuIEknbSB1c2luZyB0aGUgQlJJTyBkaXJlY3Rs
eSBvbiB0aGUgbGFwdG9wIG5vdyBhbmQgY29uc2lkZXINCnRoaXMgY2xvc2VkIG9uIG15IHNpZGUu
DQoNCkNocmlzdGlhbg0K
