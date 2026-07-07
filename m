Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4564C81
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783468026; cv=none; b=cAobfcjCG8b6r4Y5N+bOZK1eoVC47/VuuupdecoVbixZzvjOVjuX5FcmiG3oEBHcH6ie3azJ+N1tFS6mo1JfHqSlIv1op68q70s7G4GFWZ6kbaOa4tIpR8ZgqedrSrKtvHqHznXXtU2P9SVT8mkOX+lu1/ZVXE86FT2ieYSiaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783468026; c=relaxed/simple;
	bh=ignQHC1bTWQGE3F/lIDQJ6AG+j1/RPWHQ9OwI7YI9ys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Go6PV9rKthfDZVUNvTJwjdqbi/nzB5mr0DpO5TEvX1psWuq7z06ksGKQp20auXt7c2Hpl78AsTjgQ6BC9K+sMj0uZORBQe5kEOrU6erjCvlJJF7apV3sdbiaKs91+7bzux/tL53gPRBnNBEhb1vipzjeMGdVw7DXiE3esBseQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2Ls0XPd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2Ls0XPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9211F000E9;
	Tue,  7 Jul 2026 23:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783468024;
	bh=D2q8fUrXjYZdXuUWxUgwtFRziPcuoeY1JNQkkkbhUO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P2Ls0XPdGcC+a6ZPNpC7NwfTIDL/uzsF6krCoP4YRCQcz1zYSDi5MSZnZhh+cLaFh
	 ILK4V42/DZ5NsdExqfO99WuElL7bQjd6MNGrgx9y/AWsE6XmbFJKEc8Ljyi9PyE5da
	 0smcnQshIrlWc0Ro9SBG6LvXpwBBZ9Z1qx98ssKZJ516l87EtlcZWBYOy34YFrMvBa
	 Y07bdffU5G422dhieSsD4RV0Wze9mKYSrklrZcdZPx5T90ZLrsPuyx1gNcRsYxSdc0
	 iaD3sMQQDdxES1mBfpeiGKVDkaYdI+sg6l+4zSBdWs4TPoHWWaLmpFgebwCEm3Igo6
	 omU8Eit4WZSkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] HID: steam: Reject short reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260707233241.2644971-10-vi@endrift.com>
References: <20260707233241.2644971-1-vi@endrift.com>
 <20260707233241.2644971-10-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 23:47:04 +0000
Message-Id: <20260707234704.AB9211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Out-of-bounds stack memory read in `steam_recv_report` when logg=
ing debug information.
- [Medium] Uninitialized kernel stack memory read on the error path for sho=
rt reports.
--

--- Patch [9]: [PATCH v2 09/10] HID: steam: Reject short reads ---
commit ea3743d28300ad972f70af0939882012d7dbf763
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Reject short reads

Steam Controller FEATURE reports encode the size of the message in the
message itself. Previously we were trusting that the size reported matched
the size we actually read, leading to a potential issue with short reads.
Instead, we should actually verify the length of the read.

Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D75f3f9bff8c510602d36

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 1f2cf15d40831..49f6733d89359 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -380,8 +387,10 @@ static int steam_recv_report(struct steam_device *st=
eam,
>  			buf, hid_report_len(r) + 1,
>  			HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>  	if (ret > 0) {
> -		ret =3D min(size, ret - 1);
> -		memcpy(data, buf + 1, ret);
> +		/* Remove the report ID from the return buffer */
> +		ret--;
> +		size =3D min(size, ret);
> +		memcpy(data, buf + 1, size);
>  	}
>  	kfree(buf);
> =20
> @@ -389,7 +398,15 @@ static int steam_recv_report(struct steam_device *st=
eam,
>  		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
>  	else
>  		hid_dbg(steam->hdev, "Received report %*ph\n", ret, data);

[Severity: Medium]
Since the clamping of ret to size was removed above, ret can now be larger
than the caller-provided buffer size.

If a caller provides a small stack buffer (e.g. 25 bytes in
steam_get_serial()) and the device returns a larger report, will hid_dbg()
read out-of-bounds stack memory from the data buffer when dynamic debug is
enabled?

> -	return ret;
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret < 2 || ret < data[1] + 2) {
> +		hid_err(steam->hdev, "%s: expected %u bytes, read %i\n",
> +				__func__, data[1] + 2, ret);

[Severity: Medium]
If the device returns a short read of 0 or 1 bytes, memcpy() copies less
than 2 bytes to data, leaving data[1] uninitialized.

Since hid_err() arguments are unconditionally evaluated before the function
is called, could this read uninitialized stack memory from data[1] if
ret < 2 evaluates to true?

> +		return -EPROTO;
> +	}
> +	return size;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707233241.2644=
971-1-vi@endrift.com?part=3D9
