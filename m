Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567344C66B;
	Sun, 11 Oct 2026 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723431; cv=none; b=EKJm6aQqfgMsx3unSTxjdsFGzKKitqVURY4evQnDc/S9EQrGQSPLxx0BmNCjfeR1e+8OQAYG65uwmzmF9s3tl9rmxxgAP2gxQVeXKYs220Oj6Ej52lRqiBm1oaz5TL1HdmMuBYk54cscfXhErUhn6CrAbvGaFk3SkxItEdlgIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723431; c=relaxed/simple;
	bh=UewO25v2+KHh6lZYktE6joFs5kyAGdzQIYXQSJvLsds=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PMMsYdRmq6j4oJmRZ1ffNtJKplzklnVYoKDYDVRKe7DfJci12+jfhVNENv86+Z3FWyK2JLQdTIRcATrQvCTck9TaoMMMeQLaIZRKsKzxRqKYSdciG+Cn1pvakzurcp+/kwj8Up6msTkk1EHqD0DmPGYl3NwcAYkBc0wG5u2TYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR+Y/XjX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR+Y/XjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32C31F0089B;
	Sun, 11 Oct 2026 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791723430;
	bh=eWw/OXt8sQQa5wBXzZsoENxWu+zzw1hSdtYf6U0eWHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WR+Y/XjXlgBjAJM/OycmJ3CmCujCgUWY3KbuGIxvNeGJhO1QiYWqIhXsAjIvSNA2c
	 XSPq17p/ribXPUPEcV7J3poHbTU7Px6GsblfPJW1pwmtKjeiyYqrZTe52wOh0/nCci
	 mAoQypdXnLSw/jqaE3/UI8GQmO6xPr/l47rQXG9PmmKAOyQJVXcp4yc8DLmHaZYVqz
	 7ahFyuDkzhAcRULPCMUf1Me7GChBgU57Kll0cefdSb9t5SHzSJVOCbadTUd/t5H+Di
	 gj3nCXKR0EklTVbcGDN9JqBF4txiMVgdTgcNmmprp10U0m3G2Fpkl4TiYJLzOQdct3
	 LWFIIl9vJE/Lw==
Message-ID: <sashiko-outbox-167232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] Input: s6sy761 - split into core and I2C modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Timmermann" <foss@timmermann.space>
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261011-lat3st-google-raven-touch-upstream-v1-2-2a9f55159b9e@timmermann.space>
References: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
 <20261011-lat3st-google-raven-touch-upstream-v1-2-2a9f55159b9e@timmermann.space>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 12:57:09 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] i2c: missing named initializer for struct i2c_device_id array
--

commit 51d3d608cec412c03a6a7e8a8664d2c06b76fa92
Author: Lukas Timmermann <foss@timmermann.space>

Input: s6sy761 - split into core and I2C modules

This commit splits the s6sy761 touchscreen driver into a bus-agnostic core
and an I2C transport module in preparation for SPI support. It also adds a
mutex to protect the shared transfer buffer across threads.

> diff --git a/drivers/input/touchscreen/s6sy761_i2c.c b/drivers/input/touc=
hscreen/s6sy761_i2c.c
> new file mode 100644
> index 0000000000000..b5cbebfd722a8
> --- /dev/null
> +++ b/drivers/input/touchscreen/s6sy761_i2c.c
[ ... ]
> +static const struct of_device_id s6sy761_of_match[] =3D {
> +	{ .compatible =3D "samsung,s6sy761", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, s6sy761_of_match);
> +
> +static const struct i2c_device_id s6sy761_id[] =3D {
> +	{ "s6sy761" },

[Severity: Low]
Does this array declaration intentionally omit the named initializer? The I=
2C
subsystem guidelines require initialized arrays of type struct i2c_device_id
to use named initializers (e.g., { .name =3D "s6sy761" }) to remain robust
against layout changes. It looks like the named initializer was present in =
the
original code but was dropped during the driver split.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, s6sy761_id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-lat3st-goo=
gle-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space?part=3D2
