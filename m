Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F63537C8;
	Thu, 11 Jun 2026 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186212; cv=none; b=PxTKGB+MgWyzzt0dEoR4ClO1+KodM4GW6uHtuhBq2Lfh36bWFWpV/UYMA3mG3mf1Bvtmq93OR6ENJWPGdWgOPPNKQrLA5xUnqRMrYPvB7QzyUlbD0zhrNnRmJDlFeYOlgRpqlxRJMtkLzZHkdBBD4G8Q6aUo+cF9RX06vDBlekA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186212; c=relaxed/simple;
	bh=POdxgzeWGK2Ev/f4v77k2E32vic/vsQWxbtI8d1XlE0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KONAwdttRuHn55/u+NqL9bTr9uwPWAh1p0yoUS06LVUSHEnXqv3tYkjfaxYmT1m/T9tP5F0ho7VDMcg98WiiwY4o3KRi1umx8kNHH+8RuFPnEN6f3doFGzuOiTFu8jQEl6Sw0LKuHXkiQ+mfYOjSWg2umaJrD+SrbjBpeEsHntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJ3my+Im; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ3my+Im"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59311F00893;
	Thu, 11 Jun 2026 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781186211;
	bh=cyi0akIBL0k09KI5FbRc8c7YcUsGAoBhl8Q9HwVcYN4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=NJ3my+ImkDJoPvUAgyLRomYX89mxIUueaAYMSpSG4PWaiVgKwjHedK3yMgz+0FI6r
	 VN7GLGVDFvrmoKV4nhcrCxmMYra1WkUHVLBL6jATgx51O5QphtAOwPkzPAttqFE3Gk
	 UrpX1dufNn+Tdn/V4dy2GvnOVpjBYbscalzkfIJGkp5gTqpAp31qCmB9LZQS8KOSAF
	 0pSoyHNQneThmNErf35t0hIL3LBgHTN2zmv+awaJGaJhXkEW6UkHZK/OEktu6PGPgN
	 BD0D1RWVw4TfnnWaZOgjByOzZRtqLDEiwhxUuUq3LAA6rDf4qeU/x4zAb5WywZmTFG
	 DpxCQ5qSj+I6A==
Date: Thu, 11 Jun 2026 15:56:48 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Lauri Saurus <saurla@saurla.com>
cc: linux-input@vger.kernel.org, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: sync wheel multiplier on wheel mode
 changes
In-Reply-To: <20260518192649.245691-1-saurla@saurla.com>
Message-ID: <o3934r99-81sq-4327-8p15-s982sp59on9p@xreary.bet>
References: <20260518192649.245691-1-saurla@saurla.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 May 2026, Lauri Saurus wrote:

> The hid-logitech-hidpp driver enables high resolution scrolling on
> device connect for capable HID++ 2.0 devices. Driver also reads the
> wheel capability and caches the returned high resolution wheel scroll
> multiplier, that is used for scroll scaling when handling wheel scroll
> events.
> 
> Wheel mode can also be set externally through HID++ requests, which
> can leave the cached multiplier stale and cause incorrect scroll
> scaling. If external SetWheelMode HID++ request sets the mode to
> low resolution, the cached multiplier is not updated accordingly. This
> causes extremely slow scrolling since driver expects multiple wheel
> scroll events per detent but is only getting one.
> 
> The fix listens for HID++ SetWheelMode request responses and updates
> the wheel scroll multiplier based on the set high resolution scroll
> mode. The fix has been tested with Logitech G502X lightspeed mouse.
> 
> Signed-off-by: Lauri Saurus <saurla@saurla.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

