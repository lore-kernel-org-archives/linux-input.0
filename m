Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6173126A0;
	Sat,  1 Aug 2026 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785543296; cv=none; b=Fve08GPbJoMVq8SdRHH5aEv7Rcgh9BGbFYajxXGSB0eFnASow4iWI6E09PvVwu7+HlmFaZskJ6w0LOcKX8u9YM8QzmvhxQcM247m7et5WbRWkNEmySDxCgk12dlaufxP/CoH2mlHQVkwFGid7+jhR2WZw3fNUOig5lH0ckJlHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785543296; c=relaxed/simple;
	bh=dNOeR00fRlwK7wGxxoYsD1F7Mr7lIqg0jal8U93h1Bg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:Mime-Version:
	 Content-Type; b=HHcSPdodRbtBWk/wfBdkL1J0fPJfY6bjtWBWmXckYJ8hCljtzbJKiRQRs78XzToBsVTQ4zrQqegySAx0BIRCFvdOdLk8dY2kfLWMstE0bWOvrDw9spGUnslC8iQqHCGF32OIHGs8jUGhI/ZP8M+Ydp+vebmxHH4Ya4lMZE8icOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=pI7/eEkH; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="pI7/eEkH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785543287;
	bh=dNOeR00fRlwK7wGxxoYsD1F7Mr7lIqg0jal8U93h1Bg=;
	h=Date:From:To:Cc:Subject:References;
	b=pI7/eEkHP/Ris8ocJylfdWsa2L63/EEXMceg8niui0Kuwe9OiTP+EwI/ZKp6LOkkV
	 Q8RiQ/+k20P3qGHIrIQPKjTZxntkbGtsDhUp2sug+rTgss/zYAdiMA2O14OmIJ9ip0
	 W5J8+NDCZ9pndiz8nuT8ZLTCECTdoq6BpqWUYupc=
Received: from DESKTOP-HVU54AA ([42.236.208.180])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 3AD3C4F6; Sat, 01 Aug 2026 08:14:45 +0800
X-QQ-mid: xmsmtpt1785543285tg30b862j
Message-ID: <tencent_1D34F37A96CC0EA28368551A7237463B3909@qq.com>
X-QQ-XMAILINFO: MYkhwtPldtoNacmBQLPz74zKD0FjR7T87BT9IznAEeaOKNkVQVn2PNUcXGpUJp
	 tllWiWKKuBqj89nnqbs0/rBRp04wK9mXbcc79NRYco6yRISxcldt0OB7Um+EuAASAonFJIjea/1S
	 4iuztwScR1MLvnxMr9gbpe+2xZ8GX7kj/K/knSFrwRRb5/arhynJOhpOUnic9B9TlpplPHuZg0zX
	 pN1eEsnX5ZvyjcoKpC0oz8A3YPdpfVjUCIxRjZ7QtoBhpTCNuF22w4nwsso7/VKTRq3DGw/6jXgI
	 PAAVANWzqfaOuLgTB8fTcCo42VVMr/RGH+fIDRbtX5oQCoNjE4Z+vILNpgXdVhWy17Mx/XrqZ1TS
	 KxsdrVYi5/RamrdMBDtxDRPN2255hvAKy4haAzscHCzZLVfvGx/rrHr7rAKYtyC8pDSmLNMDw858
	 JzKCEnMu609/ifsDivUIh44vZ48TcMs/1czwxBWLpaNQ9FL+MpJZxw0Xv2FIkX9LVf4d7fLJjUmh
	 I1hQ6xSr78D3QFRu/YSIZNKSBAQ1x9488oXGMJjj0J2OKCR5mcyASmKBzGZ8Q3meB6w2yuNwgpMQ
	 axgu28+W9ioP/WGqAyJo4tLlgRljia6WOVj+4lY+ysHGcVEzhX2lHXkiLyuXXWP5uYbo74w6cil2
	 QgXf/ieGVMzJEI2WECu/h939ANw7fwTj8pmtaMZITPAS9lE1LPGPI930MWUWfo0Ai0ejkWk5aYYt
	 VA9HMyN2KLOp5whJvw4F+TNgsULjlgFIa/0acU44am4zvOpoMqn7U/Jy1uS24Dvxfl/4rN1nf1Io
	 w+POcPwYnmnwoTA3zkfXyDdrJATv09E2KuEmLUbsPjLngKIlBM2lcAiqve3oZ2NGo9c71yhcArWb
	 E5HtHKLR3wGOBpAGPftXCpDZKEXWGxxYrQlXnDIwWuRDtC2vJLSDqjnEMEw6yrUovqu/LjyiJZ+I
	 k9mTbY7FuIBt6vRHh9HHCfCe3Se8Z94DuExFjIqBgyKCj/TC14dS8FpQ67kmDCQYviCr5k0+nA69
	 1fwhvfD4PCTu5gqowXW5vAM2kQjSHyb+VwK/EsivQQvmfUWtk6gfJ0RYKpkFVLnQHiuxRtGJoOxr
	 WQQbSmZ64Ez5sEHZlQGeE5TTDBJGJrfPkoXqKsBWtOuZM2mBU2xeCkVJ0hXHMTzWyzkjgQ06s8c0
	 ahr9Y=
X-QQ-XMRINFO: Mp6WenUyxxn3VribuFk9P6NqYwZgpaaJwg==
Date: Sat, 1 Aug 2026 08:14:43 +0800
From: "grayhat@foxmail.com" <grayhat@foxmail.com>
To: srinivas.pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: gregkh <gregkh@linuxfoundation.org>, 
	lixu.zhang <lixu.zhang@intel.com>, 
	jikos <jikos@kernel.org>, 
	bentiss <bentiss@kernel.org>, 
	linux-input <linux-input@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] HID: intel-ish-hid: clamp HID device count to MAX_HID_DEVICES
References: <tencent_D20397201115F1DCF4D1798EA0BCC6A5B007@qq.com>, 
	<e338934762abc4f13366ba9607790e9ffdb55427.camel@linux.intel.com>, 
	<tencent_6754CC7275468D3928F24E966C0F6682CA09@qq.com>, 
	<f4c87fcd71ac8226edec3b2fcdb30988573089f0.camel@linux.intel.com>
X-Priority: 3
X-GUID: 19DBC7E8-AC91-4875-A37C-3F42798BD84E
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.542[cn]
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-OQ-MSGID: <2026080108144256943412@foxmail.com>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

Pk9uIEZyaSwgMjAyNi0wNy0zMSBhdCAwOTo0NiArMDgwMCwgZ3JheWhhdEBmb3htYWlsLmNvbSB3
cm90ZToKPj4gTGV0IG1lIGtub3cgaWYgeW91IHdhbnQgaXQgcmVzZW50IGFzIGEgcHJvcGVyIFtQ
QVRDSCB2Ml0uCgoKPlllcyB3aXRoIG5ldyB2ZXJzaW9uLiBBZGQgVGVzdGVkIGJ5IHRhZyBhbHNv
IGZyb20gTGl4dS4KCgo+QWxzbyBzb21lIHN1Z2dlc3Rpb25zOgoKCgo+LSBBdm9pZCB0b3AgcG9z
dGluZyBsaWtlIHRoaXMsIHlvdSBjYW4gYWRkIHRoaXMgcGFydCBqdXN0IGFmdGVyIHlvdXIKCgoK
PmV4aXN0aW5nIHRhZ3MuCgoKCj4tIElmIHRoZSBwYXRjaCBpcyBsb25nIHlvdSBjYW4gdHJpbQoK
Cj4tIEkgdGhpbmsgeW91IHVzZSBvdXRsb29rIHRvIHJlcGx5LCB0aGVyZSBhcmUgc29tZSBzdWdn
ZXN0aW9ucyBvZiBlbWFpbAoKCgo+Y2xpZW50cyBhbmQgb3RoZXIgc3VnZ2VzdGlvbnMuCgoKCj5o
dHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL2VtYWlsLWNsaWVudHMuaHRtbAoKCj5BbHNv
IHNvbWUgb3RoZXIgbGlua3M6CgoKCj5odHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90
ZXMtYWJvdXQtbmV0aXF1ZXR0ZQoKCgo+aHR0cHM6Ly9zdWJzcGFjZS5rZXJuZWwub3JnL2V0aXF1
ZXR0ZS5odG1sCgoKPlRoYW5rcywKCgoKPlNyaW5pdmFzCgpUaGFua3MgZm9yIHlvdXIgcmV2aWV3
LgpQYXRjaCB2MyBoYXMgYmVlbiBwb3N0ZWQsIGluY2x1ZGluZyB0aGUgVGVzdGVkLWJ5IHRhZyBm
cm9tIExpeHUsIGFuZAp0aGUgZW1haWwgcXVvdGluZyBmb3JtYXQgaGFzIGJlZW4gZml4ZWQgZm9s
bG93aW5nIHlvdXIgcmVjb21tZW5kYXRpb25zLgoKU2hlbiBZb25nY2hhbwoKCg==

