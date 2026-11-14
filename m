Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794648057;
	b=WGnTOcrgdYzVDCENfGZf1eTRO4Ch1J+TPGeTaqkfmfoCRHpCEED0chZEGt7wr52zARAz
	 U6MB4V08ZlxqMIilSAwLLGHOQ+6NNeMPFzxMTfjXA1xf2OryOpUOO0B7zQ+u7WqGH1H94
	 tcvnVPXBdzAD7+oAacjuY0WqyeXN2XN92g/2ke/kRlY4vVJweMGcq0NK5XnSbPhx+ORcC
	 f/vos91bdUrhAEalmGYiBDvo2sE/xHEQLZXtSeKNRp7g0ZmHDibG/ip/h74a3c+mz31nO
	 MGh0mhNZ96juvTVYn3gFLQLtUmK8znTWmAHUYyJcFbeB8d3n39pDJBuRKniz5SHLIbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794648057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=Pwft8v+MK/PzpOQGnfEgS9STpXK24BW5ijOMaGrFS84=;
	b=I020Bccm4ZW6wZ8xEQoYRBuOCI9hTV0XX7hRvN0aiIqIF+tXerHrJND2jwjD8k1eO/lA
	 ICnoklzd+nI1nVCMI808++DIbx+CI4i3lE+iBFzYpMtvrlSasrvz8XMuSrXsxu1FQqwTh
	 TBBuVO6jh79dW/bd3auwOZVzDLxUmOHzVpZuJCbdxLBF0akgCvzCx4hb5uDhSnmM/28GZ
	 1eV/aGehl11msBOCF4WVIk+zA+P5+AeqP/cCPymKKCA8m7Ho5dZGUj93JPWUeaq11jEGS
	 ZVlpu2foq65UVVKak2b2H97dvXdMhriSiw96DliTRTbYPHVe2xXm2RkP1XApRUY27qQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NDaV/dQx";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B835606A331
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 09:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B835606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NDaV/dQx
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91eed03da8bso42905346d6.2
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 01:20:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794648056; cv=none;
        d=google.com; s=arc-20260327;
        b=TpCyaRiK2gro28bAV+AkvPi2YLvu6FHLIhX6WLkmY/OjFTxhEroqHIqdazYB1dTUmk
         sBunZ2niFiYtA/L1O4M5DjY43X2hhoEujFteOkU2p+ZColx/jGHpw6c0SpjjacmZhDpO
         2gIUMyoSaW90/S6hlCo/BU0xwAdwvMPc9MpUqhnE3ovvi7b6eW+hGYVR1je+gPSHpaD4
         S5djL4yrAcrU3NJGN4WUt/hshgb5ERhBGYAakTE3WKv4Vw8vMbVP1hTXK9J/v3exu9en
         BOirPnrdxDpGTKf1PNKrdi4pk3f+LrbpKoa6XxIrC5SsRXqA9u7AjE/1Su2ga10UKAsz
         zK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Pwft8v+MK/PzpOQGnfEgS9STpXK24BW5ijOMaGrFS84=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=nto5a60Nf4mPbQiubE3NCCUP6FybnFOyNF6gHiEBN4Tpoy0zJcTt9vsAP9BZ+AIPfm
         +yYJGlDVsO7pK5UzJyiSh47Imbv309rnkqHgP1zdiTcYFFnvjw07loJ2ZXOanhECeLs9
         dd8rsNEN1aB5trrGthqOYmE3iqz7m/3kkvG9AAaIXUDJMjGpp5F6C2Dze+oNCVHQZpo/
         j3YFK8A/SYe1fmQjr/05ceeDBzBEjKEknJipizO7AMWMbn9QRoS+2uUVgc8e+j6KUhwz
         vRZjYs0V5jpCyFxUt7af2/IRfc/kRjFp8XIbvdJX+WJmn4ZRnVDNR3eIlXeTGpXsfy/P
         I0iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794648056; x=1795252856; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Pwft8v+MK/PzpOQGnfEgS9STpXK24BW5ijOMaGrFS84=;
        b=NDaV/dQxXh9KBm4vwiyEDGf9qX7pSxc8rXgROvUc8B3NBb7NcmTeVZbFrUa9XoHFbg
         6Fm3S3lFm9V16EZD/+55P0SAmUisAeZVDJy9Gc5at0Rxij2FhKFJ9BL10DCM2ZKN4heV
         raXTTztIV/qimQIsgjFDiH43kj9nRvYMY8AYgQj592TcFb+1wAWc/7Ar2asaXOOz3bvb
         KTROPREkk/d35yJbcEAG6KjBy9CvxRLvAg1XeWfbNM4DJLv8mMwkugD4KGFXEcrNNS2u
         RqeK8uzkkXSlIGn00ECoCsYV4fl+sdhKIplZ/0OMEggm91fDn6kmyE1lqa6R9Mi0H6/s
         V5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794648056; x=1795252856;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pwft8v+MK/PzpOQGnfEgS9STpXK24BW5ijOMaGrFS84=;
        b=XeQkllduTlQqDD0sACc5crmj4EfWvuUC7E7MpgdjC9yn+mvnaPvEjbteOEKu8uuhqm
         lRrSOXVKtZ/UadfP6hW6jsNw9x7rRuZ4/W3xsTHWhZ1cDLsFPxA4hHoVyb9U8N/MqkAo
         qyQPNPQXQjqcFs/uve6Homqgcg65li/QOMuHIDXYRh4UGrFGxxOyNnf8B9Txe4EvmGpu
         KPH8oQd6HkbQkkfeNRU5xu76VXPk2UxY4qmRgA1Sw2wtH89hE1Sx3OYmtsD1QdFW6pOu
         HnvCaOIFZl+7k+xCRGcsbvOLZ5sK3CbOFaVxNnG3pzSTxvogKtRx+nHhhmNBdwM5zsna
         YZZA==
X-Gm-Message-State: APuU4Z/qp+dzUfcsMoDCLcWHtsyHWw52rwm3JNA0SsvlLRlu7mgHWVRl
	VOzSH2B4CF0MinTD+NTC2Qevcitzn0eg2jxEriC/SEkHKka3LRI5YI9PHfRo0JsgEkXVuA2XbcA
	++xrvBj5/lmyWnKukPfyj3e6+mKir/cErxYs8
X-Gm-Gg: AYBFou0v+Kkv/vO8KQ76GEM12MI+wyW0uVnWHqvjqcLL9INJa3JOuCSezSPXUeGdIAu
	yUF6zy8TSUEqZok2FqbYxd+G1ZHFg055ayQ+mE+xipxMnsUJaJ+O0PFE3JN1JFWf8zEQJ7/Q6TZ
	TnOVOc0vFK23e/9hOdA6ZuuLTytIGW8RGrh0DlT5gUbvdAFnGeJdohUYOqfPa6Q5cbCQY4yWJx/
	CjKrQ6v6DWTiN9z6yAhhRimVdUPPGTvSecscEvaNqdxO0yhlhe1pi+SPKi+MnnM0VoaIps0JHej
	wsEnqxS9Kd2SHUthEmXhd2yyAihZd/pfEt07EXAq7p6MKEu2TdYf5uBRDgMt75JByNt/ukGQD0M
	sITRcJWPg6bKRcQK+FMNpN7xAvYxtY6x9bp+BxQ==
X-Received: by 2002:a05:6214:4197:b0:91f:2255:6b96 with SMTP id
 6a1803df08f44-91f242162a7mr73782866d6.26.1794648056141; Sat, 14 Nov 2026
 01:20:56 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Aleksandar Kazandzhiev <al.kazandzhiev@gmail.com>
Date: Sat, 14 Nov 2026 11:20:19 +0200
X-Gm-Features: AclHuK-RFDJBuMuWKBDrEs2Lk8jTGWqjS8L7z_CwIObEIXLGgsjD21bEyq6Ymro
Message-ID: <CAMRtMBcaVUFhxdO43dY8ZyT6m2+AFzNvKf+GNvb63vc-TzxhcA@mail.gmail.com>
Subject: A synaptics trackpad LEN2064 PNP0f13 failing to initialize with
 protocols other than PS/2
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

I am running Fedora 45 on a Lenovo ThinkPad T14 gen 1 AMD (it seems
this is a common issue). The trackpad has an issue with the 3-finger
gestures for GNOME overview. So what I've found is that it's falling
back to a PS/2 mode which supports slow polling rates and that seems
to make sense as the gesture seems to work if I move slowly, but
doesn't work if I move fast.

[    1.774847] psmouse serio1: synaptics: queried max coordinates: x
[..5678], y [..4694]
[    1.824080] psmouse serio1: synaptics: queried min coordinates: x
[1266..], y [1162..]
[    1.824101] psmouse serio1: synaptics: Your touchpad (PNP: LEN2064
PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi
are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to
linux-input@vger.kernel.org.
[    1.897748] psmouse serio1: synaptics: Touchpad model: 1, fw:
10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board
id: 3471, fw id: 2909640
[    1.897770] psmouse serio1: synaptics: serio: Synaptics
pass-through port at isa0060/serio1/input0
[    1.939963] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input6

But If I set the psmouse.synaptics_intertouch=1 parameter I get the
common error message for the fallback:
[    0.000000] Command line:
BOOT_IMAGE=(hd0,gpt2)/vmlinuz-7.3.3-300.fc45.x86_64
root=UUID=620ad754-8fe8-40f8-bda8-1c0f39c999ed ro
rootflags=subvol=root
rd.luks.uuid=luks-39c760d8-413d-44a7-afeb-527beb6dafd9 rhgb quiet
psmouse.synaptics_intertouch=1
[    0.034063] Kernel command line:
BOOT_IMAGE=(hd0,gpt2)/vmlinuz-7.3.3-300.fc45.x86_64
root=UUID=620ad754-8fe8-40f8-bda8-1c0f39c999ed ro
rootflags=subvol=root
rd.luks.uuid=luks-39c760d8-413d-44a7-afeb-527beb6dafd9 rhgb quiet
psmouse.synaptics_intertouch=1
[    1.778288] psmouse serio1: synaptics: queried max coordinates: x
[..5678], y [..4694]
[    1.822297] psmouse serio1: synaptics: queried min coordinates: x
[1266..], y [1162..]
[    1.822307] psmouse serio1: synaptics: Trying to set up SMBus access
[    1.825385] psmouse serio1: synaptics: SMbus companion is not ready yet
[    1.907207] psmouse serio1: synaptics: Touchpad model: 1, fw:
10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board
id: 3471, fw id: 2909640
[    1.907239] psmouse serio1: synaptics: serio: Synaptics
pass-through port at isa0060/serio1/input0
[    1.954347] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input6

I could provide additional information if needed.

Best regards,
Aleksandar
