Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27CC46985F;
	Thu,  3 Sep 2026 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429795; cv=none; b=u0ctwo0zY6oebFNavQ9DBHLbeGhBCZJN7Kw54WDODexFCcvoY4OA3CoC38d3Wf4AbBk5SZ1+cBzSmD7AroTjFfL3P/0lx31r85ElMZcBPFRSDF1iD83W5BNvdIZDsnoNfyOCvVvi3czLnfPo+48mS508oowbWNXBH7Rzsa0+uuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429795; c=relaxed/simple;
	bh=4Y+xkOPvotxu8kSe8itzUqADLnJOuMR+mw1mvcLMfaw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXhFAoEPpeHT/IaHUCKdvzvsXtmoSQ+lbO6ewIAfwp+N8fYrTxSV0BjOQwjS0Refe6jcLmkbwR8DNreHS3wQhbysgq9dUZxkKbmGg630o5mhoRAyv7kplVSw3SWsCriCrp7A5mqaRBnZ9sJX3+a2nV29maz+nGHHMvNgOxWFdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G8CvtA9H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=peYfkNe0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T8mP7DjK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4qx7h88y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G8CvtA9H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="peYfkNe0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T8mP7DjK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4qx7h88y"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BCFE1FDF1;
	Thu,  3 Sep 2026 10:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788429782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfjX8OMdzOfmsSKRQLumUwNMDxPX52hDczOlJXnl7OE=;
	b=G8CvtA9H6xmCFK02GG9X/tWxMuqner3+2MEgoiSei1fCYYI8IsLqrPKDR8k3VbIf8rT38g
	U7D+/x0xJfJUesHRRhWkFNEeK5hWvziatOmf8AWHjYqgEbNV0vZc3RKxYM0F5mMgmSxQeL
	36WODGXxJMExnpWzaJ9C5JCfV3Sj5NA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788429782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfjX8OMdzOfmsSKRQLumUwNMDxPX52hDczOlJXnl7OE=;
	b=peYfkNe0RKGY9WY99GhPCrEI301XcOpfRzZloLtn/e8B8ymGzt9mO/grmZfGQQcYazWbxz
	r8NbHWb2TxCHxICA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788429778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfjX8OMdzOfmsSKRQLumUwNMDxPX52hDczOlJXnl7OE=;
	b=T8mP7DjKe5lj9xolx754Bl9eCMZXwbFLYRQ1TjfDFIdS5R8ZwzSgFrzVXRCndaR0Yk9DBT
	9+ehPCIvqe37oTALOlwgNfEwpLpVPmOKXOcxu42HX/D4lG6UnGOPp/mtkNr+sbJ1Jhe5xZ
	pKL5rkIjcChqd294eRI1ybQd1pPYKOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788429778;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JfjX8OMdzOfmsSKRQLumUwNMDxPX52hDczOlJXnl7OE=;
	b=4qx7h88ybarzAuYVLneNXmzyGHT74QCvWbppPj3zJyeFR78tStUbsxANELOT9VmM7W6dHu
	douwGDqkYYa/ZQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA4C813738;
	Thu,  3 Sep 2026 10:02:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a5+jM9FFmWrqBwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 03 Sep 2026 10:02:57 +0000
Date: Thu, 03 Sep 2026 12:02:57 +0200
Message-ID: <87mrty8xf2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: tiwai@suse.de,
	tiwai@suse.com,
	perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] ALSA: usb-audio: the Topping M62's vendor controls
In-Reply-To: <20260903093510.23387-1-mikhail.v.gavrilov@gmail.com>
References: <87se3q91oq.wl-tiwai@suse.de>
	<20260903093510.23387-1-mikhail.v.gavrilov@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]

On Thu, 03 Sep 2026 11:35:10 +0200,
Mikhail Gavrilov wrote:
> 
> On Thu, 03 Sep 2026 10:30:45 +0200, Takashi Iwai wrote:
> >
> > Thinking more on this, I see another possibility.  Namely, create an
> > individual HID driver like your previous plan 2, but instead of
> > creating an own snd_card object, use the component framework
> > (include/linux/component.h) for binding between the audio and the HID
> > drivers.
> 
> Thank you -- and this answers more than the mail it replies to.  The v2
> cover letter asked whether snd-usb-audio registering the hid_driver
> itself would be a better shape than either road posted, and the question
> has been repeated in every letter since.  It is answered now, and the
> answer is neither of the two roads I had drawn.
> 
> I will rebuild the series in this shape.  What follows is the plan and
> the three things I could not settle by reading, so that they are asked
> before the code is written rather than after.
> 
> What the shape becomes.  A new drivers/hid/hid-topping-m62.c owns the
> vendor interface the ordinary way and speaks the protocol; it registers
> a component in probe.  sound/usb/mixer_topping.c keeps only
> snd_topping_init(), which allocates a small context in devres on the
> audio control interface, adds one match and registers the master.  The
> master's bind calls component_bind_all() with the snd_card; the HID
> side creates the kcontrols there and drops them in unbind.  I took
> sound/hda/core/component.c as the model, including devres_find() keyed
> on the release function to recover the master's context, since drvdata
> on a usb_interface is snd-usb-audio's own.
> 
> What that deletes.  snd_usb_claim_iface() and snd_usb_release_iface()
> in card.c go, and with them the only change this series made outside
> its own files; usb_driver_claim_interface(), the interface reference,
> the "claimed" bookkeeping and the search for the HID interface by class
> go with them; and the hid_ignore_list entry goes, because the device
> now has a driver of its own.  The defect I wrote to you about two weeks
> ago goes too: with no claim there is no interface marked
> USB_AUDIO_IFACE_UNUSED, so none of the three shapes I offered is needed
> and card.c is not touched at all.
> 
> Now the three questions.
> 
> 1. The match.
> 
> Neither helper fits.  component_compare_dev() compares device pointers
> and the audio side has no pointer to the HID device; component_compare_
> dev_name() would need "0003:152A:875C.000X", whose instance counter is
> not predictable.  is_usb_interface() would have made a tidy predicate
> but it lives in drivers/usb/core/usb.h, which is private to usbcore.
> 
> What I plan instead is a test of descent alone.  The HID device sits
> two levels below the USB device -- hid_device, usb_interface,
> usb_device -- so the master passes &chip->dev->dev as compare_data and
> the compare function is
> 
> 	return dev->parent && dev->parent->parent == data;
> 
> Which interface it is stays the HID driver's business: it returns
> -ENODEV for anything but the vendor interface, so it registers a
> component for that one and no other.  That keeps sound/usb free of both
> HID symbols and any opinion about this card's interface numbering, and
> the function is only ever called against devices that registered with
> component_add(), so it does not have to defend itself against the wider
> device tree.
> 
> Is that acceptable, or would you rather the audio side knew which
> interface it was looking for?

It's along my rough idea, too.  We can simply compare the common
parent USB device in the match function.


> 2. When the controls appear.
> 
> try_to_bring_up_aggregate_device() reports an incomplete set as "not
> ready" and returns 0, not -EPROBE_DEFER, so a card whose HID module is
> absent comes up with no vendor controls and nothing said about it.  And
> mixer quirks run inside snd_usb_create_mixer(), before
> snd_card_register(), so even when both halves are present the controls
> are added to a card that is already registered, arriving as add events
> some time after the card itself.
> 
> Neither is wrong, but both are visible from userspace: a restore can
> race the controls into existence, and a missing module looks like a
> card that simply has no gains.  Would you want a MODULE_SOFTDEP on the
> audio side, or is late arrival the expected behaviour for this pattern?

I'm afraid that the softdep is problematic because it'd bring this
always no matter which device is used.  In the case of USB-audio, the
state restoration is always racy per design of multiple USB interfaces
(the probe happens multiple times and the instances are added at each
probe).


> 3. Remote wakeup, which is the one I have no good answer to.
> 
> usbhid arms every device it opens: usbhid_open() sets
> intf->needs_remote_wakeup = 1, and so does usbhid_start() on the
> HID_QUIRK_ALWAYS_POLL path, so there is no way to receive input reports
> from usbhid without asking for it.  This card does not offer it --
> bmAttributes is 0xc0, and there is no power/wakeup under its sysfs
> node, so device_can_wakeup() is false -- and usb_suspend_both() then
> refuses autosuspend for the whole device:
> 
> 	if (w && !device_can_wakeup(&udev->dev))
> 		return -EOPNOTSUPP;
> 
> That would take back what v7 fixed.  It is worth saying that the
> driver's own two-second keepalive already keeps the card awake at the
> default autosuspend delay, so the loss is structural rather than
> observable today -- but structural is worse.
> 
> This driver genuinely does not need remote wakeup, and its own resume
> path is the proof: it subscribes again and asks the card for its whole
> state, so a knob turned while the host slept is picked up on the way
> back.  So the smallest thing that works is to clear the flag after
> opening, with a comment saying why.  The field is not private --
> cdc-acm and usbnet both set it directly -- but clearing it from outside
> usbhid is unusual enough that I would rather ask than post it.
> 
> It also decides a question I was going to raise separately.  I had
> meant to keep HID_CONNECT_HIDRAW, because a hidraw node is how the
> protocol was read in the first place and how the parts this driver does
> not expose stay reachable.  But a hidraw open calls hid_hw_open() again
> and sets the flag back, so clearing it only holds under
> HID_CONNECT_DRIVER.  If you prefer the flag left alone, hidraw can
> stay; if you prefer runtime suspend kept, it cannot.
> 
> Would you rather see this as a driver-local clear, as
> HID_CONNECT_DRIVER plus the clear, or as something usbhid ought to
> offer to drivers that resynchronise on resume?

I think it's rather a question to HID people...


> Whatever you decide on these, the next posting will be the new shape
> rather than a v9 of this one, and it will cross into drivers/hid, so I
> will send it to both lists.  I will mark v8 superseded in patchwork
> once it goes out.

Well, let's experiment the component stuff a bit.  The v8 doesn't look
too bad, and the disconnection notification handling can be added
easily there, too.  Although I think the component is cleaner from the
design POV, the actual behavior might be problematic in practice (such
as the mixer state restore delay as you described) -- or the
implementation might become too complex than wished.  Let's see.


thanks,

Takashi
