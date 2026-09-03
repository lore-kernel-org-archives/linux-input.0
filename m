Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8377648D89C
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430786; cv=none; b=kmUm7y4U9QaljK2YIS0gSer5x14CouU2TgDNQSmKGC7lbm5cUOThCEZ9SVgSgrEf/L4JZ7K96bCGJhPHKHJg3Cpt24L4/uVrmevYdRC4w8D6YAPf27MPF4Izwi1voCwK+O9RkEeUhe0lKXDiOUkfAGgelA6HZyPLGowoqDSN3Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430786; c=relaxed/simple;
	bh=GxTeiwZN7CTGejE/bsamQnbdRvyaVhuispEpqp11CKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxI4AZYU86KT2p4BTmnh/UNfLrEwxPno4P07ZoQMbm4EAJNbpwFvd+APkiFAZly3AuOli7vo+42lC8oHqMyCOVCJWQ76RPOxx8sa1NxsWpQjUKbJXM42q34tcgiLASplhYKgHsMIqFa/dJ5Ul6dNQk9DkU9nlozE4aMWL0tHuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE/JOkRZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE/JOkRZ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a668cacdadso3292247a12.2
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788430773; x=1789035573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3+ctbJocyD7cPa19hLn883tfSf+5YYD4Wsi8oERH+o=;
        b=UE/JOkRZI2w6ytWUVrlZm+g+t433+A0q9lAive0un5EeYQlWmtwQ2vcXwZz2xoCXJo
         Dtz1uYrcqlaoF1LP5wrLb9aJHsSYi7GqQDc/VJy9Si0pVhhrsgnN58XWaJMEcyweV3jP
         OZe9R37JzQ7678h70k+oP0I0A1NY+9IQ0eNWgkPCM4TP/IHn3a6HLyHs2FApWCT+/a4E
         WvQVuFZxYazg/AhnOS/2PeXdWmJmFC+Upz9oPVpjcjtdKWhDDCBNd1nRrllpFuKqjY43
         xlXl228jlRwXF6Yz8sSFNA8b4Tb3hjOZbUWdtxadLQ9qxTVKIn2iJDQ0fWqtLJKHd+HY
         TFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788430773; x=1789035573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W3+ctbJocyD7cPa19hLn883tfSf+5YYD4Wsi8oERH+o=;
        b=RAMhs9+47QddxkSNAb+vuPEJPxiOn6MfW7GzbTgVtLaLN28OUeKfpdOVXlYVNNkZub
         EDh6Au1w8a3BqAKac4khpG+bkPTrScXQFD/pCvaF+8bWrUkinplTGTbXKCSXpjErRs8x
         V+q2ciOXBQyP8y3yFvdqKk0e8uaHvybxRKW1ZdxlQEehKVtPLaxknzmhe0co4mMJtti4
         Jjsj0yWO/tbO2gJWaDRPicohGFCPYFAgrDZnukvj8wBMknEE2a+4oKJeEVLvy0cWVTzP
         /t9x6Os7NCoODfBZKaJstNalAj8dS4AlVBNTPvP9l6m7lTzt3VQkM6xQqMy9vS6Zz/Mp
         nYRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWM43ufgjF0yHI/Vf4RqFwgZlE69f15qrAZdgLSvYceKJrAmKLGVeBNuqPru+JfdAdPthWkC2K1Veeiw==@vger.kernel.org
X-Gm-Message-State: AFuF++lB9GUJmnX4KSTxt59nDf/F1cSJSB2H1YxDZmJT0nSvLG8VQc2S
	/vJnwo5jLdxTpxvl9FMUaScRjX0KdMO2BMPD+zUbY16yKj3wutoejzI7
X-Gm-Gg: AYBFou2L7v1xoHwwLqf7ZN5p4FmklGM5/qybgbcgmKyteGHncDQvlVTpLyTNsoZfdGU
	It9qXqu2Kmt1lTLNees8NqQ8nzHa1GW4qzKkE8lsLTJCIoRQwxZ28rTphG1sZpXIbB54DSFSYwG
	1T1E22aqy0ILu+eRbeleksFbYlyYC9/EoXgN6jph+bfAob+vG9AYG7Rl/80/hsozD8AvzLI0sN9
	9tlm0OA/ngagZDQMfD9HDbYLrX8cAoDjDF0VWZZ6Xlza6PcJ/sZve+TqW/f7hS68jAYJyfsXOvO
	DYaxph/Ca3MKVqLAxELLi2ZY+PJKTiNCIKW138Lt5lsqHpTnzOcKMNnRpLBMsh0QCVDx2/TLN4a
	J4nbyDQ7plnE9kGXVw4OCwp1DMoyiO1C4wtK25E//WGoLIqc1QSKTpaOk3wha52peQcFqyeooWk
	gtf2LRTRYulEHSR8v4GM6UItVFlwypbA0PWa4CeQpL5bU1WijbytgzJ8q/7jYBPzOyiUE60TYmD
	AreVJvaO1qH05fn4vqwMr9OUV2OCSpZ608r5zse+ogbLmxdn8MbolUaW+K/
X-Received: by 2002:a17:907:da16:b0:c1f:29ce:76a1 with SMTP id a640c23a62f3a-c25d550e29emr666393066b.19.1788430772687;
        Thu, 03 Sep 2026 03:19:32 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f41a6019sm78190366b.33.2026.09.03.03.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:19:32 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: tiwai@suse.de,
	tiwai@suse.com,
	perex@perex.cz,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] ALSA: usb-audio: the Topping M62's vendor controls
Date: Thu,  3 Sep 2026 15:19:29 +0500
Message-ID: <20260903101929.34492-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87mrty8xf2.wl-tiwai@suse.de>
References: <87mrty8xf2.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 03 Sep 2026 12:02:57 +0200, Takashi Iwai wrote:
>
> > Would you rather see this as a driver-local clear, as
> > HID_CONNECT_DRIVER plus the clear, or as something usbhid ought to
> > offer to drivers that resynchronise on resume?
>
> I think it's rather a question to HID people...

Jiri, Benjamin -- putting it to you then, with enough context to answer
it without reading the rest of the thread.  The wider design question,
whether this belongs in a HID driver at all, is settled with Takashi
upstream in this thread; what follows is narrower than that.

The device is a Topping M62 USB audio interface, 152a:875c.  Its
analogue gains, output volumes and source selectors are not described
by the USB Audio Class; they are reached over a vendor protocol on a
HID-class interface whose report descriptor is a fig leaf -- a Generic
Desktop application collection, eight usages stretched over sixteen
unnamed bytes in and out, no report ID -- so hid-generic can only make
a nonexistent pointer of it.  The plan under discussion is a small HID
driver that speaks that protocol and hands the values to snd-usb-audio
as mixer controls.  It wants raw input reports and nothing else: no
input device, no hiddev.

The trouble is that asking usbhid for input reports arms the device for
remote wakeup, and there is no way to ask for one without the other.
usbhid_open() sets

	usbhid->intf->needs_remote_wakeup = 1;

and usbhid_start() sets the same on the HID_QUIRK_ALWAYS_POLL path, so
both roads to hid_start_in() go through it.

This card does not offer remote wakeup: bmAttributes is 0xc0, and
there is no power/wakeup attribute under its sysfs node, so
device_can_wakeup() is false.  usb_suspend_both() then refuses
autosuspend, and not merely for that interface:

	if (w && !device_can_wakeup(&udev->dev)) {
		dev_dbg(&udev->dev, "remote wakeup needed for autosuspend\n");
		return -EOPNOTSUPP;
	}

So binding this driver would forbid runtime suspend to the whole
device, including its audio interfaces.  An earlier revision of this
series had to fix runtime suspend once already, and I would rather not
hand it back.

What makes this feel like the wrong flag rather than an unlucky device
is that the driver does not depend on the device to wake anything.  The
card stops reporting to a host it has not heard from, so the driver's
resume path subscribes again and asks for the whole state; a knob
turned on the front panel while the host slept is picked up on the way
back, by asking, not by being told.  A device-initiated wakeup would be
of no use to it.

Three shapes, and I do not know which you would want:

  (a) the driver clears intf->needs_remote_wakeup after hid_hw_open(),
      with a comment saying why.  The field is not private -- cdc-acm
      and usbnet both set it directly -- but clearing it from outside
      usbhid is unusual enough that I did not want to just post it;

  (b) the same, plus HID_CONNECT_DRIVER instead of HID_CONNECT_HIDRAW.
      A hidraw open calls hid_hw_open() again and sets the flag back,
      so (a) only holds if userspace cannot open the device.  That is a
      real cost here: the hidraw node is how this protocol was read in
      the first place, and how the parts the driver does not expose --
      the mixer matrix, the mutes, the EQ -- stay reachable at all;

  (c) something in usbhid, so that a driver which resynchronises on
      resume can say so once and have both roads to hid_start_in()
      honour it.  That would cover any driver in this position rather
      than this one.

Or a fourth I have not seen: is there an existing way to take raw input
reports from usbhid without arming the device?

I lean to (c) as the honest fix and (a) as what I can post today, but
this is your subsystem and I would rather ask than guess.

-- 
Mikhail
