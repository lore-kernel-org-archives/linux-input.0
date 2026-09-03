Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD13EC82A
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428117; cv=none; b=jTn1IerW+noBqwhRNAbBefcH5/XEHBOIqoTMUf8YBFnLmdniuY6yS4qzEmfVXg+xDPYYWMKq+OZd6ULHsfgldRuH4D5t0k+ZdfdkhKPSskloHFJYu2Gl50dJOBi5jp7bhHqq+vA5fLYLoyKruQ8jiWoTzE5mn8UkGWgnvJ9R1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428117; c=relaxed/simple;
	bh=46vmUXIfr2J4vG0e5AgFJtlrw04dR4wOeEk9bShmc6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaVoZt+YpfLJAeVxgu3bSTLG1ujwDM092vIKe/uHphsOMatrlAsqs/I/rpc3EZkuhaccf4dYmVZ462w1RHM/PBkrx8Ok0wXf8xjwRjJCsnHa3pjvXiSbp8vEcSrqgJ6lcz7liXRyLlwFEtFXkVd8mMyuEOELoFVwcGmgR1HC/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYsWTxkP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYsWTxkP"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso335451266b.1
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788428113; x=1789032913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yb3Fl+FXq1X4MVWyRoUDWcF4HOxGx9QuUFQqbrfiyAI=;
        b=LYsWTxkPaOBAWAl8ieqxfG2fNPjhs7Z+kXEsCtJRLBME2BA5xEXwrm1DATVcCfzBYU
         6VeEyKil9wB3ix6Hk2NPZJApPRp7VQ8vX2r397PATmjh2ZsMrn0sKioOrzhQiX0rNbhY
         W9sfK1WGRmM39bVPCbRYX62WkD/UAe12N7NOqs0TGb+JBviZvdp4SMEY+CuuQ8CYe00e
         0n+qrKnU9+jBfzlC4vRYqx4aUqN/guKO1eKXIFWCvoLgCNsnzavaJu7RApaklNb+F/rD
         zNHvxsDV+mbIiMAQdrbhmiKkHAIN01C0TOKjrk+PZuFFuMXb+3PEWesSbgs5Bw6hIZhJ
         D1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788428113; x=1789032913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yb3Fl+FXq1X4MVWyRoUDWcF4HOxGx9QuUFQqbrfiyAI=;
        b=f0DbXbOH9CgJs0hMracseosrVG2U2TfGZQumLWD7xwTILudMNRN0opwvNUHs83/BMN
         LLhrqodUr+GFFBiTblerMJMeGc2p3xJ3hSpCfITf3FRoUEjTn+RhwIfObEJVaPSYf8bC
         m7+PiZtRBsjlUA+ocDDAOdfBryfMrFawNb5rz8tdRLknk1gOaNC8m+pSIEpfUnaFeFFS
         XDLm9P1Bg2vN/DFOG5kfAxniENyu7hR41/FiNt09b7A++0z2cprlHJxrG2dZujBuCrJ1
         sIp3FHcIaRu9vMQn5uQaCFa7RtNsHna4Qx5Ahh1UUUORTNbbmrrWUI8VeGbFL3FJs9Tx
         97Aw==
X-Forwarded-Encrypted: i=1; AKwUvBwQpcbylDUmVxWQfO5fCQPnNdIWyLLPU75GfWHBGU7FUREy3cryryUIcXfspI0ykA8fLiKwL3IfjuTE3g==@vger.kernel.org
X-Gm-Message-State: AFuF++kgtIyXS8Fhzbl9SB6KQyEpsWbdlsQHSo7kowePofIScC4NXtYG
	X7S2u72USGYBodRuH+ICSlAK3ZTOtEHSDWhYaNsRGOuPxFjd91rZbm1l
X-Gm-Gg: AYBFou0FSViCQGuZXVy2dZVNgK8nrA05Ucq69qYaG9+E0jzgeshJnCE48GKcIX1xs4J
	1usHKyRgGP30iRSyfMABQ2YKLEMw4drcbUTvw4FKZKdfit/06p24wvZhy3Zifr7XXucSqxQ1eWl
	QBjQ8i49d731EpJVQva+hLWGT5P60Ib+Ls0nMs2WZzGh9xn92iRhXpMvwXxRj6rAKStMRexHt4E
	du1TNKLmipKovq7PeRWaBC34eqj6kfp+A5I2gD2MUi5rIYoSmJdaX4JU35mpbobvuDSQCCE2TVk
	POKNpyXaABzCrmSmX5AL+r0ik3VaiQMScihgbORyBQv1/P6VBgSX3CjHr4zEatAzB3iltmF2HmS
	qy4YArMqh3vNF2yWHGGMNM0Q7wA022ybpSCtlpX/tapd+lxGvWQuLT9xpOsediL+wj+36uZuihp
	SdO3CYBWefnmLo5n2cTX2TypCFddew33Q0F2zrZZwMI6MIdoUtrX0R2C86WaK48DjovhSDU0y7b
	ydsu80ECQXvsQLu9orXoe3SaxARzr1lQSIumaJFjCXR+LgNDvx/U7oSQlJcHqAxZZ27aXY=
X-Received: by 2002:a17:907:7206:b0:c25:2ec9:db91 with SMTP id a640c23a62f3a-c25d54754b6mr696617566b.14.1788428113134;
        Thu, 03 Sep 2026 02:35:13 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f41e1bbcsm72357366b.41.2026.09.03.02.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:35:12 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.de
Cc: tiwai@suse.com,
	perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] ALSA: usb-audio: the Topping M62's vendor controls
Date: Thu,  3 Sep 2026 14:35:10 +0500
Message-ID: <20260903093510.23387-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87se3q91oq.wl-tiwai@suse.de>
References: <87se3q91oq.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 03 Sep 2026 10:30:45 +0200, Takashi Iwai wrote:
>
> Thinking more on this, I see another possibility.  Namely, create an
> individual HID driver like your previous plan 2, but instead of
> creating an own snd_card object, use the component framework
> (include/linux/component.h) for binding between the audio and the HID
> drivers.

Thank you -- and this answers more than the mail it replies to.  The v2
cover letter asked whether snd-usb-audio registering the hid_driver
itself would be a better shape than either road posted, and the question
has been repeated in every letter since.  It is answered now, and the
answer is neither of the two roads I had drawn.

I will rebuild the series in this shape.  What follows is the plan and
the three things I could not settle by reading, so that they are asked
before the code is written rather than after.

What the shape becomes.  A new drivers/hid/hid-topping-m62.c owns the
vendor interface the ordinary way and speaks the protocol; it registers
a component in probe.  sound/usb/mixer_topping.c keeps only
snd_topping_init(), which allocates a small context in devres on the
audio control interface, adds one match and registers the master.  The
master's bind calls component_bind_all() with the snd_card; the HID
side creates the kcontrols there and drops them in unbind.  I took
sound/hda/core/component.c as the model, including devres_find() keyed
on the release function to recover the master's context, since drvdata
on a usb_interface is snd-usb-audio's own.

What that deletes.  snd_usb_claim_iface() and snd_usb_release_iface()
in card.c go, and with them the only change this series made outside
its own files; usb_driver_claim_interface(), the interface reference,
the "claimed" bookkeeping and the search for the HID interface by class
go with them; and the hid_ignore_list entry goes, because the device
now has a driver of its own.  The defect I wrote to you about two weeks
ago goes too: with no claim there is no interface marked
USB_AUDIO_IFACE_UNUSED, so none of the three shapes I offered is needed
and card.c is not touched at all.

Now the three questions.

1. The match.

Neither helper fits.  component_compare_dev() compares device pointers
and the audio side has no pointer to the HID device; component_compare_
dev_name() would need "0003:152A:875C.000X", whose instance counter is
not predictable.  is_usb_interface() would have made a tidy predicate
but it lives in drivers/usb/core/usb.h, which is private to usbcore.

What I plan instead is a test of descent alone.  The HID device sits
two levels below the USB device -- hid_device, usb_interface,
usb_device -- so the master passes &chip->dev->dev as compare_data and
the compare function is

	return dev->parent && dev->parent->parent == data;

Which interface it is stays the HID driver's business: it returns
-ENODEV for anything but the vendor interface, so it registers a
component for that one and no other.  That keeps sound/usb free of both
HID symbols and any opinion about this card's interface numbering, and
the function is only ever called against devices that registered with
component_add(), so it does not have to defend itself against the wider
device tree.

Is that acceptable, or would you rather the audio side knew which
interface it was looking for?

2. When the controls appear.

try_to_bring_up_aggregate_device() reports an incomplete set as "not
ready" and returns 0, not -EPROBE_DEFER, so a card whose HID module is
absent comes up with no vendor controls and nothing said about it.  And
mixer quirks run inside snd_usb_create_mixer(), before
snd_card_register(), so even when both halves are present the controls
are added to a card that is already registered, arriving as add events
some time after the card itself.

Neither is wrong, but both are visible from userspace: a restore can
race the controls into existence, and a missing module looks like a
card that simply has no gains.  Would you want a MODULE_SOFTDEP on the
audio side, or is late arrival the expected behaviour for this pattern?

3. Remote wakeup, which is the one I have no good answer to.

usbhid arms every device it opens: usbhid_open() sets
intf->needs_remote_wakeup = 1, and so does usbhid_start() on the
HID_QUIRK_ALWAYS_POLL path, so there is no way to receive input reports
from usbhid without asking for it.  This card does not offer it --
bmAttributes is 0xc0, and there is no power/wakeup under its sysfs
node, so device_can_wakeup() is false -- and usb_suspend_both() then
refuses autosuspend for the whole device:

	if (w && !device_can_wakeup(&udev->dev))
		return -EOPNOTSUPP;

That would take back what v7 fixed.  It is worth saying that the
driver's own two-second keepalive already keeps the card awake at the
default autosuspend delay, so the loss is structural rather than
observable today -- but structural is worse.

This driver genuinely does not need remote wakeup, and its own resume
path is the proof: it subscribes again and asks the card for its whole
state, so a knob turned while the host slept is picked up on the way
back.  So the smallest thing that works is to clear the flag after
opening, with a comment saying why.  The field is not private --
cdc-acm and usbnet both set it directly -- but clearing it from outside
usbhid is unusual enough that I would rather ask than post it.

It also decides a question I was going to raise separately.  I had
meant to keep HID_CONNECT_HIDRAW, because a hidraw node is how the
protocol was read in the first place and how the parts this driver does
not expose stay reachable.  But a hidraw open calls hid_hw_open() again
and sets the flag back, so clearing it only holds under
HID_CONNECT_DRIVER.  If you prefer the flag left alone, hidraw can
stay; if you prefer runtime suspend kept, it cannot.

Would you rather see this as a driver-local clear, as
HID_CONNECT_DRIVER plus the clear, or as something usbhid ought to
offer to drivers that resynchronise on resume?

Whatever you decide on these, the next posting will be the new shape
rather than a v9 of this one, and it will cross into drivers/hid, so I
will send it to both lists.  I will mark v8 superseded in patchwork
once it goes out.

-- 
Mikhail
