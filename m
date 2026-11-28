Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795845793;
	b=faixYPSzZmSGzZLRZxKy7Q2myCP3QYN9+aPHCTksrJTbDGz4dXOimeYGf6A+f9BHD3sP
	 i3pC0V42hZQAsacKAvzhIkpOJslS/s2GUEPtWQ0uAvtQVJDEMobd0oaAhNPrRskKUWRf2
	 tzAv1uZabdhfVIR4VWZL9qqskDQVpU8hXcABwnufmEoj3502hinR5qD+PzccgygZ0fvP6
	 FWWFm4tUwrlsljrBqQr+e1BIBwVSb4gX7PXJzrBc3RwnA1MD+7hJwbewv9gieU3709EMZ
	 L7Va+vcEHus2qFzY5tfIm88wjleUscI91AQqkaXPCVdbP8zQLq1YCdOpwXbdvOj6mXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795845793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=T5ObL4ant1RfNVzUA/jc7AaSPqIK2NtdkreTgf5cxY0=;
	b=1LXxKzG48yd4fX+yOxG65SSCSSKH7jOlsXQBCET+iw6IhOICBCmSICfLrvV1SANdYdtG
	 CU4n2xdNDsRSSpVYTJi61lMLUSUFi6TzouVXP2w6bvrGAde+LrEa7/tjGLf+76wQCQ4I/
	 1sIqXz7+puzaHh/zWlp07BIMlllGaAze/KBAt7x1IgfRTLmZzGk7jAB7GtxTQZj457asl
	 wurN2otijoi88tV0WrMc/BS5OPVy8EcDhNsdJeDOSfQgti/IWtbqg3cXxtaIRh1EDYZH6
	 7BkTrI3HLh8PIwCvsKd5mgHe0G5liUFlCRgw+b/aKzuwBK/NZIl8pgoyQtbPCMbKecw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QxxEhVQJ;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B76606A31C
	for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 06:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8B76606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QxxEhVQJ
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-8479f46ecd8so3415157a34.0
        for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 22:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795845791; x=1796450591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T5ObL4ant1RfNVzUA/jc7AaSPqIK2NtdkreTgf5cxY0=;
        b=QxxEhVQJhOhq3n+AhdijsqNgukRSwAYsv+cVj9HZQTHAeubkmEpPtFw3yl2322JJ2s
         ZFGptmpKgJ7gQMfc6kuxoKvyvZ8NXfQnBd669svQDcY4NKxjSzFRQ4DjDyAQ9ZbngS8b
         tkfAgv/dG4g9/qLq0IU50n3s9UtoOJC35Gt/0+F4c325ZABbBLqYQthgHRRHPpDuqELd
         t457PNa89BGFMINjKtOvH2Ivk71vfoZqR4RCQAPIxPpwOTetkYzms3hrax4vp4cBexHQ
         wr6EO8d5rd7gSzI9N3eLaTVfkLeNpzuXM5S9mYqIt3F2Rw4okHMkfxjA8ZVaeisTg3i4
         iUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795845791; x=1796450591;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T5ObL4ant1RfNVzUA/jc7AaSPqIK2NtdkreTgf5cxY0=;
        b=fj28+4ODfJhpApoBr++QpwwQtsVEKyRe6szZrC53DQ3lPAH1NmItttzKzdY+X2QFWl
         Ho3nuL6Agr4q08xiJV9dwKk0BYvd4PDnKApbR0AYAhJORlHnLRDQbtSiPvF4g6o179fU
         7suQXrjEGYfWfnye3ah1NyjH1eI9xyTlPEXI9Ty2WnvKHX8Q/07oo+0AGOtyj9KfwiSv
         /NGcz273ouzsNaCX6dvkPFCRYmmSmKgtbZ6O13nC88bVB5BZo7AsBPBTJMIv9ChFq4+T
         k2zDvPhEn9FQXE367pPYMlzSTx631WJHKyJm5p4R35jpP27+dvK820YSUTApxdul+eWn
         7MSg==
X-Gm-Message-State: APuU4Z/D/k232KjgiWkT0Vgfltx61KDRf24qCXEgKZc6xzmCOhyEwcVf
	RNRIFXN01pp8UhDz6Jmogou9JFgXgktoj2Jddk/35J06Ecnvb9Zzwpwx14TRQA==
X-Gm-Gg: AZFdTZeTdIVL4u5vh6ibXS/kkhHE68KFKuKWTpY1Gp0m9hEIfLighI/3dCgwJ9iCcXu
	tFnDVzrqpEdDiLnmHey4IVN8JpUQqCKFijGz8rlnfskiCsO+69OuByfZWdCkAaSxnUtDy2oi4IB
	ssM7rRfSdeQfIPZ0LDzMrot0nmVWY5K/Ge6PxBip89W8HLlPnVHMZ7tzzmESPnxO+6lkVCE0xrG
	NMXBAFVYrttSbdw+hiimnmxRxRxIDgzzMz+yup/naJRTAPB84smGZv2uqCqoUlFqtddP0fo0814
	9LOv7sTUlwRCPV/2FhxAY2lYbwxRmbedGI9wNZJyl/i7NJxqPc9k43o+p+iXz3EERqyOy7fc9Np
	12NQQIxH8QHrfXO6UJaHZlrZf9Ld+B8PYZcoUOJpSgoPbtssuRwKWKIFo/1vgUBFuL5so8kfZU1
	BDcvvLp9SVQEdoPxjY58igGwXTmVWg6In523lJCPYEvI9J+2KjKsymRVRjaX1UbkVAltdeseGQn
	6MJZ2AA46wDEvjNTjtX3S3r1ShVA66OJtHOQjft6DU+8KXNFNqKb/YDrtf4UMFs7u4ofXsfQOfl
	51tnABBSbAxddpLdYGVH4X/uH5Himtm/YV7a8/ZgGdGnbL7mtMw/kr1/FKs2vnlhMPPVQ8YWr8p
	AaFThBPLSczOIVR8=
X-Received: by 2002:a05:6808:f13:b0:567:f784:f939 with SMTP id 5614622812f47-57a0bb54177mr24059131b6e.51.1795845791579;
        Fri, 27 Nov 2026 22:03:11 -0800 (PST)
Received: from [172.16.122.129] (107-138-215-199.lightspeed.snantx.sbcglobal.net. [107.138.215.199])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc61081159sm23313934fac.15.2026.11.27.22.03.11
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 22:03:11 -0800 (PST)
Message-ID: <928141b5-2355-406c-8699-426639509782@gmail.com>
Date: Sat, 28 Nov 2026 00:03:10 -0600
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-input@vger.kernel.org
From: Richard Aghassibake <raaghassi@gmail.com>
Subject: Suspend/Wake Numlock Handling and Unintended Rewakes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I have recently been digging into an issue with a Fedora system that 
repeatedly wakes itself immediately after entering suspend. I have 
traced the root cause of the issue to an interaction between the 
keyboard's numlock behavior and the kernel's suspend actions.

In short, the keyboard echoes its lock state any time the lock state 
changes.  This is in support of software functionality to read and 
display the lock state on the host.  When the kernel calls a suspend, it 
fires a routine that disables a number of lock keys (numlock, capslock, 
scroll lock) as part of a process to turn off their associated LEDs.

When the suspend fires, the keyboard echoes the lock state change, which 
unsuspends the keyboard device and wakes the host. The echo on lock 
state is intended by the keyboard manufacturer since it hooks their 
software to provide lock state awareness on keyboards that do not have 
LEDs to indicate lock state.

While I understand the logic of wanting to turn off lights when the host 
is suspended, it seems like this is one of many potentially unintended 
interactions that might occur from changing a lock state as a means to 
turn off an LED.

Given the proliferation of LED-'enhanced' devices and software to 
integrate with them, and the increasing complexity of those devices and 
their associated functions, it seems probable that this will become more 
likely in the future.

I recommend adding parameters to allow the lock state behavior on 
suspend to be controlled more granularly, allowing such interactions to 
be avoided by inhibiting the lock state change. While the lock state 
change is itself not problematic, unexpected driver integrations by 
hardware manufacturers appear to have rendered it somewhat fragile.

Please let me know if any additional information is required to support 
this recommendation.

Thank you,

Richard Aghassibake

