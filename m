Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE682D9484;
	Sun, 23 Aug 2026 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787475109; cv=none; b=pGGKAzdz5zZbX8uu9mJAco1xtzYYB4BXx8j1JOVL5Yo7CyEcjoSeplPEbDCSJsKSBCIzC4ZfOk+6XsbHeJBuEbZoLro7MJ8XN6GR/QKvD3mWsTdz1wVYbaDQ79Fxl6nZBOemCuGEgCdoWFaw6JE3RWqizNCOwgQuUUUcC0JVS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787475109; c=relaxed/simple;
	bh=W+oWCvEswXDgQP4QPRhSokTCey3kay04HHL1/CXBXVw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXqpKRP3pnewo6AoIzP5ZCyCGx+U3VAtVpGw8DFwdiXXwgX/tAQb4XW7LceF8DTVwv0DtGU6bGl180spNlWpG54IZct5pndzjVt50TwyMiu9MwUhu8oc1DOrnZ77DhOHwFzJo45GN4Dr9IsYIhY1pCdN0D2V8XTv0a1SFTOuszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SYi5QYul; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vQeTirr2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uhw14Zpv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dLvKb+gi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SYi5QYul";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vQeTirr2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uhw14Zpv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dLvKb+gi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D3CC3E04;
	Sun, 23 Aug 2026 08:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787475011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=coqy+q8OZPNQJ1s1m4PO7s5VBxleeMC7LXTi4F5Vaqw=;
	b=SYi5QYulqrZAJpbJdNmETN7SwAqMqmb0Sm4VrxNMtRsvEpUjsTEE+R+y+PNLaYxnZI4T71
	JjHyEGULfZ1aVB19GXm2ZIkYCNGk6UYN0wujKnODkIbzn1PoierK1OpnxSXIXme1l8NI8b
	6Vst4j0UMhNSwqUe1CYMpqYWQaLkVYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787475011;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=coqy+q8OZPNQJ1s1m4PO7s5VBxleeMC7LXTi4F5Vaqw=;
	b=vQeTirr22q3h+0WWSVPl5qSjFAyEvBDYLghEHCyNMS2TvTrwQz9XdTBgr8xpvJB9cNJsaf
	IcIQlU58FeJwGFDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787475007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=coqy+q8OZPNQJ1s1m4PO7s5VBxleeMC7LXTi4F5Vaqw=;
	b=uhw14Zpvfs2lxqB48ubIeNlLQKA2+tJyP4x7b0aS+GrAugjwJ2xWnzSxMZL7WUC2YKyF2v
	l0BUHCvDjxVUPk2wTliSdi+agQAj/mwCcoeiQzSTXuEPhepD9tdeGZ7HIk+wgfAmoNK0VB
	pC92XaChDjHFq6dBgXqL1Kuflf3IsGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787475007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=coqy+q8OZPNQJ1s1m4PO7s5VBxleeMC7LXTi4F5Vaqw=;
	b=dLvKb+giBUCFqe/MA/EmavaAW5F+kQ6Tf0rips5CVrjmBeY+jE7hePKiYYQTRnb6fhASgv
	QYNbfjU9UQyKuqBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6BC513332;
	Sun, 23 Aug 2026 08:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HMl/Lj60imqAfwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 23 Aug 2026 08:50:06 +0000
Date: Sun, 23 Aug 2026 10:50:06 +0200
Message-ID: <87o6etw79d.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: tiwai@suse.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] Two ways to reach the Topping M62's analogue gains
In-Reply-To: <20260820151329.18332-1-mikhail.v.gavrilov@gmail.com>
References: <87y0eaxz39.wl-tiwai@suse.de>
	<20260820151329.18332-1-mikhail.v.gavrilov@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

On Thu, 20 Aug 2026 17:13:27 +0200,
Mikhail Gavrilov wrote:
> 
> You asked for PoCs of both roads and a comparison of the actual code
> rather than of arguments. Here are both. They are alternatives, not a
> series: each is written against mainline 98f21c54f995 on its own, and
> either can be applied alone.
> 
>   1/2  ALSA: usb-audio: a mixer quirk that claims the HID interface
>   2/2  HID: topping: a HID driver that registers a card of its own
> 
> Both build clean (checkpatch --strict: 0 errors, 0 warnings; the two
> CamelCase CHECKs in 1/2 are bNumEndpoints and bInterval) and both have
> been exercised on the device -- 152a:875c, bcdDevice 3.27 -- for
> reading, for unsolicited notification from the front panel, and for
> writing.
> 
> What the device is
> ==================
> 
> The M62 keeps its two microphone preamp gains, its AUX and Bluetooth
> input volumes and its headphone and OTG output volumes behind a vendor
> protocol on a HID-class interface, and exposes none of them through
> UAC. What UAC does expose on the capture side is a digital trim after
> the converter, which cannot buy signal-to-noise: a noise-floor ladder
> against the card shows the converter's own floor rising with the
> signal. So on Linux today the one knob worth setting is the one that
> cannot be reached, and a measurement application has to begin by asking
> a human to touch the front panel.
> 
> The protocol is fifteen-byte frames -- start magic, a constant, a
> target, a property, a signed 32-bit big-endian value, CRC-16/MODBUS
> over the middle stored big-endian, end magic. Rebuilding all 2619
> captured frames from that description reproduces them byte for byte.
> The device says nothing until it is subscribed; one write starts the
> stream and a second makes it announce its whole state, after which
> every change arrives unasked, including a front panel press.
> 
> The control pipe is not an option: GET_REPORT and SET_REPORT stall with
> EPIPE for every report type, so the interrupt endpoints on the HID
> interface are the only route.
> 
> What is identical in both
> =========================
> 
> The frame builder, the parser, the CRC (the kernel's crc16(0xffff, ...)
> is CRC-16/MODBUS, so no private table), and the control table. A knob
> is a row of
> 
> 	{ name, target, paired target, property, min, max, TLV }
> 
> so adding one is adding a row. Six rows today. The outputs come in
> pairs because the device answers on only one target of each pair and
> the other would drift away unheard.
> 
> Where they differ
> =================
> 
> 1/2 claims the HID interface for snd-usb-audio and puts the elements on
> the card the device already has. The cost is two-sided: an entry in
> hid_ignore_list to keep usbhid off the interface, and one new helper in
> sound/usb/card.c, because usb_audio_driver is static there and a quirk
> cannot claim an interface without it. That helper is the only change in
> 1/2 outside the new file and its dispatch. Nothing is lost by taking
> the interface: the report descriptor is a Generic Desktop application
> collection with eight unnamed usages, sixteen bytes in and out and no
> report ID, so hid-generic can only build an input device for a mouse
> that does not exist -- which is what it does today.
> 
> 2/2 binds as a HID driver, and the protocol half is if anything smaller
> there: usbhid owns the endpoints, so hid_hw_output_report replaces a
> hand-built interrupt URB out, raw_event replaces the one in, and no
> interface has to be claimed. It needs nothing in sound/usb.
> 
> But these are mixer controls for an audio device, and the audio
> device's card belongs to snd-usb-audio. A HID driver cannot put an
> element there. There is no interface for it, and inventing one means
> exporting from sound/usb both a lookup from struct usb_device to the
> card and an add-element call, and then answering, for a single device,
> what happens when the two drivers probe in either order and when either
> disconnects first, given that the element would live in one module and
> its private data in another.
> 
> So 2/2 does what a HID driver can do alone: it registers a card of its
> own. That works, and the cost is visible from userspace rather than
> theoretical:
> 
> 	$ cat /proc/asound/cards
> 	 0 [ToppingCtl     ]: Topping - Topping M62 control
> 	 ...
> 	 4 [M62            ]: USB-Audio - M62
> 
> 	$ amixer -c M62 cset name='Mic-1 Analog Capture Volume' 33
> 	amixer: Cannot find the given element from control sysdefault:4
> 
> One device, two cards; the gains on a card with no PCM beside them; and
> anything that looks for a device's mixer next to its streams --
> alsamixer -c, UCM profiles, PipeWire's device model -- does not find
> them there.
> 
> Against my own preference, two honest notes. The phantom input device
> 2/2 leaves at boot (hid-generic binds first, the specific driver being
> a module outside the initramfs) is a packaging artefact, not a property
> of that road. And 1/2's claim helper is new API surface in sound/usb,
> small as it is.
> 
> Field results
> =============
> 
> With 1/2: the interface belongs to snd-usb-audio while a neighbouring
> device's HID interface still belongs to usbhid, so the ignore entry is
> precise. Values arrive by themselves -- the headphone volume came up at
> 51 while the zero-initialised cache would have said 0. One front panel
> press produces exactly one control event. A write reaches the hardware:
> the device reports the written value back, and its meters answer.
> 
> With 2/2: the same, on its own card.
> 
> One device fact worth recording: a written gain takes effect at once,
> but when the device commits it to non-volatile memory is the firmware's
> business, and a value written and then torn off the bus can come back
> as the older one. Nothing in either driver depends on that -- neither
> treats itself as the source of truth, both ask the device -- but it is
> easy to mistake for a driver bug while testing.
> 
> Where I come out
> ================
> 
> The knobs belong on the card the device already has, and 2/2 cannot put
> them there without a new cross-subsystem interface built for one
> device. 1/2's cost is one static-variable problem solved by one helper
> in the file that owns it. So I would take 1/2, which is also your gut
> feeling -- but the comparison is what you asked for, and either patch
> stands alone if you read it the other way.
> 
> Not covered by either: the OTG input's gain. It has no front panel
> control and therefore never announced itself in any capture, so its
> property is unknown. It is one row when it is known.

Thanks!  I didn't expect such complete patches when I asked for PoC,
and you've done much better than I thought :)

Honestly speaking, both look well acceptable.  From the pure kernel
POV, the 2nd patch is simpler, but as you pointed out, we'll need
another stuff to combining two sound cards.  It'd be likely a special
UCM profile, but this can be a bit hackish.

So, from the usability POV, the first patch would be "easier", and if
I have to choose, my gut feeling is to pick the first one.  But again,
I have no strong opinion, and both look good in general.  I'd like to
hear from others, too.

About the code, there are a few things to be improved.  The spinlock
could be done better with guard().  A temporary buffer could be
handled with __free(), too.


thanks,

Takashi
