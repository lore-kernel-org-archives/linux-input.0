Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795525732;
	b=a1py/O5b97Jdi0p3w0BrDkix5kaFf3/UihiSfgBlTLW/kePHG79g+UBwMc+YwXzk3oPc
	 0Il8wM9yoxrQvVahaaytuFUTDSfmvGVFEb6KtjqFRHeJ3p9gacIOl2EXjXCH3Q3Gnqltc
	 8lNxG/5QCVB8fDv2B2TR4lJ6xakyBGvYpPM5d5CmgVmgUuv7fD/Kag7aBNVOoTeC8K1V/
	 BVvHNmDN3JXj+Zocdg61oIU9BS6uNzpj+K2nMe2Pj9bH1nKw+bHPvkxj1aYJwvEwNTucD
	 E+VEE/CbOzgAOWnMl2EFXQYvxi33/h6drMIEuGSCQNUyYeW3NyFbbMf0ynjt4ItRXzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525732;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Content-Language:
	 From:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=msYZK5ytPl8qKKCV6KhsMHbgx7s+83d6N2eTtOR06bc=;
	b=pRq4IMbvOsLlg9mksW8a9Dw48oU2YW9iuBy1GSy95zViRnZSaJbP/yAurX4hen3W5aMJ
	 lVimm4LW7hGWm6XwYF0v7lKXfbwCTMGWSRz8gMGvumZZ/AyYFHW0tu4YTlS0U/uzPGnvu
	 Mo5MdUGJ21665xE4p1TssxYS23QtuspR/sY2hJGRobCt+G0dEeeiQSppBpoHsFPZEI0Yg
	 18l8/cfht65A+N8cor90SlFBzywfR/Eqk2fhxNe9cR2V3thGFiV/ufNM3Em1eaoU0cW5I
	 JfOv+8MzUkAvaFv59NZS++ZGA5VzhRPTzx/Xiab7svLoYN9UiowbDMpPy8AR98UIVnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=plamper.com;
	spf=none smtp.mailfrom=plamper.com;
	dkim=pass header.d=plamper.com header.i=@plamper.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=U7gWN0uS;
	dkim=pass header.d=plamper.com header.i=@plamper.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="5/kXZDhd";
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.20
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5A606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 13:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4A5A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plamper.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=plamper.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plamper.com header.i=@plamper.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=U7gWN0uS;
	dkim=pass header.d=plamper.com header.i=@plamper.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=5/kXZDhd
ARC-Seal: i=1; a=rsa-sha256; t=1795525693; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=O38Q4NV/hddvNSS+APH/3qL+xNOtvueWSaTH0V9vQC/QG0sBvGQy5Uj9USPn2Ke/cE
    wrlcKaiWjO87v45CPx1wUScIcPAtAJ/OmY38dBgACmtM66p1dLrAlIvlYUbspZ3kQNMz
    9FDBysDLhkOzt2jgxxtFEOmuax2IjGr4C5z/GUyabsffmRNSQW5rEgH9XNzBUoQKXTog
    uFsDwnqWOHWYBGmf2ZbadosqJWn+csdOjAH4ZGdsHXNRrgvT6+m6yUde8S4oFAVAjBvS
    RMdS22ok5vyV3ngNGK6ejqvKQ3WOqiZq0uuBhlHu5Hc/rFMRKkbQbqXXAverA7cz+cQE
    teUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795525693;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=msYZK5ytPl8qKKCV6KhsMHbgx7s+83d6N2eTtOR06bc=;
    b=WJW8Qq3dd7+c3BZiHUqnSxn2mi/3XomQ8LikR3FJscncCCb0PS/p1AzHs+ff6u8oGv
    yTRPKJWF/6bLXPMCBnc5Xl795w3GyyUZ3UE2eg7SYOD4zKIWATZgiGxoAKVxG3Tk6LmY
    /t3GSpCloJ7dc1wVJPC4r0MEPca+TLP537yCAbVI0fZlmW0hJ+fn7oL+23UQlXHbbfVv
    8/obVfSaKP/WJ2Af6/Y6XljSaEKTaIn/CMBoj1pZ2pMbE5J/nYFKxKg2guEUxmg37bsk
    Aj7B1+SF8UXTbMzb5FNCUegC7HL/mtbnpMy9jDob+IFzth0JvZ32kJsanzpbrZKAuu9z
    7E1A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795525693;
    s=strato-dkim-0002; d=plamper.com;
    h=Cc:To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=msYZK5ytPl8qKKCV6KhsMHbgx7s+83d6N2eTtOR06bc=;
    b=U7gWN0uSNe0CZ1TxGKAP6K/xknkzpPsXMMl/eflZtxiJsK4mEqgLHsCvxT1XpiE4lq
    WB7HgVv/S3OelpOh3wCra+cqXW3ioPHTh1r++5gaXZVx7XPDHK068gSa3JCVILRpGVfL
    n1isCqpMxuLFKQtAJfRZ44tuhxo4AX42BSbA2BUV1h/Rj/u0mS/FG6O49FkcXaHjL/dy
    J9eHLRe9WZSogn6wqUdPB4jdfn3A3IwUO4honjdrISCZwSekYeD+1nGpHcvrO9AOHg0T
    WDKBXqd/QKOsU864IKbCU2fnazVTDbZyFI3EChvR/ooyVIJsy/VKImuTdJ7lD0eP4vWd
    saLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795525693;
    s=strato-dkim-0003; d=plamper.com;
    h=Cc:To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=msYZK5ytPl8qKKCV6KhsMHbgx7s+83d6N2eTtOR06bc=;
    b=5/kXZDhdqAT0521CY2acWVaj8oa+0K/+21ggwuZFRK9rum/AktPxVmD3GfJ0BxZE9m
    FjEl+2ifc4/4FUPqzxAQ==
X-RZG-AUTH: ":KmkIfFiIa/PduFlmlzlQvmlOb71gHElbhgsSPxOFNRkvB3ccTjKq2nHOg0SdSv87"
Received: from [10.172.128.204]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id 5b30a62AOD8D3Dk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 24 Nov 2026 14:08:13 +0100 (CET)
Message-ID: <74ce70a8-8faf-4bf0-8967-e5b4a4418ced@plamper.com>
Date: Tue, 24 Nov 2026 14:08:11 +0100
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
From: Felix Plamper <felix@plamper.com>
Subject: [REGRESSION] HID: logitech-hidpp: Signature M650 Bluetooth side
 buttons broken in GNOME/browsers
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org, hadess@hadess.net,
 regressions@lists.linux.dev, edouglas7358@gmail.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

After upgrading to Linux 7.3.4 (NixOS 26.05, GNOME 50 / Wayland), the
two side buttons on my Logitech Signature M650 (Bluetooth ID
0005:046D:B02A) stopped working for Back/Forward navigation in GNOME
apps and web browsers. The same mouse still works as expected over the
USB dongle.

This appears to be a regression introduced by:
   HID: logitech-hidpp: enable reprogrammable buttons on Signature M650

Before Linux 7.3 (and still over USB), the side buttons emitted
BTN_SIDE (275) and BTN_EXTRA (276). With the new HID++ 2.0 diversion
enabled for Bluetooth in 7.3, they now emit BTN_BACK (278) and
BTN_FORWARD (277), which GTK/Firefox/Chromium seem to ignore for
standard mouse Back/Forward navigation.

Remapping BTN_BACK -> BTN_SIDE and BTN_FORWARD -> BTN_EXTRA in
userspace (via evremap) immediately restores Back/Forward navigation.

Wouldn't it make more sense to map the diverted 0x0053 / 0x0056 controls
to BTN_SIDE and BTN_EXTRA instead of BTN_BACK and BTN_FORWARD so
standard Linux desktop navigation doesn't break?

Device info (libinput list-devices):
   Device: Logitech Signature M650
   Id:     bluetooth:046d:b02a

Logs:
$ sudo libinput debug-events
event16  POINTER_BUTTON               +390.788s        BTN_BACK (278) 
pressed, seat count: 1
event16  POINTER_BUTTON               +390.953s        BTN_BACK (278) 
released, seat count: 0
event16  POINTER_BUTTON               +392.506s        BTN_FORWARD (277) 
pressed, seat count: 1
event16  POINTER_BUTTON               +392.701s        BTN_FORWARD (277) 
released, seat count: 0

After Remap:
  event17  POINTER_BUTTON               +0.570s  BTN_EXTRA (276) 
pressed, seat count: 1
  event17  POINTER_BUTTON               +0.773s  BTN_EXTRA (276) 
released, seat count: 0
  event17  POINTER_BUTTON               +1.635s  BTN_SIDE (275) pressed, 
seat count: 1
  event17  POINTER_BUTTON               +1.808s  BTN_SIDE (275) 
released, seat count: 0

With USB Dongle:
  event19  POINTER_BUTTON               +2.828s  BTN_SIDE (275) pressed, 
seat count: 1
  event19  POINTER_BUTTON               +2.835s  BTN_SIDE (275) 
released, seat count: 0
  event19  POINTER_BUTTON               +5.003s  BTN_EXTRA (276) 
pressed, seat count: 1
  event19  POINTER_BUTTON               +5.010s  BTN_EXTRA (276) 
released, seat count: 0

#regzbot introduced: v7.2..v7.3

Thanks,
Felix Plamper
