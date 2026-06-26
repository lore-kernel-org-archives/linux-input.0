Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EEC3A9D80
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451753; cv=none; b=YkdF8v1dYBlcCIpdXJ6dCKZfcw3HZPmMNnJon76+XHkaQhmb9+W/GCZtYoHQr6ewvtYPajkmfbEcXknAwU/tAl4hmr/zEvLIISEhEKuhKB9DZzf6IFRnp9UeDebUH1BgytfcRhPSa3Y/fuARlXr5yP9lz/qtVQ4MABfWSNBu8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451753; c=relaxed/simple;
	bh=+dW+ifB+grAj3kpJq8Pl1AHCATMxxy5nP2z4QNaL4pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CUHczoFJ5M9JxivbQyK4by+R3GehwbuWZHuxgRgF8VfcxemSvL85XNCuir362QdWyyOSfSjznnx9wbAUXjyaOffBJBJlb1C7xsqVRzmNC6ZUA5fQgHjZcyxsrJiMasCvC6N/VdqnWMX2FegazH7CenUus16EczeUcZ45aCt1nlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0Z8LagT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0Z8LagT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FED01F000E9;
	Fri, 26 Jun 2026 05:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782451743;
	bh=/H7LEm3FEbabgHEnXyYt6a6BsNqrLXZgx9kuXDL/PhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k0Z8LagT51NKXMVqiJ20NcOEomWOwQ2TfNEvDtVRR9MyFJlcGRq29VFvka5a9KAf8
	 1CthTqnMDTXGLMiRcLThuw57TKoaT4mRwMXLyn8rWq3ufNJuur2AVI6WEGwUXbwxRx
	 u/NAOPKZ1ewIIMe5NYRi6Jr2LmNfgTeVO+ypv/3q4f7gra7sX7IeCQRgrzWg2cr79E
	 2EQb7Yo3k+42cIKGUdUKUAKJLHj3hIQSgi0Fw8VEr5pOXwg02hXiHxIWWZaWM7Qa/h
	 TmdIudifWdtXkggO4F00tlGmFm2L6K86w98g3+NAPKUp3+ufw+gIANvq3yqiRlwyKR
	 QVSXHIdRuv2Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] Input: synaptics-rmi4 - F54 style and typo fixes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260626051802.4033172-8-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
 <20260626051802.4033172-8-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 05:29:02 +0000
Message-Id: <20260626052903.1FED01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The newly added comments incorrectly describe the lock coverage for=
 `status_mutex` and `data_mutex`.

Pre-existing issues:
- [High] Embedding a `struct video_device` in a `devm_kzalloc`-managed stru=
cture causes a use-after-free on device unbind.
--

commit 7a52e1aa5971437b387ed577aeae2fd8da17b2ba
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: synaptics-rmi4 - F54 style and typo fixes

This commit cleans up style issues in rmi_f54.c reported by checkpatch.pl.
It converts bit shifts to BIT() macros, aligns assignments and arguments,
fixes typos, and adds mutex documentation comments.

> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index 93526feea5636..850e1742c480a 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
[ ... ]
> @@ -109,8 +109,8 @@ struct f54_data {
>  	int report_error;
> =20
>  	bool is_busy;
> -	struct mutex status_mutex;
> -	struct mutex data_mutex;
> +	struct mutex status_mutex; /* Protects is_busy and command state */
> +	struct mutex data_mutex;   /* Protects report_data buffer */

[Severity: Low]
Are these comments accurate regarding the lock coverage?

Looking at rmi_f54_request_report() and rmi_f54_work(), it appears that
is_busy, cmd_done, and timeout are explicitly modified while holding
data_mutex, not status_mutex.

status_mutex appears to be used to serialize calls to rmi_f54_buffer_queue()
instead.

[ ... ]
> @@ -709,7 +709,7 @@ static int rmi_f54_probe(struct rmi_function *fn)
>  	f54->max_report_size =3D array3_size(tx, rx, sizeof(u16));
>  	f54->report_data =3D devm_kzalloc(&fn->dev, f54->max_report_size,
>  					GFP_KERNEL);
> -	if (f54->report_data =3D=3D NULL)
> +	if (!f54->report_data)
>  		return -ENOMEM;
> =20
>  	INIT_DELAYED_WORK(&f54->work, rmi_f54_work);

[Severity: High]
This isn't a bug introduced by this patch, but does allocating the f54_data
structure with devm_kzalloc() earlier in rmi_f54_probe() lead to a
use-after-free on device unbind?

If a userspace process opens the v4l2 device node, and concurrently the
physical device is hot-unplugged or unbound via sysfs, devm will
automatically free the f54_data memory.

However, since the release callback for the embedded struct video_device is
set to video_device_release_empty, the v4l2 core retains a reference to the
embedded video_device.

Could it then access the already-freed memory during ioctls or when the last
file descriptor is closed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626051802.4033=
172-1-dmitry.torokhov@gmail.com?part=3D8
