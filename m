Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497A472522
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767581; cv=none; b=F+0uGVk7UWpOltTpP1Cc7wDkJT5r8pbnSolIv4H6Bzfrl6GUdKgziU72AARmMIxzSIYb1mD2+uxig3CGGtDyzkgQmN6PTWdOYA2ZMJgCqsqSjnpJzCcayk5ShGZuF1X4NN8KMYCt5eg4XbfP7Riq/e6tZtK07hT2r5VEH80y6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767581; c=relaxed/simple;
	bh=LeEJFYRJyjBD+VOdgRYdyzn/yNEdxpehfMwq5EPBXQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEaIlQR54DhEyqqkxRINMOehGg0AFgN27R/HEJpMpLJB4JpXk7YBiMMH8RCJVttQqukJ83E6V+WmmbasrK7KfOtABzTUNHeRRtaBMbRUOiVEX4r40yxmc1p/iWJqjhtj/ZjXaFo7iw6ogqOsvUSTSBRD1WmXrpPBEbn2z/5Y59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxgKhO1U; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxgKhO1U"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1670dad7a8so213156666b.3
        for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787767570; x=1788372370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cm/MI2m9y8Iv9NfgYHEezzJ1W5y+yuhXpteKHeoWjTU=;
        b=WxgKhO1URr+YV1uT59apW+giKeGAcbwNSToIBOv/2bHpXgfeUflPVZyHi4J1NUamG+
         yGH1fudawP3OdHFK/4CpiWlVvqgcOKOEtjRBvMa7u+pIlEun9gg8h37ycMMpVVuX41Vj
         O1FdOnOyCrGkwT5oH4ybPkg8cepI+RgmwUaNhv19HaNilKLBPy2EobbBShawrxMsLtI3
         MF6+cXvlhzMVpDr7TVEkZE1Q0n8/KMioRvLbhAHINydaII3A/nZ/XjfS7CLh1p+BYimy
         Qyb2RDraRr7jhBtoIDgInqM9IBXrwn9nZxKd6LUY4Qi5f+OHKMQfDPYnhcLtZYrqp7Uk
         VEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787767570; x=1788372370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cm/MI2m9y8Iv9NfgYHEezzJ1W5y+yuhXpteKHeoWjTU=;
        b=mGok4fmUgES69YPKTOm5b8fcLoYLy5ZBbyKms/lNQoXrJAatJK7N7awDrFGGIkBTxI
         f0RmEM94VK+y4BHqEpJldkVappdGE1M0w9bMX5umz4OPFcyfuOHqP+uZH9fMUmQzaDnx
         1WTOR+uiqq9+uKazNBd3I6QJGgs5Ff9wOoVl5aGBsKI5fAZN+hV7hb66xA2qZk+paNBG
         fdFWfij0zKcPaoxyecjk0iaxxn4664vBHMvMEVdxcVBjbFzOYWXPOznNi07j1Ww23uXy
         T4H59kcjt8KdO0ZoBfRuc9Nbex8sT7blzbGzUlcpmLHTuPAKIkOMxD1xmhzebSyRgrNG
         ONJQ==
X-Forwarded-Encrypted: i=1; AHgh+RopsXFB5yPxoiqBO2wjC+YDSIhKA92T35vdsMRKoOmqRmGJnTQrjn5HQVU1Kk8hrPQyzpN8qfvT+VBDiw==@vger.kernel.org
X-Gm-Message-State: AFuF++mr7/K5vEcPqdrnxOjzPXJ9qL0Z0V3OHBQts9dzawXCXrwynwG+
	JNSx5uIJ0+Ldpvkh9EoGg/Nk2Uy2yRdrWnZHdHL2Z/6OC9jX7XB0j2mN
X-Gm-Gg: AR+sD13HaM4dEomveS1LPQMOZO0ioCEmPErmss+QICRQbMpgRvQ9WFymafvLVEUAa3y
	LLhCBsVfsNzY0mjxvGY8w2KaS4b9J6EbH216SJDR8AD+HppvFXt7CjpkUeCMudk1rE41xcCbSWO
	uv5iCcxIGzhX7DU1Vuil5xL8unF0iPOTYLObHDGIIYJmeaVD4HDi20dowf5h6Gd7oCvxRtkbxUj
	NKRhIp83HH4HyYl5KDSyKPURRkaYtVb2jZvVgwNb39veG8gx8RnSKGiM2xg1OMGHjrFsVu2l5fL
	4uNDh/orQfEJSMxyn96uvndQVmX3dyM+Ri+rcaoH/f+FvfaMTFci5IjTS1VFsi2Cunn8nxuT3wb
	1YNWwKe98D84HFjWgtqgmvj04T2+1N1+CLwTyjIwOEGoZx/B2BbGTmg2Aq5nG5a/Ew/AybJLslX
	xWVHJGxtOagqCc/cL7CerWHE23cdFojcCerIaMPHNor4Cofeh45OY/f0UVVp7F9Y1eJixW/eqcj
	TqqrAAEP5zHl+owB79Q47Vb7CtPetY8FxiAg52RpIEvJrgYktvLOKlq4vbf
X-Received: by 2002:a17:907:b041:10b0:c25:2de6:f063 with SMTP id a640c23a62f3a-c252de6fd5dmr477114266b.5.1787767569865;
        Wed, 26 Aug 2026 11:06:09 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b106dsm700097766b.43.2026.08.26.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 11:06:09 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] ALSA: usb-audio: the Topping M62's vendor controls
Date: Wed, 26 Aug 2026 23:06:07 +0500
Message-ID: <20260826180607.324604-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825111239.24834-1-mikhail.v.gavrilov@gmail.com>
References: <20260825111239.24834-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found on my own bench while chasing something else, and I would rather
bring it than have it found for me.

The problem, as a user could see it: after unbinding the vendor
interface by hand, the driver keeps writing to the card. Reads stop --
the control freezes on its last announced value -- while writes go on
reaching the hardware, and the two-second keepalive presumably goes on
with them, into an interface the driver no longer owns.

  # echo 3-1.3:1.4 > /sys/bus/usb/drivers/snd-usb-audio/unbind
  # amixer -c M62 cget name='Mic-1 Analog Capture Volume'   # frozen
  # amixer -c M62 cset name='Mic-1 Analog Capture Volume' 50
  ... and the gain really moves on the card.

The sound card itself survives the unbind untouched, which is right and
is the good half of the result.

My reading of why, and I would be glad to be corrected on it. The quirk
claims that interface with usb_driver_claim_interface() and marks it
USB_AUDIO_IFACE_UNUSED, so usb_audio_disconnect() returns at its first
line and nothing ever tells the quirk to wind down. Meanwhile
usb_interrupt_msg() takes a struct usb_device and an endpoint address,
not an interface, so losing the claim costs the driver nothing on the
write path; the read path dies only because usbcore kills the URBs on
the interface being unbound.

So the claim is what keeps usbhid away, not what grants the right to
write, and the two are easy to conflate -- I had conflated them.

How reachable this is: only by hand from sysfs. A plain unplug takes
the whole device, and there disconnect runs on the audio interfaces and
the quirk is freed with the mixer. I have not found a path that reaches
it in ordinary use.

How I plan to solve it, and this is where I need your word, because the
change is in card.c rather than in my own file. An interface the quirk
claimed is marked exactly like one nobody wanted, and those two are
different things: the first has a driver behind it that should be told
when it goes away. The shapes I can see are

  (a) let the quirk register a small teardown callback at claim time
      and have usb_audio_disconnect() run it before the early return,

  (b) give the claimed-and-used case its own sentinel instead of
      USB_AUDIO_IFACE_UNUSED, so disconnect can tell them apart,

  (c) leave card.c alone and have the quirk take a usb_device
      reference plus its own notifier, which keeps the fix inside
      sound/usb/mixer_topping.c at the cost of a second path watching
      the same event.

I lean to (b) as the smallest honest change, but this is your file and
the sentinel is your convention.

Whichever you prefer, I would rather send it as a follow-up once the
current series lands than fold it into v9: it is a separate defect,
it touches a path shared by every quirk, and stirring it into a series
under review would make both harder to read.

Mikhail
