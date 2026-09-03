Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832EA3C09E7;
	Thu,  3 Sep 2026 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424259; cv=none; b=bLLV5aQ7lhT5740pTxHwY/OoUZGYYwvVLB4dioi7fiXBrThp9MEqzfp8zjwh0DS6Mlc4QrqCEH3D0Jvxb+kLKMDUDxpMrrjI1+euOYu1vJo+0eplxM7sXJv8grJMNUPmH0owkoFUjwtykF5ZxeisMKRUUdksptxvQbe/MSS97C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424259; c=relaxed/simple;
	bh=SD6H4UI4s8l7VylxwyGvmcTnY4xkkjZVicQmCgmZY18=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6U3bDt80lxeFpRwRppaIy0I82KarU9fexP0Vsnx1HA4rIbe93cpASoNFtXrapeSBo2ps32mwFrgdyF5hoKHorHvr4Jx7bAkSIYpwuIPwMWZRRftMrkSqz+QjYLhS4dQF6+2lmb/NVWVsdT6rT2lzElNdkV4aLxefMuufuNNThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=viruDGUn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SDVjss+F; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hpHjSYPH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2OY0Ytew; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="viruDGUn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SDVjss+F";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hpHjSYPH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2OY0Ytew"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BFE0321EAB;
	Thu,  3 Sep 2026 08:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788424250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OAMRRCSvOOBBy+6q1gPRhlz732YQJE2ZWCkdiF6I8nc=;
	b=viruDGUnHrrBdG1tfMPk9Z8vXFtLfxxTdvknmAPZteCYC7M9oSPENLnbcLgB/dSeyMgPY4
	yc6B4WW35fO70KYI3MP7DiL75p5OEfCI9XjU67x8BQPx3irrKIIZxVsiSqBsjwWj5fn1GV
	fs1P1jq+pqMZFRLkafYdscnDhlAQYrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788424250;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OAMRRCSvOOBBy+6q1gPRhlz732YQJE2ZWCkdiF6I8nc=;
	b=SDVjss+F/JmNk6Ab03O6PCzEQfD4jTa723psJFIggvEZasiPr9Em2FwMO5XXl1Er8alTSm
	uMqfwqHcd1OtCzDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hpHjSYPH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2OY0Ytew
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788424246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OAMRRCSvOOBBy+6q1gPRhlz732YQJE2ZWCkdiF6I8nc=;
	b=hpHjSYPH7fWO23bRblO+DDdOwvXFHQF0McuZ7oTHmlEOAGdyhCd2TB+0nfV/J+Jo9AK5UJ
	KN3MU1psv4D/ziFAiPpiHSMbefxiIwm0T0pPCUrP8GiosaIYplQC2DUPOqsDMnBHVJ79fe
	r25Ome8R2vKYjqCtW2o29pH8cDLwBKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788424246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OAMRRCSvOOBBy+6q1gPRhlz732YQJE2ZWCkdiF6I8nc=;
	b=2OY0YtewmdWoFm+xw4ryneZe1UkITn6LIy4nDflMHpRDSemqWogR20To4RZ+vL+P6PzIQL
	/dTBDurR/kF/LTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EA29136D9;
	Thu,  3 Sep 2026 08:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8vz9DTYwmWqrKgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 03 Sep 2026 08:30:46 +0000
Date: Thu, 03 Sep 2026 10:30:45 +0200
Message-ID: <87se3q91oq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] ALSA: usb-audio: the Topping M62's vendor controls
In-Reply-To: <20260826180607.324604-1-mikhail.v.gavrilov@gmail.com>
References: <20260825111239.24834-1-mikhail.v.gavrilov@gmail.com>
	<20260826180607.324604-1-mikhail.v.gavrilov@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BFE0321EAB
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.01

On Wed, 26 Aug 2026 20:06:07 +0200,
Mikhail Gavrilov wrote:
> 
> Found on my own bench while chasing something else, and I would rather
> bring it than have it found for me.
> 
> The problem, as a user could see it: after unbinding the vendor
> interface by hand, the driver keeps writing to the card. Reads stop --
> the control freezes on its last announced value -- while writes go on
> reaching the hardware, and the two-second keepalive presumably goes on
> with them, into an interface the driver no longer owns.
> 
>   # echo 3-1.3:1.4 > /sys/bus/usb/drivers/snd-usb-audio/unbind
>   # amixer -c M62 cget name='Mic-1 Analog Capture Volume'   # frozen
>   # amixer -c M62 cset name='Mic-1 Analog Capture Volume' 50
>   ... and the gain really moves on the card.
> 
> The sound card itself survives the unbind untouched, which is right and
> is the good half of the result.
> 
> My reading of why, and I would be glad to be corrected on it. The quirk
> claims that interface with usb_driver_claim_interface() and marks it
> USB_AUDIO_IFACE_UNUSED, so usb_audio_disconnect() returns at its first
> line and nothing ever tells the quirk to wind down. Meanwhile
> usb_interrupt_msg() takes a struct usb_device and an endpoint address,
> not an interface, so losing the claim costs the driver nothing on the
> write path; the read path dies only because usbcore kills the URBs on
> the interface being unbound.
> 
> So the claim is what keeps usbhid away, not what grants the right to
> write, and the two are easy to conflate -- I had conflated them.
> 
> How reachable this is: only by hand from sysfs. A plain unplug takes
> the whole device, and there disconnect runs on the audio interfaces and
> the quirk is freed with the mixer. I have not found a path that reaches
> it in ordinary use.
> 
> How I plan to solve it, and this is where I need your word, because the
> change is in card.c rather than in my own file. An interface the quirk
> claimed is marked exactly like one nobody wanted, and those two are
> different things: the first has a driver behind it that should be told
> when it goes away. The shapes I can see are
> 
>   (a) let the quirk register a small teardown callback at claim time
>       and have usb_audio_disconnect() run it before the early return,
> 
>   (b) give the claimed-and-used case its own sentinel instead of
>       USB_AUDIO_IFACE_UNUSED, so disconnect can tell them apart,
> 
>   (c) leave card.c alone and have the quirk take a usb_device
>       reference plus its own notifier, which keeps the fix inside
>       sound/usb/mixer_topping.c at the cost of a second path watching
>       the same event.
> 
> I lean to (b) as the smallest honest change, but this is your file and
> the sentinel is your convention.
> 
> Whichever you prefer, I would rather send it as a follow-up once the
> current series lands than fold it into v9: it is a separate defect,
> it touches a path shared by every quirk, and stirring it into a series
> under review would make both harder to read.

Thinking more on this, I see another possibility.  Namely, create an
individual HID driver like your previous plan 2, but instead of
creating an own snd_card object, use the component framework
(include/linux/component.h) for binding between the audio and the HID
drivers.

That is, in USB-audio side, you'll have a mixer quirk to add the
component master.  In the HID driver, you'll register a component to
be bound.  In the bind callback, the snd_card object is passed from
the USB-audio component master, and you can instantiate the mixer
kcontrols there.

At disconnection of USB-audio, the mixer quirk calls the component
unbind, and the HID component unbind callback frees the created
kcontrols in turn.  If the HID is unbound first, it just unregister
the component (and frees the kcontrols).  If the HID is re-bound, it
just re-adds the kcontrols at its bind callback again.

The component match might be a bit tricky, but it should be certainly
feasible.


thanks,

Takashi
