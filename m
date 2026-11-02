Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=212.227.122.201
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793624851;
	b=aaMr2zxp+0OB7D58IZqNRTFH3Ap2qPoIcYryPhRrUqJm5l95btVN/oJRW/wRCVy3hCbs
	 bdvelr6zdqCnEz8+0I+htbyTG0MPjXoJ4+bFqnodLWpTsUwdM+HZJ7T1xHW/2FNV0l6LZ
	 pQuqk2vFeCla10RzoD2Rb/NpRp9auooVTbJbu2q1k5Pfh+iZ8rw2dcmhU8xxWlojLVZ7W
	 Nbkr/hCKUTqyFmR6wO/lXVaLqtWouOtS/M/tooKV8GVtRd4mC4xag0KoEfu4oQhVEEAzv
	 gfTl0qHhd5kgur8uFRcsnLwQlkv7TmojoAoM3SVwt97Ty9D80YaqBCECt2btmaCfnug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624851;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:Received:
	 X-RZG-AUTH:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Content-Language:To:Subject:Content-Type:Content-Transfer-Encoding;
	bh=tlEeRbuREoaMkWVy+GMqAlZARaT7V8NUC9+oG+jQN+c=;
	b=KxySoAuYcaZIl5bWw9OAlc0NkoEj5zzQkAqM/lL95SciZgsGAoNMWrGFq5Xs6c38Ijz+
	 vnMWccC5HkHnO1s/PoKnZcP5pl5XGLctvbN5CXmnVvT9OZ3XbhU5ZGqeXHxuy8eWhgdpr
	 qL5nQIzFdz+Fn9VHiv/yrqeVpCf/ntokXPbRpq94Zz3HeziIbLX8Xo4WE35l2aHMvUmjj
	 1F8rBiI3DzElfbCXLmMyvCzBX84ICqjRMzEcTK3/lfUYtZ8V7dIPUzToLkLhZrk5B8Hds
	 lOedOm1S3DGZdVdDUeIXX4/gBb8TibLpbnpdSIRA6Bx/iwbQ0S6b6fLcuGB0Vl8DaFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=graspcomputing.co.uk;
	spf=pass smtp.mailfrom=graspcomputing.co.uk;
	dkim=pass header.d=graspcomputing.co.uk header.i=@graspcomputing.co.uk header.a=rsa-sha256 header.s=livemail1 header.b=fWe1ORHP;
	dkim=pass header.d=graspcomputing.co.uk header.i=@graspcomputing.co.uk header.a=ed25519-sha256 header.s=livemail3 header.b=pu+UXzMo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=212.227.122.201
Received: from t1-mo4-p00.gem.livemail.co.uk (t1-mo4-p00.gem.livemail.co.uk [212.227.122.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214F606A331
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 13:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9214F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=graspcomputing.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=graspcomputing.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=graspcomputing.co.uk header.i=@graspcomputing.co.uk header.a=rsa-sha256 header.s=livemail1 header.b=fWe1ORHP;
	dkim=pass header.d=graspcomputing.co.uk header.i=@graspcomputing.co.uk header.a=ed25519-sha256 header.s=livemail3 header.b=pu+UXzMo
ARC-Seal: i=1; a=rsa-sha256; t=1793624843; cv=none;
    d=arc.gem.livemail.co.uk; s=arc-0001;
    b=V7p0oBZWHuszYw6KgiGmEP6Wf+Cfl5mw3xxRDRCdtw3O2dO5eAy9WmGON0pQFW3Sht
    Y8DrMA8qfCQo7WaUkz9lF1HLJPfSBQ3sdHqGR1m7Wn9P4zYytqw4NAaI+P+wW402zeEr
    426sMYeDITcx/kZAnhC+qrGWz12GSi65FkzC2lznx5BL42bzop1gGmUomUioGW2wdEUA
    +MWExZzAmLr1KekhJdb7iIic20xJIdjQ9KhWzhINeT0Q0g39u5yz4Vf7Ti2n3oNaGJsP
    CPtjWWV4T4LrTu6jukcgkRXaZ3jlQv+2s56IrS0dN++nlck/8g2fuUJ7uVD+7DE+9z7p
    IDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793624843;
    s=arc-0001; d=arc.gem.livemail.co.uk;
    h=Subject:To:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=tlEeRbuREoaMkWVy+GMqAlZARaT7V8NUC9+oG+jQN+c=;
    b=c6BjGnrfM9ZJDwg1NHZJWz0DevD+vr4LkhWxHX5UwBPPstyE4IgKuiHPaU2EyXNmnU
    ElcV9iMKXXT2Q9VN+9r5Vz2yZSr1PoLM+O+nDFPaFnJV2Lhrr4ixLBnWCjbYBYlvKmij
    A455yooUzrC3lB8WBXb3CBEehXmwHRU7o3ooHdxQXqig3rfbcjmoczG28OHWbXVQr6kZ
    Nb5P4r2nWlRk5ASmpsMCOcf3DTpIKWby89Ve2hCj9V6hJVnqPCQX4OrMZOc5teO6grtP
    NoYbMRM6U8F+GroyYVYor0rRFhgwz48dxeKIjbnBCIxTl2mESfriuO9qj61MAkbdggwL
    feHw==
ARC-Authentication-Results: i=1; arc.gem.livemail.co.uk;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793624843;
    s=livemail1; d=graspcomputing.co.uk;
    h=Subject:To:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=tlEeRbuREoaMkWVy+GMqAlZARaT7V8NUC9+oG+jQN+c=;
    b=fWe1ORHPelEo33jGCtg7gHiA3qSJCyPMGrIsHbiIVyeSDE8kCkaLOThogJ0e/8xlge
    4cpqGPY6g1a3vf26WN8V1LeqKTQ+MFlrff9MKXe199GepLEIbxYnp6Bqsq8gdrNDdw33
    VPJ9CcQtsHtBnb5T4k5ySaaJPfB9QxdT0c650Ys8etJITu6Dn29N8zhNB/CoA9HwkGSC
    plGRF0BzKIbBaIEj/XeR68XWDjWhXliVTzo8WxBljtnekOcM3qLRvRRXRazpITKNKjqa
    muWCu8zHwuG2aQ+m2D7UNxwI3er2wwN2AiE+GHSUtzCzclUlFFw0vKkTMN9UMrLDf5m7
    6aYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793624843;
    s=livemail3; d=graspcomputing.co.uk;
    h=Subject:To:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=tlEeRbuREoaMkWVy+GMqAlZARaT7V8NUC9+oG+jQN+c=;
    b=pu+UXzMo1mQ9kDfC9nQmzvsw5++F/wPzL5HyT+ZR8u/LnChIzPx7rzjBmbwX5nVHMO
    ebu03VnaOul7Q+I8UsDg==
Received: from smtp.livemail.co.uk ([127.0.0.1])
    by smtp.livemail.co.uk (RZmta 55.6.4 n,-,???,???,??- am=0)
    with ESMTPSA id Q000602A2D7N01t
    for <linux-input@vger.kernel.org>;
    Mon, 2 Nov 2026 13:07:23 +0000 (UTC)
X-RZG-AUTH: ":LWAFe2Cvaf6AJrOqOUYmoWLzYqR0D4hrgYZ9YT8a83S7x76YuFHbMQEJh5iRl3fLNi5vFRKQJw=="
Received: from [192.168.1.116]
    by smtp.livemail.co.uk (RZmta 55.6.4 AUTH)
    with ESMTPSA id Q000602A2D7N01t
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <linux-input@vger.kernel.org>;
    Mon, 2 Nov 2026 13:07:23 +0000 (UTC)
Message-ID: <0f994e8e-4378-4031-9292-ed4edcb3b24b@graspcomputing.co.uk>
Date: Mon, 2 Nov 2026 13:07:22 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
From: Alan Aspland <alan@graspcomputing.co.uk>
Content-Language: en-GB
To: linux-input@vger.kernel.org
Subject: psmouse: synaptics probe silently skipped on 7.0 (Sony SVE1513A4E,
 PS/2 Synaptics)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

To: linux-input@vger.kernel.org
Subject: psmouse: synaptics probe silently skipped on 7.0 (Sony 
SVE1513A4E, PS/2 Synaptics)

Hello,

I'm reporting a regression in the psmouse synaptics subdriver on kernel 
7.0.0-42-generic (Zorin OS 24.04 / Ubuntu 24.04 HWE).

Hardware: Sony Vaio SVE1513A4E, PS/2 Synaptics TouchPad (ACPI ID 
SNY9008, PNP ID PS2M)

Symptom: On 7.0, the touchpad is registered as "PS/2 Synaptics TouchPad" 
with only "Capabilities: pointer". The synaptics extended protocol is 
never negotiated. There are zero "psmouse serio1: synaptics:" log lines 
in dmesg - not even a failure message - indicating the probe is being 
skipped entirely.

On kernel 6.8.0-147-generic, the same hardware negotiates successfully:
     psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, 
caps: 0xd00123/0x840300/0x127c00/0x0, board id: 1999, fw id: 1106483
     input: SynPS/2 Synaptics TouchPad

Kernel command line (both kernels):
     i8042.nomux=1 i8042.reset=1 i8042.nopnp=1 i8042.noloop=1 
psmouse.synaptics_intertouch=1

dmesg on 7.0 (relevant lines only):
     [    0.330668] i8042: PNP: PS/2 Controller 
[PNP030b:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
     [    0.339382] serio: i8042 KBD port at 0x60,0x64 irq 1
     [    0.339393] serio: i8042 AUX port at 0x60,0x64 irq 12
     [    1.589259] input: PS/2 Synaptics TouchPad as 
/devices/platform/i8042/serio1/input/input5

libinput on 7.0:
     Device:           PS/2 Synaptics TouchPad
     Capabilities:     pointer
     Tap-to-click:     n/a
     Scroll methods:   *button
     Click methods:    none

libinput on 6.8 (working):
     Device:           SynPS/2 Synaptics TouchPad
     Size:             96x52mm
     Capabilities:     pointer gesture
     Scroll methods:   *two-finger edge
     Click methods:    *button-areas clickfinger

Notes:
- No SMBus companion (PNP ID is PS2M, not a Synaptics SMBus ID)
- rmi4_i2c is not present in the 6.8 modules dir; no I2C touchpad detected
- The issue is intermittent on 6.8 (cold boot sometimes fails, manual 
"modprobe -r psmouse && modprobe psmouse" fixes it) - suggesting a 
timing/race issue that 7.0 made worse or eliminated entirely
- No BIOS SMBus access messages in dmesg

I'd appreciate any pointers on where the probe might be getting skipped 
in 7.0. Happy to provide further logs or test patches.

Thanks,
Alan
EOF

