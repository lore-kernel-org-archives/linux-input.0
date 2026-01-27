Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D424E4C6
	for <linux-input@vger.kernel.org>; Tue, 27 Jan 2026 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769499039; cv=none; b=j9drG7j89lDr9TosiBv+2qh8dZ1hJl9yktw4RFGT+pNsWOSs4Fif7JLmX3UknVaK1FxgbXuDWe1ish6EYOZ35KNQptCCmAdhYMLJk91pjmgIWR80wDtkaV/k+R+M1n0VxeztEofdLlcO584nyj3GSFTdR0jPA2ul98j/V//OWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769499039; c=relaxed/simple;
	bh=/tlF0qpjxkjcAo75X8yPk1jutjNRUNTQzbswh7afmqI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ql8nz+XOi6FlpdAq8+K/eqZDZ8zYGOxLc0hLO6SbTIhAV9lvjuWxf1UeJ0Cd5MmzkmMf66aMYF7Dk1WUnJpLss4ImCRwdQysoYiCB3DGyARIhzIg6aBEyYX06fzU/o038nh0gZ/UV5LA41LrMtrLFshsS5m6KdbGVZLe05Q/f7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zSCBeS4D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vpd6tUbX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zSCBeS4D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vpd6tUbX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zSCBeS4D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vpd6tUbX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zSCBeS4D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vpd6tUbX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9400833769;
	Tue, 27 Jan 2026 07:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769499034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYKzOnVrupxhzXKWPZL7mjv2UMNPeqUIY4E5ULDHLI=;
	b=zSCBeS4DDmZfLPHK/5pqsgBKRVqx52nvcuA5F2SDLaE/HV4IOgDSeJ68QaBgDCXHLFzCT8
	gB9+hzevRUSjijFnKQrwSaUgbCneWjsJxOrHxazWQtdQvFq4hdH1no+Me+r6COTLKd5ErL
	br4ff/NUNrD3HZYYZHmmWkXrHjpHThQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769499034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYKzOnVrupxhzXKWPZL7mjv2UMNPeqUIY4E5ULDHLI=;
	b=Vpd6tUbXV7tTOAP4lq4PXYq8lhNGp9Zjbv4jher7SaBuiddWO8kMIHIE+asgswcl9XsR+C
	0jhxS6wdO0D6E6DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769499034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYKzOnVrupxhzXKWPZL7mjv2UMNPeqUIY4E5ULDHLI=;
	b=zSCBeS4DDmZfLPHK/5pqsgBKRVqx52nvcuA5F2SDLaE/HV4IOgDSeJ68QaBgDCXHLFzCT8
	gB9+hzevRUSjijFnKQrwSaUgbCneWjsJxOrHxazWQtdQvFq4hdH1no+Me+r6COTLKd5ErL
	br4ff/NUNrD3HZYYZHmmWkXrHjpHThQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769499034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPYKzOnVrupxhzXKWPZL7mjv2UMNPeqUIY4E5ULDHLI=;
	b=Vpd6tUbXV7tTOAP4lq4PXYq8lhNGp9Zjbv4jher7SaBuiddWO8kMIHIE+asgswcl9XsR+C
	0jhxS6wdO0D6E6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3170913712;
	Tue, 27 Jan 2026 07:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHO5CpppeGlmawAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 27 Jan 2026 07:30:34 +0000
Date: Tue, 27 Jan 2026 08:30:33 +0100
Message-ID: <87h5s7pl5y.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: gongqi <550230171hxy@gmail.com>
Cc: rafael@kernel.org,
	dmitry.torokhov@gmail.com,
	Shyam-sundar.S-k@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-acpi@vger.kernel.org,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ALSA: hda/conexant: Add headset mic fix for MECHREVO Wujie 15X Pro
In-Reply-To: <20260122155501.376199-5-550230171hxy@gmail.com>
References: <20260122155501.376199-1-550230171hxy@gmail.com>
	<20260122155501.376199-5-550230171hxy@gmail.com>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,amd.com,linux.intel.com,perex.cz,suse.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

On Thu, 22 Jan 2026 16:55:01 +0100,
gongqi wrote:
> 
> The headset microphone on the MECHREVO Wujie 15X Pro requires the
> CXT_FIXUP_HEADSET_MIC quirk to function properly. Add the PCI SSID
> (0x1d05:0x3012) to the quirk table.
> 
> Signed-off-by: gongqi <550230171hxy@gmail.com>

Applied to for-next branch of sound.git tree.  Thanks.


Takashi


> ---
>  sound/hda/codecs/conexant.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
> index 5fcbc1312c697..2384e64eada36 100644
> --- a/sound/hda/codecs/conexant.c
> +++ b/sound/hda/codecs/conexant.c
> @@ -1123,6 +1123,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
>  	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad/Ideapad", CXT_FIXUP_LENOVO_XPAD_ACPI),
>  	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
>  	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
> +	SND_PCI_QUIRK(0x1d05, 0x3012, "MECHREVO Wujie 15X Pro", CXT_FIXUP_HEADSET_MIC),
>  	HDA_CODEC_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
>  	HDA_CODEC_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
>  	{}
> -- 
> 2.43.0
> 
