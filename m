Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722F83043B2;
	Mon,  3 Aug 2026 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782644; cv=none; b=AvjWHeqad+PtnDLbXezBhMFlO7y3arEqT5bX2fYPJY2kkHf/q2LzOHD6jcdxou86QuZ++5EuT/kzSruZ/rTiTujxYO3NTB97P3AMXOgQ8i5a2fIl88reJMJ7J752WrdOn3FRhDjbt4Uyw5jor5+rxDNMnatv1QDvsebnrVRgFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782644; c=relaxed/simple;
	bh=nUBe5VfcvwGTspyYDq0qSC/Bmy8yFjIqUizoaQLxb1o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Lwy0ZuqykKiia2JPv6kx56jE/LfSlxcZ6/mGSObmZHY1+xemyPf9F5gklO7NbKHdnYATdpEHCbY9NORsvvMlM0aVvs461tFuu3ngnGYhJ4jYHRDTrEaAxGOJuiyswFHc2mbJPP+DEfwWChlgvBXN1m1LOZDg95MUvFlAoCErV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByntwvNe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByntwvNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8B21F000E9;
	Mon,  3 Aug 2026 18:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785782643;
	bh=E4nLWJl0fbLFG4JrGq+SqD8LcCS4dPAFAqFkzfmRX3s=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ByntwvNehPigwKqjmnBWiknNYcIVo++/HESU3GIzEOgSYbg77XzQcWAWB5tNTDI8T
	 EFWgZ3ZKQivXVqZr6b0gO31z4IZw2gIaFbfpDqbBtD9Kdt+CZq67tqe//tZvSLlB/f
	 tePpE+XaAJHePf/3V6vntqYPTPKry/2z8ZvHNA5wap0c/TgfgsMHZjvJsjwhO5xU5U
	 oJrjC2gzYusBwKcyOrWiHpKaGH7BMcCMCBkGpJD/QqWkAqXkN6TKSyVCk1FV/3GVAj
	 0mpWV96nYCDpePRCu4w6J5Ye1YuHh84GZnU/ZGDE7/K28AcmOPFyKDu32wwLw3iHpv
	 JdXz6nf++I1QA==
Date: Mon, 3 Aug 2026 20:44:00 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Michal Slustik <michal.slustik@gmail.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple: Add Endorfy Thock TKL Wireless to the
 non-apple keyboard list
In-Reply-To: <20260705185052.1539976-1-michal.slustik@gmail.com>
Message-ID: <431988q4-775s-7959-2r85-16661189ns93@xreary.bet>
References: <20260705185052.1539976-1-michal.slustik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 5 Jul 2026, Michal Slustik wrote:

> The Endorfy Thock TKL Wireless uses the same device ID as an
> Apple keyboard (05ac:024f), but its F1-F12 function keys do
> not work correctly by default.
> 
> Adding two entries to the non-apple keyboard list:
> one for Bluetooth mode, identified as "Thock TKL Wireless"
> one for 2.4GHz wireless mode, identified as "USB Dongle"
> 
> Signed-off-by: Michal Slustik <michal.slustik@gmail.com>
> ---
>  drivers/hid/hid-apple.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index bf7dd0fbf249..0bd1af58d837 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -368,6 +368,8 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
>  	{ "TH87" },			/* EPOMAKER TH87 BT mode */
>  	{ "HFD Epomaker TH87" },	/* EPOMAKER TH87 USB mode */
>  	{ "2.4G Wireless Receiver" },	/* EPOMAKER TH87 dongle */
> +	{ "Thock TKL Wireless" },	/* ENDORFY THOCK TKL BT mode */
> +	{ "USB Dongle" },		/* ENDORFY THOCK TKL dongle */
>  };

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

