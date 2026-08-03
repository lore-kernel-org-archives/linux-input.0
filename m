Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA243801A;
	Mon,  3 Aug 2026 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785964; cv=none; b=T1HZa1uOYNB9MpFTHXzrfSq3vu4QW7HkKYNE+INbA/qIfzc1Zvy2Kg5CoI/deVjAEp2jL+X2Rfbze6n/WrXbhcMqSBmZxd5gipMEU3xFUVg7XdBR0mtKwxEiw8mbkaimgUSgQJaGzygc9pzGP/+pAp4CoOMuBIybrr9WedZ8Pgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785964; c=relaxed/simple;
	bh=ROk4ZK+mVYNxjt2SjDmpc8E/4Ix/pcOE+RKyG1ee6rM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ichtvZJmE8v/B1d658GeatPAhTIqIx2YIalGGeNjf5sW7poIN5EYN+yi7CVBDN22zxgtFIUNVzv9HYe/8ZdkWQGZf3jRZqLNDBEP2hII4CWoYY3vQjtrOQzZKi2JdWZ+jQ+nB0lqYRJ/FYpBjrxefpDrQ+FB7F6Ej3PLz+ZG+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao2fKIjz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao2fKIjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5791F000E9;
	Mon,  3 Aug 2026 19:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785961;
	bh=0pvR+uJ2dU0rkg4zrDNrKNU44U8YxGgcV4P0kom9zNM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ao2fKIjzMqlAFO4vvGHlUWdMTkuLONBOHWJlisJQoIgQt8jjmuzMOhsMOBjNuyt2n
	 25c9xYPci7BD2WKAcV9bmes2afAiBuhNRC9LyWBt0NhrAJKOGlp0gQBGaKq6I8oflB
	 V2zCPi83o7dTvwgyICzpABo+Fyx5CaDqevlK/SoWDph6IPAIwIAUwu4OrjerqNxZ8l
	 +DN8LJrg8GkJoHntz9TC2V4A5L19CkGelgpgqbI3hN2eYDPdx0nV8wOhzL6+RTV2KU
	 N+Gbk53ZVOII3O1aQQBnZRqBpyfPj8AWiYYxCX4oCMAMQvE58rSJJwUn07lmb9gX10
	 JR04z9xOks7bQ==
Date: Mon, 3 Aug 2026 21:39:19 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Blume <benjaminblume@posteo.de>
cc: linux-input@vger.kernel.org, bentiss@kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hyperx: add driver for the HyperX QuadCast 2 mute
 button
In-Reply-To: <20260713124200.564126-1-benjaminblume@posteo.de>
Message-ID: <9064qo6p-078q-7s16-8s9q-8q434qq4559p@xreary.bet>
References: <20260713124200.564126-1-benjaminblume@posteo.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Jul 2026, Benjamin Blume wrote:

> The tap-to-mute button of the HyperX QuadCast 2 (03f0:07b4) is handled
> entirely in the device firmware.  The firmware gates the audio internally
> but never sends the Telephony "Phone Mute" usage (0x2f) that its own report
> descriptor advertises, and it does not touch the UAC feature unit either.
> Consequently neither an evdev key event nor an ALSA mixer change is ever
> generated, and userspace has no way to learn that the microphone was muted:
> desktops keep showing the microphone as live, and conferencing applications
> keep displaying an unmuted microphone while transmitting silence.
> 
> The mute state is reported through a vendor-defined collection instead:
> 
>   06 c0 ff        Usage Page (Vendor-Defined 0xFFC0)
>   a1 01           Collection (Application)
>   06 c1 ff          Usage Page (Vendor-Defined 0xFFC1)
>   85 77             Report ID (0x77)
>   09 f0             Usage (0xF0)
>   75 08  95 3f      Report Size (8), Report Count (63)
>   81 02             Input (Data,Var,Abs)
> 
> Pressing the button emits a 64-byte report on that collection:
> 
>   77 06 00 00 ...   microphone unmuted
>   77 06 01 00 ...   microphone muted
> 
> where byte 1 identifies the mute event and byte 2 carries the resulting
> state.  As the payload is an opaque vendor blob carrying no HID usages,
> hid-input cannot map it and a hwdb entry cannot express it either.
> 
> Add a driver that decodes the report and emits KEY_MICMUTE, which makes the
> button behave like any other microphone mute key.
> 
> Note that the device reports the resulting absolute state, whereas
> KEY_MICMUTE is a momentary key that userspace acts on as a toggle, so the
> driver emits one keypress per state change.
> 
> Tested on a HyperX QuadCast 2 (03f0:07b4).
> 
> Signed-off-by: Benjamin Blume <benjaminblume@posteo.de>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

