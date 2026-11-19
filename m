Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123260;
	b=5UZjed+xEbSHJ7T1KN6unJ1e28KK/5ogxNcULAHxSLcmX+4Xl92Q4G9PTDo8M2ufJmp9
	 KlYwH6gg5x4tGS/Qo8MCJaLuXqoZff9r4oM+aIcXsQwnOgspDk5K+q0uqk+MUonm1aga5
	 yuf0+ema63vahYrdDeQp8729nMFAodAvatmyOkM+knv0O4DEs1ZRbdesMqZT6m0XC52Lg
	 sfxHWlBWZ1ILAzv8o2PF5LQgBD3JeqkdFmHSX064r57E8ajWYrVbA93KkS0sS8xwHk/M8
	 Umj7cy3v2BF1fBEQ7ZM7nqFWDPL3Lnbw7LqjKgNQtPBOuYX8AFxRG5BkBVAS+hq4VEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123260;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=LjFXNbRYvfz7g4AlGOy0meL3oIZPgh5wE9oNSaKPl9Y=;
	b=bNC2dAJXQZQq4qJ2jBCMtFNHHPm2cQ3WS01wYteHtm0vKATXbCThQQEfjQCwZSQnMELz
	 MqXPhChsz/GCnyAjV8iSz7nNZ/9ayol1yb/F1CRem6E5sU/SdCJinbZSsjUdXniAd+nhj
	 /ekG5wpCYvXqdMhqMPtJMh8eJpuZu4EN0gQ29KdkFinbfc2DUpMRtp/kFmzjBh3azHQwJ
	 YDOrM6Ez+srVqGZFoUJNCFcpnhpr/Hh9bs+baCba7in6Q0xLKMuRB4v9x0ItT5zoKLVFR
	 l9sUGuvN1Hno3ruO/vn7Byp9gpkH4fkuLRKHHTpxicD8oIcHHP8OCy3Mgr5E6yUW9IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpRAWXHM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D437606A324;
	Thu, 19 Nov 2026 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpRAWXHM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824A51F000C0;
	Thu, 19 Nov 2026 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795123260;
	bh=LjFXNbRYvfz7g4AlGOy0meL3oIZPgh5wE9oNSaKPl9Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=mpRAWXHM9I4yqlNZkC4oMlWY1etE93gukD8LoveZjTLAt+kft8aC5S99cWX2nboq1
	 Qoo0iyxtZ8ENpQYmKD+gcBcTHLprYEMAL9tS1c7Cu5kFAiwTgBQv7l3zEQkNyUMFUT
	 0WVAwRYWx65cRDg2DSQsDosoztSSBgBM8lFXk2FDXNTT6+PCF5PKMo9a+bEIhk+IzB
	 dr3EHANiBnnq+4eZRE/PRl46ak0rAQApahp/nrFzg/Y5sC9zCvcmBXnNbb4rMCq959
	 5yJMbBAoqIt8tFbaKY/rxVlkyY2tlh82r4ZFeJAv+5wN4Z/u85btHMU0ilbNzhG+JC
	 WAwwTTUMFQ0Ug==
Date: Thu, 19 Nov 2026 22:20:57 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Lukasz Leczkowski <lukileczo@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: add ALWAYS_POLL for ASUS ProArt MD301
 mouse
In-Reply-To: <20261113-hid-next-v1-1-864859cc8fb4@gmail.com>
Message-ID: <000rp3s0-5s4r-84o1-918s-6r4rns491q2p@xreary.bet>
References: <20261113-hid-next-v1-1-864859cc8fb4@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 13 Nov 2026, Lukasz Leczkowski via B4 Relay wrote:

> From: Lukasz Leczkowski <lukileczo@gmail.com>
> 
> In mouse firmware version 0.00.31 and receiver 0.00.20, the receiver
> of the ASUS ProArt MD301 mouse (0b05:1cd3) delays button events
> by up to ~500 ms.
> 
> The receiver exposes five HID interfaces. Besides the keyboard and mouse
> interfaces, interface 4 (vendor usage page 0xffc1) carries a copy of
> every button and wheel event as a 64-byte vendor report. As this
> interface has no input handlers, usbhid does not poll its interrupt-IN
> endpoint unless userspace opens the hidraw node. The firmware appears to
> hold back the mouse report on interface 1 until the vendor report has
> been read or some timeout expires.
> 
> Add HID_QUIRK_ALWAYS_POLL for the receiver so that all of its endpoints
> are polled continuously.
> 
> The issue was analysed with the help of Claude Code (Claude Opus 5.5),
> which captured the raw HID reports, identified the unpolled vendor
> interface and drafted this patch.
> 
> Tested on 7.3.0 with this patch applied;
> clicks are delivered immediately and double-clicks work again.
> 
> Signed-off-by: Lukasz Leczkowski <lukileczo@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

