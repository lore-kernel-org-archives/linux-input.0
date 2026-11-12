Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794447052;
	b=gSWThaYcmQhmsSpF1ZoiR4jRwW2syNjKKKnqCwXDWoEGDAGuUtNDMuqMKinzLerRusJT
	 vNRMJNt69V2Bw0TtkdG0FBPbwLPrT7+hP9X3NvabKAcE5us2SWPzUBITV4vM9F3dP8A+Z
	 Q0hnkNLWiiO6jNQkjSziv7lMl/xP2d7Dzu5KNTYuLYJpQVazjxP9bRume7J0HYPA4P70Q
	 /LPUhEBl1sZmndpe5VFrbTi4X/HH37NpvX3aRg+ztRPwY1VDjdJPmPhVW3YhezLp/RlEk
	 jjRdkNlnr7PEfgi4NYTXtHiWVnVcdZdwHsdkCbhnGJiKAbxh6H62BvRV2ZlzWQ3w9Ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447052;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HqBe/NHPOfDuseWK4ioMq0nhIjGOS1NmAr1BxJILYZo=;
	b=Mc0x7T8NQzPvIr2FTcbBwxFNQMx0H1rwcyP0RcwUrAyKgyoYjyK0IQ6eiX6e1JLlXoQR
	 XNAWloNlfbU2Dy8FykOK1Gm6aQzui5vHSQAu6SzvnkFI91PLqDRDj587AqTSEDJESVazH
	 WON3VQAyc3NxcSiNvJyEcZRXbDWz+wTmbQu04Ej3K19u9GHaQ/HUrc0KTpj5zBP4Bh/Bm
	 19W3/ygm4+G3EsVMPrq0EHlJY8hTn+nmppPZjjYaZKgIEsOBJMLw3vTm21tSC1hkhkhW+
	 6aEBeBjrVNOoLyUQVzXD9f7nnVlXa8snV603eT+2tZK95NMfcK3+gg4oyFFn3x6DJnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="y/lJbvwI";
	arc=fail smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0444606A334
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 01:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0444606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y/lJbvwI
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67c02c106e6so4133682d50.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 17:30:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794447050; cv=none;
        d=google.com; s=arc-20260327;
        b=maqvPomxEsQwjxbAh6zcTK9Xm0+2MzBtoBwLnnxIZp64T12ygX7qzRe8smo60sJEJr
         IWmS7CouVf2RDbROb+pgc/a+/y0rJpoLmZ3ybo5ku2nEbNduWLslYy6JpL89hw1N5PmT
         MHO0qxhJ19fdx3uhAONAEa3GCtgp3eUSENkOcprfuVraOYIRbzf++7mByTDSx9s7NFoL
         6ZLQmAOXlHrG8O7bfIkiCNcRCQMju873Ons6KAbDLZwedZZ6PXrC49sCz/D7VerpDQNh
         ivjd3OdYnprxOwcR36QqwS6oU+I+g2Lzbu2ObhBovQ42/OWIc1YTGLvFjutMzqIKaJHh
         bfIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HqBe/NHPOfDuseWK4ioMq0nhIjGOS1NmAr1BxJILYZo=;
        fh=cznpY83yUKfQrIpLyXV1Q5KDHqXdrmLl26F6vJEbfws=;
        b=UazHC5rsMEI2rYpDlDlzdMJROnn8rHzSNFX7o16JAviwXVPZkdlkUlfX0EVV394Tg9
         F1F6k+zfwRb8r+Vi/knql+UNq+9NNrmrP79LNuzi1yxXM3pTWAgB1JyohxTtgF1+8fnd
         s6m1+bNfWtfikPSiF+2PWnyuGMpnu7kydm2fnrXoX4QspeoCVRbUfuvaKkIKWcjpOlLT
         vUCj409fN7cFIrktLwmwiWxaH2GdWvY9G4zE0m3JHhJFHNQcgeVaZaY+zAkig8/sV7DS
         aXz41J0xvbp2ZXjuY7Wx5abVX/2sJIwWy8ducriAU7XMgf9HIoefroALqwcOknfeEWCM
         IEvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794447050; x=1795051850; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqBe/NHPOfDuseWK4ioMq0nhIjGOS1NmAr1BxJILYZo=;
        b=y/lJbvwIyJUNJf+iEwafVeL35qIQWE8o/yeXSsqV0WGo+yOTlDXC2TfsnDpKk4r4fW
         HCoxpn5CZBPzHnJ7/IA6clIhxD1oYcHmpWIyu6zFOgCWPNBrrzqm79d1oz8lUsqSUKfd
         VCaJc/Ol5yOHkrrJ1OEH19HZiQxszCOV2SSXU2M81MZZGOT8hXTPoE73rKWjqEeDsDkz
         FaxJJuPUzndKoNpp1G683K9uSe2twR4KP1v2/Mk7WLf9BdBWGBMLVT8DrIzRHjeuVeSV
         nJ2pNVVnLDZUa+sG/jwBRjAiuLT/+iKjLaH5xtDs/mVr08+C9jbn7LMlymxZVfcxwWuO
         sQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794447050; x=1795051850;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HqBe/NHPOfDuseWK4ioMq0nhIjGOS1NmAr1BxJILYZo=;
        b=HIAgq4D9h5DOT4O7fHLTM88HJ1Hb10By4dQX7WQSmV7af5JHwd2RSGy0vxEoz1NMYz
         j03JYBo26INAVfA9Ew0suFhZyeYXOkstcGIx3naomZORALRKbcUH3tn9fr8BOkS627Vd
         fOqCb5PK9bAHibDmzJp5oq1+siBAnNV5hHZvpaOogi+4eB69w5uaLmkHE4zpzt+yRLK3
         HybxmezgoSj8PGRItcdjHlaGe+2AYlJhu2czr3q2vIKMsf3R/I/VRYmH+h4KOQvMld0y
         BnyDMp1Z+2aEM5uU1NPQpRyNw0tBUSGluMwj+qEWDmE+h4NoViKin8/AUGH8ulWaWFhk
         BbTg==
X-Forwarded-Encrypted: i=1; AL+hErGWUAuav2FVuIPGwzOUjFwHZ2aVa+3hwv9Pdb+ARC8Lgkrvsm0cu2jcC8N/rLKvOL3oIrius4HribgB6g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/lNmWnwQRcmrKAZp+yx3cyM+y9YfVNW5nirh8eSLRA7KA8BnZl
	pZzsaZhAPYW1iCctUSpphT5hxJf4GzRWR4RS/FDnw4r2syQIy2cMRSJZmabhrxnk9JxqoGNttgt
	ZKOc+Cq8PFT9x8auCycmBFiNQpQTFYgU=
X-Gm-Gg: AYBFou35sijZXB4dRY4wiQAf7QV3yfjVagybI3h29Ljt3v0wgNG4A2ct1J00lfEOiDQ
	xMUEhk0+nvmTOdhy/iw2FY/FBQL6MvznxxofcglTDVIQ6KaA92Tc0nuFIaC6vpuv4iDlvprlvt6
	qnkHXgIaGVMrh3mGLOBstKdu0/VONyrIaYIGfdX0iah5G31gHDAmWF3LvsW1vejSRBe8yqTmEkH
	KLPa0q3JfzxAt/zG55JsgmEKG27V5/gkVWj3IX4X16DBrVtEJvUZjZwsvevMlhtWYkOb+qhqJoT
	WfXL57LIw3Iu+kM3aGuQJpKAayxqdkxVFSpDrxfy+QDEyfmFBLRcbMVGEL6OkZmM/qZJHrzale6
	w4VTfQxo6ESwDBMjEDeRO191cfLbLW9LbGHhRGYLqalj71pI7GVB+5JF4ny9BLnI2/YgpXNimZS
	rbEMKOgDFOuXjwx2g=
X-Received: by 2002:a05:690e:1445:b0:67c:257a:cba8 with SMTP id
 956f58d0204a3-67c67ee4afemr3040960d50.15.1794447050552; Wed, 11 Nov 2026
 17:30:50 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
From: Gideon Heinz <gideonheinz02@gmail.com>
Date: Thu, 12 Nov 2026 02:30:39 +0100
X-Gm-Features: AclHuK93X2NS4OkDx9i0xCDJ4Jv5CPtODKBLv44HwCgLoH-cBZXhsL3lMnkWxMQ
Message-ID: <CAPb1+K2BxnfQ7VUQ15td5f9pVhn-ARSM9EjfOU8WuW72o+cvPg@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	=?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, Edwin Velds <e.velds@gmail.com>, 
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

I tested v2 of the series on my G920 (046d:c262). Everything on my
list works except one scenario that takes the whole machine down, with
and without your series (last item).

Setup: Linux 7.3.1-1-cachyos (clang build). The pre-image of patch 1
(blob 60fc6b86a085) is identical to v7.4-rc2's hid-logitech-hidpp.c, so
I applied all 33 patches to that file (every step matched the blob hash
recorded in the patch) and built it as an out-of-tree module against
the 7.3.1 headers, loaded with insmod. The only local change is a
3-line fallback for devm_kzalloc_obj(), which the 7.3.1 headers lack.
No full kernel build.

Results:

 - Initialization: "Force feedback support loaded (firmware release 4)"
   on every plug-in (8 in total), no -110.

 - fftest: all effect types are listed and the effects play and
   produce force. After exiting with -1 the log stays clean for 2+
   minutes.

 - Input: wheel rotation, buttons and the hat all register in evtest.
   I use other pedals, so the G920 pedals are untested.

 - range sysfs: with nothing holding the device open, writes take
   ~67 ms and read back correctly (540, then 900). On v1 my
   closed-device writes each ended in a "Failed to send command to
   device!" about 15 s later. With evtest open it behaves the same.
   100 reads back as 180 and 2000 as 900.

 - Replug x4: FF loads cleanly each time.

 - Unplug with evtest open: evtest exits with "No such device",
   "Unloading HID++ force feedback" and nothing else in dmesg.

 - Unplug with fftest open (6 effects loaded): 6 "Failed to send
   command to device!" lines within 1.7 ms of each other (v1 gave 12),
   then "Unloading HID++ force feedback" 19 ms after the last. No
   warnings, oops or hangs.

 - rmmod with fftest holding the device open: rmmod returned after
   2.99 s with "Unloading HID++ force feedback" and nothing else in
   dmesg. When I then exited fftest (entering -1), the machine went
   down: the first time with a garbled panic screen that I couldn't
   read, and on later attempts as a total hang with no output. The
   same sequence on stock Arch 7.2.11-arch1-1 with the unpatched
   driver also hangs the whole system, so this predates the series.

   To reproduce: with the module loaded and the G920 plugged in, start
   fftest on its event node and leave it at the effect prompt, run
   "rmmod hid_logitech_hidpp" from another terminal, then enter -1 in
   fftest.

   I could not recover a trace yet and will send one if I manage to.

   My guess, from reading the code and not verified by a trace:
   hidpp_ff_create() stores hidpp_ff_destroy() and the other FF
   callbacks in the ff_device as pointers into the module. With fftest
   holding the evdev open, the input_dev outlives the driver, so when
   fftest closes, the final input_dev release calls ff->destroy in
   module code that rmmod has already freed.

Not tested: the battery patches (10-14, a wired G920 can't exercise
them), in-game FFB, and sysfs driver unbind.

Happy to test patches or send the full logs.

Gideon
