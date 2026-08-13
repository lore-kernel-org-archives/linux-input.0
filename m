Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289943E835E;
	Thu, 13 Aug 2026 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605862; cv=none; b=tR8f6W588s43nrnqo0IY6an1TpD7Y8igEqBYq2Xpe3Suw76gtXMBWuzmPb+OcEpZ10I0hYikSq6+hJZSNX4kB4gLk8MBYBugkPcDSYJlhtCVWs9+u/OBoRUkHhfqdaWXGi5UzxzzSq0z2HyqoKWl0QiqkGeoj7vw4sT9rtIQBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605862; c=relaxed/simple;
	bh=wMDZ+yF7MJiRi4BHF5SeNdn9SuoSk7DaMkxHNFzFuw8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0W/OnzcqpUQt6m/bjKypergTzlUp1/MVShpuyem3wRHfApzxHhRDeu4vUHg4ogGQF4TxQIEtq57ctG2CuBji4TiZWgZpAu0P3W2oCJxsK/ZPfuViEiseXxiO7JYjp0IM0Z5OflLVzVIQ/C/iT0Sf0IKV06eJXDci/pqvpxbD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wWDkgTEW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cPCOgL/l; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PkWJx3x7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9lqeTZm1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wWDkgTEW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cPCOgL/l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PkWJx3x7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9lqeTZm1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6B6682824;
	Thu, 13 Aug 2026 07:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786605855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=do+fgxlFzWNLnyxWPlPOeXJtL859gPZdnzZV0K9r9mU=;
	b=wWDkgTEWaAo3vZFiwF+DBFKUdYwxN0HI1IUX6zuoh5vEfD/IKCWaKji36UDE1UgUglqynK
	if8LWCw+VflVLbIwGXUtQ+sz12m0aOqQ8DuzTTyZUE8uA/aViBYXHCUDGbzD7qd0JBxQCN
	rF+XAqVvjkF4C9GW2DBySvmW3gSj74E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786605855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=do+fgxlFzWNLnyxWPlPOeXJtL859gPZdnzZV0K9r9mU=;
	b=cPCOgL/l6gCamO7yKYRi2BF5038PB497V+zebDhMVYtNE2PSrtgm4jXuEjoLd03/d6OpGn
	RPRql90WAPsx0wDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786605850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=do+fgxlFzWNLnyxWPlPOeXJtL859gPZdnzZV0K9r9mU=;
	b=PkWJx3x7Nck3Wqf59kfZ3iR87H/V/1mzTOkSZdYpq75S+2CWDU1tA57P6i79Suy4zfs52p
	W+u5XCz30uKkbLoRBCHLjxLsPw9cT/oZ9asED6MZr8mpjrgM/J8mgyuoSsU7YwsouCY3Q6
	FKog8wp06Mgbk0z4saOoA8a16pswDkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786605850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=do+fgxlFzWNLnyxWPlPOeXJtL859gPZdnzZV0K9r9mU=;
	b=9lqeTZm1s3V4oAW+mKkdn8+4UOttbbomdsKprvCppvCDhedR9/gqpwseOsKIyNFf7oHIQ9
	cBKoXhAxGETk3kAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F6A877CCE;
	Thu, 13 Aug 2026 07:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xlOcJRpxfWoXRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Aug 2026 07:24:10 +0000
Date: Thu, 13 Aug 2026 09:24:10 +0200
Message-ID: <87y0eaxz39.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	g@b4.vu,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Subject: Re: snd-usb-audio: exposing a vendor HID control channel as mixer controls (Topping M62, 152a:875c)
In-Reply-To: <20260812171036.144085-1-mikhail.v.gavrilov@gmail.com>
References: <20260812171036.144085-1-mikhail.v.gavrilov@gmail.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

On Wed, 12 Aug 2026 19:10:34 +0200,
Mikhail Gavrilov wrote:
> 
> Hello,
> 
> I would like to add ALSA mixer controls for the analogue input gain of a
> USB audio interface whose control channel is a vendor-specific HID
> interface, and I would like to agree on the shape before writing code,
> because it crosses into drivers/hid.
> 
> The device is a Topping Professional M62, USB 152a:875c. In its
> multichannel modes it presents 10 playback and 16 capture channels on
> interfaces 1 and 2, a DFU interface, and interface 4 of class 3 (HID)
> with a vendor-defined usage page, one 16-byte Input report and one
> 16-byte Output report, and no report IDs.
> 
> The problem: the microphone preamplifier gain, 0..88 dB per the
> specification, is not reachable through ALSA. The card does expose a
> 'Mic Capture Volume', but a gain ladder measured in silence shows that
> control to be a digital trim after the converter. The recorded noise
> floor is flat at about -172 dBFS at the bottom of its range, far below
> any converter's own noise floor, so what is being measured there is the
> sample word running out of bits; above that the floor rises with unity
> slope, i.e. one fixed analogue noise being divided down. The analogue
> stage is reachable only over the HID interface, which is what the
> vendor's own application uses.
> 
> I have the protocol. It was reverse engineered from captures of the
> vendor application's traffic, the same way sound/usb/mixer_scarlett2.c
> describes in its header. Frames are 15 bytes:
> 
>   22 33 | 20 01 01 | target | property | s32 big endian | CRC | 66 77
> 
> with CRC-16/MODBUS over bytes 2..10, stored big endian. Rebuilding
> every frame of a capture from the decoded fields reproduces all 2619 of
> them byte for byte. Inbound reports are that frame plus one pad byte.
> The device stays silent until the host sends a subscription frame,
> after which it reports every state change including front-panel button
> presses, and it answers a "report your state" frame with a full dump.
> The analogue gain of each microphone input is a single property carrying
> whole decibels, 0..88, so a plain TLV_DB_SCALE fits it.
> 
> The constraint, and my question. This device accepts nothing on the
> control pipe: SET_REPORT and GET_REPORT both stall with EPIPE, for
> report types Output, Input and Feature alike. So the pattern used by
> snd_soundblaster_e1_switch_update() in sound/usb/mixer_quirks.c, which
> sends HID_REQ_SET_REPORT through snd_usb_ctl_msg(), is not available
> here. The only usable transport is the interrupt endpoints of interface
> 4, which usbhid binds.
> 
> Would it be acceptable for a mixer quirk in sound/usb to own that
> interface? Concretely: an entry in hid_ignore_list so that usbhid stays
> away, the quirk claiming interface 4, an interrupt IN URB whose
> completion handler parses the vendor frame, updates cached values and
> calls snd_ctl_notify(), and usb_interrupt_msg() in the put callbacks.
> The notification half looks like what snd_usb_mixer_status_create()
> already does for the audio control interface's status endpoint. Or would
> you prefer a different layout for this?
> 
> A first patch would be deliberately minimal: two controls for the
> analogue gain of the two microphone inputs, with a dB TLV, and nothing
> else. The line-level inputs and the outputs use index scales with a
> piecewise taper, which I have measured but would rather submit
> separately.
> 
> For context, an ALSA UCM configuration for the same card is already
> proposed as alsa-project/alsa-ucm-conf#826. That is what would designate
> the new control as the capture volume, so that userspace moves the
> hardware gain instead of the digital trim.
> 
> I can post the full protocol notes and the captures if that would be
> useful.

I believe we can judge better with the comparison of the actual code.
You can try implementing PoC's for both usb-audio mixer quirk and a
HID driver, then compare which would fit better.  If either of them
looks significantly harder, you don't fulfill the implementation, of
course.

My gut feeling is that we can take it as a mixer quirk, but it really
depends on the complexity.


thanks,

Takashi
