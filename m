Received: from singapore.rrx.ca (singapore.rrx.ca [45.77.175.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB171D63E4
	for <linux-input@vger.kernel.org>; Sat,  2 May 2026 04:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.175.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696968; cv=none; b=NnW6yD3f7+VNIwfj9bR3Ug054TFlmsuJlIYH3S++0PLtuG+bJZ0HdWCnnESE6hCspdSuj8RQh77ouDjXgO+EiY503S3FfmlAVxAjHrMIBAlV9qGjUuq1Ns4Es/VEwDFoGXVYz7Djxrp1ckxBQl2zxu9GFOCbs6eDTmzASFMg2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696968; c=relaxed/simple;
	bh=wJyky+4+zBJ0tBiBpOWvAsbxnARJDB3FzLX/15RLGIQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=Q5Kb95/yo68mWITrJkCXqdOqr5EiazSI45GsHbR2jLFQI2CwRXlSYEynnDf4WMobDWL/WB7yD9s3wFzw0s8qWZZxrwVwt9kQ3Yoy8Dt5zGuzfNxvRP0/CxxtFGSr25evIhoX6eBbrDmu9tK1IyvYi0BIPvy7XwUBwJdNaHf347o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rrx.ca; spf=pass smtp.mailfrom=rrx.ca; dkim=pass (1024-bit key) header.d=rrx.ca header.i=@rrx.ca header.b=VB/zZbfP; arc=none smtp.client-ip=45.77.175.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rrx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rrx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rrx.ca header.i=@rrx.ca header.b="VB/zZbfP"
Received: from [100.107.1.99] (unknown [113.188.118.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by singapore.rrx.ca (Postfix) with ESMTPSA id 1F7F85024C
	for <linux-input@vger.kernel.org>; Sat, 02 May 2026 12:35:14 +0800 (+08)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rrx.ca; s=singapore;
	t=1777696514; bh=FXm27CSm34omNyFaeLyMXsyIpDc93GaKM1czNNr/OVc=;
	h=Date:To:From:Subject;
	b=VB/zZbfPNcRWXWgUJz45LQWFlkoCYXGAmv0wjVGBHw2YNQckf0/ak3UfmsV9H7JRH
	 ZMtSkkQkzR5EtTl7JGtZeFWTesj8byKAbYyleTh8uyf6A62oo/C/nUqhwE+m2aCI5v
	 SMZ5mYPz6VZb/0+O6brZZAJR0C8A7YGlmaFWO5zI=
Content-Type: multipart/mixed; boundary="------------fpfOErz00kXOXyfvoJrXnVaW"
Message-ID: <fca0ca85-63da-4c3b-8121-64a4ef77b649@rrx.ca>
Date: Sat, 2 May 2026 11:35:13 +0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-input@vger.kernel.org
From: Randy Sommerfeld <cyan@rrx.ca>
Subject: Fix for Chromecast Remote not working

This is a multi-part message in MIME format.
--------------fpfOErz00kXOXyfvoJrXnVaW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I've attached source code for a kernel module that fixes my Chromecast 
Remote.  Prior to this module, when pressing buttons on the Chromecast 
Remote, I'd get these in the dmesg:

hid-generic 0005:18D1:9450.0004: Event data for report 1 was too short 
(2 vs 1)

It seemed like a simple fix (accepting 1 instead of 2 for this specific 
remote), and the attached module fixes this.

I'm not sure where this belongs in the main tree (perhaps as a quirk in 
drivers/hid/ somewhere), which is why I'm submitting this as a module 
instead of a patch.

As an unsophisticated dev I thought I'd bring this to someone's 
attention since it might allow these remotes to be useful, and the fix 
seems simple.  Thank you.

Cheers,
-Randy.

--------------fpfOErz00kXOXyfvoJrXnVaW
Content-Type: text/x-csrc; charset=UTF-8; name="chromecast_remote.c"
Content-Disposition: attachment; filename="chromecast_remote.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPGxpbnV4L2hpZC5oPgojaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CgojZGVm
aW5lIFVTQl9WRU5ET1JfSURfR09PR0xFIDB4MThkMQojZGVmaW5lIFVTQl9ERVZJQ0VfSURf
Q0hST01FQ0FTVF9SRU1PVEUgMHg5NDUwCgpzdGF0aWMgY29uc3QgX191OCAqY2NfcmVtb3Rl
X3JlcG9ydF9maXh1cChzdHJ1Y3QgaGlkX2RldmljZSAqaGRldiwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgX191OCAqcmRlc2MsCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCAqcnNpemUpCnsKICAgICAgICBpZiAoKnJz
aXplID09IDB4MzkgJiYKICAgICAgICAgICAgcmRlc2NbMHgzMl0gPT0gMHg5NSAmJgogICAg
ICAgICAgICByZGVzY1sweDMzXSA9PSAweDAyICYmCiAgICAgICAgICAgIHJkZXNjWzB4MzRd
ID09IDB4NzUgJiYKICAgICAgICAgICAgcmRlc2NbMHgzNV0gPT0gMHgwOCkgewogICAgICAg
ICAgICAgICAgaGlkX2luZm8oaGRldiwgImZpeGluZyBDaHJvbWVjYXN0IFJlbW90ZSBkZXNj
cmlwdG9yXG4iKTsKICAgICAgICAgICAgICAgIHJkZXNjWzB4MzNdID0gMHgwMTsKICAgICAg
ICB9CgogICAgICAgIHJldHVybiByZGVzYzsKfQoKc3RhdGljIGNvbnN0IHN0cnVjdCBoaWRf
ZGV2aWNlX2lkIGNjX3JlbW90ZV9kZXZpY2VzW10gPSB7CiAgICAgICAgeyBISURfQkxVRVRP
T1RIX0RFVklDRShVU0JfVkVORE9SX0lEX0dPT0dMRSwKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFVTQl9ERVZJQ0VfSURfQ0hST01FQ0FTVF9SRU1PVEUpIH0sCiAgICAgICAg
eyB9Cn07Ck1PRFVMRV9ERVZJQ0VfVEFCTEUoaGlkLCBjY19yZW1vdGVfZGV2aWNlcyk7Cgpz
dGF0aWMgc3RydWN0IGhpZF9kcml2ZXIgY2NfcmVtb3RlX2RyaXZlciA9IHsKICAgICAgICAu
bmFtZSA9ICJjaHJvbWVjYXN0X3JlbW90ZSIsCiAgICAgICAgLmlkX3RhYmxlID0gY2NfcmVt
b3RlX2RldmljZXMsCiAgICAgICAgLnJlcG9ydF9maXh1cCA9IGNjX3JlbW90ZV9yZXBvcnRf
Zml4dXAsCn07Cgptb2R1bGVfaGlkX2RyaXZlcihjY19yZW1vdGVfZHJpdmVyKTsKCk1PRFVM
RV9MSUNFTlNFKCJHUEwiKTsKTU9EVUxFX0RFU0NSSVBUSU9OKCJDaHJvbWVjYXN0IFJlbW90
ZSBISUQgZGVzY3JpcHRvciBmaXh1cCIpOwo=

--------------fpfOErz00kXOXyfvoJrXnVaW--
