Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8CD51C357;
	Mon, 19 Oct 2026 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419445; cv=none; b=Z5XFrQduXwbTz2w0MXSjrZR10LLdr+jppSRHzVqsGs8Vz+jrha8AVe+di76tnyiK+W2gdn/BUufla7lTaFj7AGTVPQ8nk1pCh7ZP+qshAXh8VIadZhKP4K94bEquDf2nPJ8ZttO3O/0MiGx0k99Y7EoLYHzpoedYogk4ez/S/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419445; c=relaxed/simple;
	bh=UhrxYagCqa8mQ1C6pAsqhCqUcTMdvH1M8eXcrPWSexE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyUEfefZEB5YJyh3KWxFsNn1J/Xh2B14ch5sAGqYACe6Jbgf+Ac5pTEz/JjCwNnrIUeOc5cFWnjYpe/PUX4U5HbhN3/saVxAkfFAvmPFKoigtM/pGUJCZ9fVpVzsrN4EZxH5G9jypNnrsqyHuT5yir0ieFcCdkFuzVRnKo76r24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LxJL3v8T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xdhx//2E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LxJL3v8T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xdhx//2E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LxJL3v8T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xdhx//2E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LxJL3v8T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xdhx//2E"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4393B21BC6;
	Mon, 19 Oct 2026 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792419441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rnJ3YKmdMBp6QlyeeEJkwytarl3hcpSj9DyYlRqz4GA=;
	b=LxJL3v8TWo4+GonuC7EMV9gYleUhWClcZzECl8ucGWHfLgo3mDY4P6Hdj8pZk7QZKEMepm
	0QNiW8L+bPwzz3zlL0DcjKMzZHvDec08w3CE3wJeAHEeHGVvnwuqrzGjbgddPvCMQTjPfL
	HmJ2zyM0G5YWQwyDD+B6c+WdkFawCyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792419441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rnJ3YKmdMBp6QlyeeEJkwytarl3hcpSj9DyYlRqz4GA=;
	b=xdhx//2EGbXmIO2LvRaAN/0D5d9wav1lJ2XL1EkLMgEK7J+PzzMi2x+wiJuovy9gjBv3di
	DetZ08jUqZCPYiDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792419441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rnJ3YKmdMBp6QlyeeEJkwytarl3hcpSj9DyYlRqz4GA=;
	b=LxJL3v8TWo4+GonuC7EMV9gYleUhWClcZzECl8ucGWHfLgo3mDY4P6Hdj8pZk7QZKEMepm
	0QNiW8L+bPwzz3zlL0DcjKMzZHvDec08w3CE3wJeAHEeHGVvnwuqrzGjbgddPvCMQTjPfL
	HmJ2zyM0G5YWQwyDD+B6c+WdkFawCyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792419441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rnJ3YKmdMBp6QlyeeEJkwytarl3hcpSj9DyYlRqz4GA=;
	b=xdhx//2EGbXmIO2LvRaAN/0D5d9wav1lJ2XL1EkLMgEK7J+PzzMi2x+wiJuovy9gjBv3di
	DetZ08jUqZCPYiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE9E6136CC;
	Mon, 19 Oct 2026 14:17:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A0fmLHAm1mpWXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Oct 2026 14:17:20 +0000
Date: Mon, 19 Oct 2026 16:17:20 +0200
Message-ID: <877bjdai6n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	tiwai@suse.de,
	tiwai@suse.com,
	perex@perex.cz,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/8] the Topping M62's and E2x2 OTG's vendor controls, on the component framework
In-Reply-To: <20261018205711.168291-1-mikhail.v.gavrilov@gmail.com>
References: <20261018205711.168291-1-mikhail.v.gavrilov@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Sun, 18 Oct 2026 22:57:02 +0200,
Mikhail Gavrilov wrote:
> 
> The Topping M62 and E2x2 OTG keep part of their mixer behind a vendor
> protocol on a HID interface, outside the USB Audio Class: on the M62 the
> analogue input gains, the output volumes, the MUTEs beside them and the
> output and loopback routing, on the E2x2 OTG the input gains, the
> faders, the routing and the output switches. On Linux they can only be
> set by hand on the front panel where it has a knob for them, and not at
> all where it has none. An E2x2 OTG whose headphone, TRS and AUX outputs
> were switched off by the vendor's application stays silent on Linux, and
> so does an M62 input or output that application left muted. The M62's
> battery level, which the card reports, shows nowhere, and an M62 whose
> USB-C port that application has set not to charge from the computer runs
> its battery down, with nothing on Linux to set it back.
> 
> This series makes them ordinary ALSA controls on the card snd-usb-audio
> already creates. 1/8 is a HID driver that carries the protocol, and 2/8
> adds the M62's controls to its mixer quirk, which is also the component
> master the HID driver binds to. 3/8 and 4/8 add the E2x2 OTG, which
> speaks the same frame; 5/8 offers the M62's battery level as a power
> supply, 6/8 the power settings of its two USB ports as controls, 7/8 the
> M62's MUTEs as switches and 8/8 the E2x2 OTG's input MUTEs. 1/8, 3/8 and
> 5/8 are HID, the other five ALSA: the ALSA patches build on the header
> 1/8 adds and need nothing else from the HID side.
> 
> Changes since v9
> (https://lore.kernel.org/all/20261018124838.129349-1-mikhail.v.gavrilov@gmail.com/),
> all three after Sashiko's review of it:
> 
>   - 5/8: the battery's power supply is registered without devres, its
>     name made at probe, and unregistered in .remove() once the reports
>     have stopped. component_bind() keeps a devres group open on the HID
>     device while topping_bind() runs, and a battery report that came in
>     meanwhile could put the supply registered with devm into that group,
>     so that the audio side's next unbind freed it under the driver;
>   - 5/8: the bind opens its session under a runtime PM reference, taken
>     before the component is published. A bind outside any USB probe, as
>     when hid-topping is loaded onto an interface usbhid already holds,
>     could otherwise outlast the autosuspend delay while it waits for the
>     card's answer to the handshake;
>   - 1/8: pm_ptr() around the PM callbacks. That is the only change to
>     1/8, so it keeps Jiri Kosina's Acked-by.
> 
> The selectors keep "... Source". Named "... Playback Route" or
> "... Capture Route", a selector would join the volume of the same name
> in alsa-lib's simple mixer, which then reads and writes only the
> selector.
> 
> Tested
> 
> Fedora, 7.3.0-rc7-32c52ec87d62 plus this series, with KASAN (generic),
> lockdep and UBSAN, an M62 (firmware V87.05.45.48.27, bcdDevice 3.27 in
> Pro Audio Mode, 1.45 in Mobile Mode) and an E2x2 OTG (firmware V1.10,
> bcdDevice 1.10). Both loaded modules were matched against the installed
> files by build ID.
> 
>   - fifty cycles of hid-topping unload and load with both cards
>     connected and PipeWire running: a hundred binds, two per cycle,
>     every mixer control of both cards the same before and after, and the
>     M62's battery supply there again after the last load;
>   - five audio-side rebinds of each card with the HID driver left bound,
>     all three snd-usb-audio interfaces unbound and the control interface
>     bound again: ten binds, every control there again, and the M62's
>     battery supply still there after each;
>   - "alsactl restore" exits 0 on both cards;
>   - suspend to RAM and back: the controls of both cards unchanged, and
>     afterwards the M62's headphone knob and an E2x2 OTG MON button each
>     reported to their own card;
>   - the cable pulled out twice on each card during playback while a loop
>     wrote a loopback gain: each time the card bound again once plugged
>     back; after the last plug the control took the loop's writes again
>     and read the last one written, and neither hid-topping nor the
>     quirk logged an error;
>   - the M62 switched to Mobile Mode and back, twice: the driver's twenty
>     controls in Mobile Mode, the first bind writing every one of them,
>     and alsactl's restore the stored gains 0.10 to 0.12 s later;
>   - the M62's port power at eighteen first binds with the HID driver
>     loaded after the card, out of reach of alsactl's restore: on a card
>     left on Off and Discharge the bind wrote Charge and Off, and Off and
>     Discharge written right after the bind, as a restore of those values
>     would, left the card on the bus for the 10 s it was watched; every
>     value of the two the card announced afterwards was the one last
>     written;
>   - the M62 answered each of the 75 handshakes captured in these runs
>     11 to 378 ms after it, and no other frame of the protocol was sent
>     to it in between;
>   - the M62's Loopback 1/2, with a 1 kHz tone at -20 dBFS peak on
>     Playback 1/2 and all sixteen capture columns recorded: its source
>     set to Playback 3/4 turned the two Loopback 1/2 columns into digital
>     zero and set back brought the tone back; its gain at -20 and +12 dB
>     moved them by -20.00 and +12.00 dB;
>   - each M62 input's switch turned off took the input to digital zero,
>     in its own capture columns in Pro Audio Mode and in the recording in
>     Mobile Mode, and turned on brought it back;
>   - each E2x2 OTG input's switch turned off silenced the card's meter of
>     that input; a gain set while it was off was not written, and the
>     switch turned on wrote it and the meter came back;
>   - no WARNING, BUG, KASAN, UBSAN, lockdep report or call trace in the
>     kernel log over these runs, and lockdep still on after the last.
> 
> The M62's battery shows as a power supply, and in UPower, 2.6 to 2.8
> seconds after the card is plugged in, and 1.8 to 3.5 seconds after it
> comes back in Mobile Mode.
> 
> With PipeWire and the M62's UCM profile
> (https://github.com/alsa-project/alsa-ucm-conf/pull/826), in Pro Audio
> Mode the M62's headphone level follows the desktop volume and the
> front-panel knob both ways; with the E2x2 OTG's profile, to be sent
> after that pull request, the desktop volume moves the E2x2 OTG's
> Master.
> 
> Not tested:
> 
>   - runtime autosuspend: power/control was "on" on both cards, so the
>     reference the bind now takes kept nothing awake;
>   - hibernation, and with it .reset_resume;
>   - kmemleak, compiled in here but disabled at boot;
>   - a card whose battery has run down;
>   - a big-endian host.
> 
> The plain E2x2, 152a:8752, is left out: it needs its own channel names
> and a test by someone who has one.
> 
> Mikhail Gavrilov (8):
>   HID: topping: transport for the M62's vendor controls
>   ALSA: usb-audio: add the Topping M62's vendor controls
>   HID: topping: add the E2x2 OTG
>   ALSA: usb-audio: add the Topping E2x2 OTG's vendor controls
>   HID: topping: report the M62's battery level
>   ALSA: usb-audio: add the Topping M62's port power settings
>   ALSA: usb-audio: add the Topping M62's mutes
>   ALSA: usb-audio: add the Topping E2x2 OTG's input mutes

Mikhail, this can't work for upstreaming.  You expanded your series in
the very last day of the 7.3 quite significantly.  That makes all
patches mandatory to be reviewed again, and it means that it's not for
7.4 but for 7.5 in the next year.

And for 7.5 stuff, now is the worst time for review, as the merge
window for 7.4 was opened today.  So either have patience for the
future, or try to fit with the kernel development cycle.


thanks,

Takashi
