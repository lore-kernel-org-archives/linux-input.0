Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEDA4F7CD0;
	Wed, 30 Sep 2026 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775156; cv=none; b=Hmpzg0vTntFNtBHw5iXDuripKGraTxax/QecbDSyjjdgb+9Co6InUCMfBwP0/ZkjIKfWPWgk6RvO74CxShHcBNzeM0X5TNP4RIlaj4G+4b1bw8uTWuSuhcw/BLvnTq1z/lTbmFeaXWm0T7zf4CqTrPAYm9k1X15f5sQluXAJsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775156; c=relaxed/simple;
	bh=6hb/tPJ7DhHXdlmul/1HJRfk5L+oRj0/xkGd7ZhRMPk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PL54qV5knTBJVcWFkLr9lN86AHj+rJdcatfHbuVq1Sj2/krftltcZdi2aoSpM15QOPKCB04UbJE3IGhvTVUinloAnibw/Zaa33fxSmPSR11LxEF6ngZyxgW400f9i5mOu31rbDGy/+f8sTuShePuEj4zT7AyQ6mU0mygeMx54JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XhFaxEdC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nCbe06t6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dM+pXVr/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UaGfIhVP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XhFaxEdC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nCbe06t6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dM+pXVr/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UaGfIhVP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B628F1F88D;
	Wed, 30 Sep 2026 13:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790775138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UxK1d4HaGUUyPpZHlmzgvBtkpg7iUqMkulGQXtXd25c=;
	b=XhFaxEdC4McVpkMnvipuC0DFdw3Rj0iE63OvXRcXYMIRey6Ex77+ZRdVXa5X+6VPRsMuBT
	9+DpqWYV9WVIL8l6XQ9uKun1xehwdjkel1j/gmhf9om2bV8WtOjYBfG5dokDm6LAC6wg+j
	u72dxDqpqlq++rIOwxxoT3YopyCQiSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790775138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UxK1d4HaGUUyPpZHlmzgvBtkpg7iUqMkulGQXtXd25c=;
	b=nCbe06t6doGsrdlVFvM2APDm60fljt+5zpKJL1XWzgTOYp9LY5YZlfGjXDbY2CW+SGgitc
	yilbZZtWFAz998DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790775134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UxK1d4HaGUUyPpZHlmzgvBtkpg7iUqMkulGQXtXd25c=;
	b=dM+pXVr/owWOXbFjEmz03+rVd4ZsghRQ1lq2blslBhiinoBfH5F+YW+p/guPnvwsReAuM4
	AQHdje5q3qBmD1NM1mTK+wz43WXh4m9PwGfDmdRMoBSvrKIONxjXGt+HwUeNZiLVbhXd/I
	qNNh98QIEZp42WBlRHJsIhaRaxSHD8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790775134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UxK1d4HaGUUyPpZHlmzgvBtkpg7iUqMkulGQXtXd25c=;
	b=UaGfIhVP3mauG+I9casw5dXI9cbDcZ2+86ydEZSTX8eDpY21p2kxyZgF+fU8ibi0ocnHnu
	oHgKiwIASvRwbgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53CE013722;
	Wed, 30 Sep 2026 13:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TIppCl4PvWoTOgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 30 Sep 2026 13:32:14 +0000
Date: Wed, 30 Sep 2026 15:32:13 +0200
Message-ID: <87mrsy50gy.wl-tiwai@suse.de>
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
Subject: Re: [RFC PATCH v6 0/2] the Topping M62's vendor controls, on the component framework
In-Reply-To: <20260929172902.210581-1-mikhail.v.gavrilov@gmail.com>
References: <20260904165848.3940603-1-mikhail.v.gavrilov@gmail.com>
	<20260929172902.210581-1-mikhail.v.gavrilov@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 

On Tue, 29 Sep 2026 19:29:02 +0200,
Mikhail Gavrilov wrote:
> 
> Hi Takashi,
> 
> A gentle ping on this. The problem is unchanged: on Linux the M62's
> preamp gains, output volumes and source selectors can only be set by
> hand on the front panel. v6 is the component split you suggested; v8
> stays posted as the alternative.
> 
> Since posting, v6 has run on the hardware as sent: all nine controls,
> panel and ALSA following each other, fifty module unload/load cycles
> and the cable pulled out mid-write three times, under KASAN and
> lockdep. Nothing in the log.
> 
> The one wart in the cover letter is worse than it says. Reloading the
> HID module takes the controls off a live card and puts them back, and
> ALSA reports that correctly, but WirePlumber does not merely lose its
> faders -- it segfaults. That is for WirePlumber to fix and an issue is
> open there, but it is a cost of this road that v8 does not have.
> 
> One thing points the other way. The card also reports its battery
> level unasked, and the natural home for that is a power_supply with
> device scope, as hid-corsair-void does. In a HID driver that is a
> small patch on top; on the v8 road it would have to be registered
> from a snd-usb-audio mixer quirk, and I cannot find anything there
> that does so. I have not written it and would like to know the road
> first.
> 
> So the question is the one from the cover letter: this road or v8?

If the implementation with the component works actually, I'm for it.
So, from the audio side, feel free to submit patches for upstreaming
without RFC.

> Jiri, Benjamin: the needs_remote_wakeup question is still open --
> whether clearing it after hid_hw_open() is acceptable, or whether
> usbhid should offer a way to take input reports without it.

There is a question which tree would take, too, but let's clarify the
issues in HID side at first.


thanks,

Takashi
