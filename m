Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5803E7BCC;
	Fri, 16 Oct 2026 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144217; cv=none; b=JrGdVVbnS73Lpd6tnaKKdpHNYMCOfDhobogRkPkoM9JpsLt3Q1fxtyjANoHLIPd64xht4h3I0qBuAiK/m+5mUegVXcbpA5s4uAUwjPqd6ZATH649DGWy28gBy2GFu/6EYCTTwCLGiXq3ocB5utsZXXpNo+9vjtMIa15UpOK4Pw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144217; c=relaxed/simple;
	bh=+VH1b7dp2UsdCVDoqNXSe/YT+zOlGcVeF1CesZixEAc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EdsYi/5EW+AZmOR6+gjqij+haAQGGqW+CB9xJtNUsSne8Wp3ZfRZBIQ4zzfmIzJyPLOo1+D05fN+riIJU9Eh7X1xvyNp5GCVv70hYXPxq1iRyqcqLTGxAll2pcHcWxL7phArOtKQ1XaT0zNjYVToCr6xE7agj3+sVYb9u6ziNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZw889mC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZw889mC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235FF1F000C5;
	Fri, 16 Oct 2026 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144215;
	bh=gmAXQRJlfTpv2jTp8nNfSmRL3tsHK2nxYIuDqbrD0Ek=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ZZw889mC+isr1n52Ro8ZqOkARCfLgZGZlxgQX/PBUXte5V6WOxk8TbSwl81mnAfjn
	 wf+LT4CmzCZyFEI5LxWGEBDPNb95bnHWLgBc7bKMVgbty2QEL//1S2CqyT/Fj9wzQQ
	 R9wEb2oxlz0NFaatGse3eXtjVdLybifkzzxL2Fjy8nYCbkJcrHjmhXJIfnOuP7dvok
	 boExSY+GVrFepyinT+zKKhs4QlAujaPF5hd3jpTECt1c9U01UhaLF0kIXAHZ/sKo85
	 Cfp/nucdAlJsGtFMRk1uiVnfN5YO5+MJYEyz80KN+ptK+8/tYwYNUtsCIkWIDv/MFK
	 iDM1XZzRap0Wg==
Date: Fri, 16 Oct 2026 11:50:13 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, tiwai@suse.de, tiwai@suse.com, 
    perex@perex.cz, linux-input@vger.kernel.org, linux-sound@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] the Topping M62's vendor controls, on the component
 framework
In-Reply-To: <20261003184217.34671-1-mikhail.v.gavrilov@gmail.com>
Message-ID: <65584p23-91oo-r3o9-84po-7r7679278pn8@xreary.bet>
References: <20261003184217.34671-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 3 Oct 2026, Mikhail Gavrilov wrote:

> The Topping M62 keeps its analogue input gains, output volumes and
> output source selectors behind a vendor protocol on a HID interface,
> outside the USB Audio Class. On Linux they can only be set by hand on
> the front panel; the one capture gain snd-usb-audio exposes is a
> digital trim after the converter.
> 
> This series makes them ordinary ALSA controls on the card
> snd-usb-audio already creates. 1/2 is a HID driver that carries the
> protocol. 2/2 adds the controls to the M62's mixer quirk, which is
> also the component master the HID driver binds to.
> 
> Two things change since v7.
> 
> The controls now live as long as the card. In v7 the HID driver
> created them on the card it was handed at bind and removed them at
> unbind, so reloading it was visible to everything holding the card:
> the controls came back with new numids, a stored alsactl state no
> longer matched them -- and restore then fell back to its generic init,
> which sets any "Headphone Playback Volume" to -20 dB, here the
> analogue headphone stage -- a sound server kept the elements it had
> already enumerated, and a volume the card was still holding read as
> zero. Now the controls are snd-usb-audio's and the HID driver is the
> transport: it fills in an ops structure the master owns, in the shape
> of struct drm_audio_component (new: include/sound/topping.h), and
> passes on what the card reports. Unbinding it changes nothing about
> the controls, not even their active flag, since alsa-lib's simple
> mixer handles an INFO event by removing the element and adding it
> again -- the very churn this is meant to spare a sound server. A value
> written meanwhile is kept, and the next bind writes it back. Controls
> are no longer removed from a live card either, which is what set off
> the alsa-lib heap corruption described in the v7 cover letter.
> 
> The selectors no longer have an "Unknown" item. The card never reports
> a source selector, and reports an output volume only when its knob
> turns. Topping were asked for a command that reads the selection and
> declined to provide one or to commit to adding one. So the driver now
> sets what it cannot read: at the first bind each output listens to
> Playback 1/2, the analogue headphone volume starts at its quiet end --
> what init_cur_mix_raw() does for a volume it cannot read -- and the
> OTG stream at unity. alsactl and the sound server override these as
> soon as the card appears, and after a resume they are written again
> from the cache.
> 
> On the tree question: 2/2 includes the header 1/2 adds, so it builds
> only on top of 1/2; at run time neither needs the other. 1/2 alone
> binds, subscribes and passes nothing on; 2/2 alone registers a master
> that never matches.
> 
> Changes since v7
> (https://lore.kernel.org/all/20260930213322.32454-1-mikhail.v.gavrilov@gmail.com/):
> 
>   - the controls, their table, tapers and cache moved from
>     hid-topping-m62 into sound/usb/mixer_topping.c; the HID driver
>     keeps the frame, the subscription and the power management, and
>     hands the audio side every valid frame;
>   - include/sound/topping.h is the interface between the two;
>   - the HID driver is now hid-topping, CONFIG_HID_TOPPING: captures of
>     Topping's own application driving their E2x2 OTG show the same
>     frame, and a module name is hard to change once it has been
>     released;
>   - the controls survive the HID driver's unbind without an event, and
>     a write made while it is unbound reaches the card at the next bind;
>   - the "Unknown" item is gone; what the card does not report is
>     written at the first bind and after a resume;
>   - a gain the card has not reported and nobody has set is left alone
>     at a rebind rather than written as the zero the cache holds.
> 
> Sashiko's question on v7 2/2, whether topping_private_free() can race
> the devres unwind of a failed probe, applies to this version
> unchanged, and so does the answer: both run under the usb_device lock
> (https://lore.kernel.org/all/20260930224954.121402-1-mikhail.v.gavrilov@gmail.com/).
> 
> Tested
> 
> Fedora, 7.3.0-rc5-e767a4ea70a3 plus this series, with KASAN (generic),
> lockdep and UBSAN; M62 firmware V87.05.45.48.27, bcdDevice 3.27. Both
> loaded modules, hid-topping and snd-usb-audio, were matched against
> the installed files by build ID, and the new source files in the tree
> they were built from against these patches. Two M62s were connected
> throughout, the second on other firmware, bcdDevice 1.45; the runs
> below address the first unless they say otherwise.
> 
> A reboot with both connected: hid-topping bound the two at 11.6 and
> 11.7 s, and the components were bound at 27.3 and 34.0 s from inside
> snd-usb-audio's probe, each card to the HID device of its own unit, so
> the nine controls existed before either card was registered -- numids
> 11 to 19 on the first card, 12 to 20 on the second, whose USB Audio
> Class part has one control more; the first card's headphone selector
> with fourteen items, on Playback 1/2.
> 
> Module unload and load against the live cards with PipeWire running:
> "amixer -c M62 contents" was identical before and after, and "wpctl
> get-volume @DEFAULT_AUDIO_SINK@" read 0.29 before and after.
> 
> Fifty further cycles of module unload and load, one second apart, with
> PipeWire running on an alsa-lib that carries the remap fix: a hundred
> binds, two per cycle; WirePlumber was never restarted by systemd, and
> nothing on the system dumped core.
> 
> With the card's headphone volume at 20, "Headphone Playback Volume"
> set to 30 while hid-topping was unloaded read 30 after the module was
> loaded again, and one step of the front-panel knob then brought the
> card's own report of 31: the new bind had written 30 to the card.
> 
> "alsactl restore M62" exits 0, with no fallback to the generic init,
> before and after a system suspend to RAM. Around a second suspend, one
> step of a card's headphone knob moved that card's "Headphone Playback
> Volume" by one and left the other card's alone -- before the suspend
> on the first card, after it on both.
> 
> The first card's cable pulled out while audio was playing: one failed
> URB submission from snd-usb-audio, the disconnect, and nothing else;
> plugged back in, the HID driver and the component bound again within
> a second. The second card was not disturbed.
> 
> The cable pulled out again while a loop wrote 30 and 31 into
> "Headphone Playback Volume" back to back: five writes during the pull
> returned EPROTO to amixer, then the card was gone. The log held the
> disconnect and nothing else, and both bound again within a second of
> the plug going back in. The second card's cable pulled out once as
> well: the disconnect alone, and both bound again within a second of
> the plug going back in.
> 
> No WARNING, BUG, KASAN, UBSAN, lockdep report or call trace in the
> kernel log of the whole boot.
> 
> Not re-run for v8, after passing on v7: Mobile Mode without a UCM
> profile.
> 
> Not tested:
> 
>   - the reload cycles with stock alsa-lib: this machine carries the
>     remap fix;
>   - the HID driver binding after the card has registered, so that the
>     restorers run before the controls exist: on every boot here the HID
>     driver bound first;
>   - the write-back after a resume of what the card does not report,
>     which changes nothing a control shows and was not listened for;
>   - an audio-side unbind and rebind with the HID driver left bound;
>   - hibernation, and with it .reset_resume, which shares
>     topping_resume() with .resume: this machine powers off instead of
>     saving an image, for reasons unrelated to this series;
>   - kmemleak, compiled in here but disabled at boot;
>   - a card whose battery has run down;
>   - a big-endian host.
> 
> Mikhail Gavrilov (2):
>   HID: topping: transport for the M62's vendor controls
>   ALSA: usb-audio: add the Topping M62's vendor controls
> 
>  MAINTAINERS               |  10 +
>  drivers/hid/Kconfig       |  20 +
>  drivers/hid/Makefile      |   1 +
>  drivers/hid/hid-ids.h     |   3 +
>  drivers/hid/hid-quirks.c  |   3 +
>  drivers/hid/hid-topping.c | 498 +++++++++++++++++++++

Acked-by: Jiri Kosina <jkosina@suse.com>

Takashi, will you take the whole lot through alsa tree?

-- 
Jiri Kosina
SUSE Labs

