Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05D30DD2F
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786145823; cv=none; b=HJrAxgW873V3n1AXAa5skkCTJX/w6D2Hwszo6FpD+0xBHtMP2jynRmx5eT2HstkN6OXwdz1CxiTC3rfL68oBsN3oUnDw2DhO1SlmmZGox3Q2b6B5PfiyuKKqsCt8U6Gzj28ifiImlNETCTs4qhCiqyAlEvd84Bvv/valfg7AAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786145823; c=relaxed/simple;
	bh=U0Cx3V6gWmm50GpuFPQ3kVyIqJBqHRhtZU/0e5NH7sY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ok87zQWqSh1NvQoRnIFydep8c5vnzC1l4F+D/p9DWCFl4Uw80UOuRDpf4YNL34baQkmMXSHJR2lBlXlslsmlLD29zxFrAE+2TIMe6KTT6elC+FZ+TXTb6kirX7rl0sTZx2uXUtv1bipS2r4xgrWqFPYDOclbIo4DJCO20wQ8+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocFdBYGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocFdBYGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37EC1F00A3D;
	Fri,  7 Aug 2026 23:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786145821;
	bh=NweuAsxaHlqIrygrJarlBRseEoZfeg35jvhAQK8xDjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ocFdBYGmalVQvq+Yj1jEKWVGiidrCNkFYZIyRPnBo/jP797TeQRAzM4VrXFuvCh4w
	 huwCki11y07wEgOS/5tbl9BEfETenZcR0BLo0y4y4lC38fs5Q+VC6IRxfcuQTDs+eb
	 rTVtXK6AYQyfTD7NcfySxkKUVyZ/7CtXffyhpZaURyYUsDitpBdXfrd4Wti7j1kcs7
	 oGo3xt+a3JoNctRIL6AA0OsVgCdbGlhP4iBaz+i7yprytHD/VwUrcMbjEXu56iJWkZ
	 FKCI+2vWY/Wc9JBMsavDqjYo78MRqWYwjQGhT1fQ6OSP9n8yOI6Tm3XTI6X0nxmaLG
	 6FycQuo447vHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] HID: steam: Refactor registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260807232339.2799205-2-vi@endrift.com>
References: <20260807232339.2799205-1-vi@endrift.com>
 <20260807232339.2799205-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 23:36:59 +0000
Message-Id: <20260807233700.D37EC1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free of steam_device due to orphaned work items on devic=
e removal after partial registration failure.
--

--- Patch [1]: [PATCH v4 1/6] HID: steam: Refactor registration ---
commit 2f71fd5dc6effb1149cad5cc15145d4c5b501691
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Refactor registration

This refactors and simplifies the registration/unregistration flow, replaci=
ng
the previous assumption that a serial number means the device is registered
with a single purpose boolean, and fixes a power_supply object leak on error
paths.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -1149,66 +1147,60 @@ static int steam_register(struct steam_device *st=
eam)

[ ... ]

>  steam_register_sensors_fail:
>  	steam_input_unregister(steam);
>  steam_register_input_fail:
> +	steam_battery_unregister(steam);
>  	return ret;
>  }
> =20
>  static void steam_unregister(struct steam_device *steam)
>  {
> -	if (!steam->serial_no[0])
> +	if (!steam->registered)
>  		return;

[Severity: High]
Could this early return cause a use-after-free of the steam_device structure
if steam_register() partially fails?

If steam_register() successfully registers the input device but then fails
during steam_sensors_register(), incoming HID reports processed by
steam_raw_event() can schedule the mode_switch delayed work during that sho=
rt
window.

The error path in steam_register() unregisters the input device but leaves
steam->registered as false without cancelling any scheduled work items.

When the device is later disconnected, steam_remove() calls
steam_unregister(). Because steam->registered is false, it returns
immediately and skips cancelling the work items.

After steam_remove() returns and the steam_device structure is freed by
devres, could the pending delayed work fire and dereference the freed point=
er?

> =20
>  	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
>  			steam->serial_no);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807232339.2799=
205-1-vi@endrift.com?part=3D1
