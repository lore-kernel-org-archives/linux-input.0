Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597934040D
	for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789858327; cv=none; b=IGJU2+Zy8Wh7JmU2dDQo4ki1eGddAMiN3kWyeNzAu8by8ZsmnKxyEJjaBtFQ60pmKaU8x3XRAHehoSH3gCNGSXHrWSAghaAniocSTMoCKIZCl2S2ZE/qJS/2aP3NBgp3O7xo1oMYiYPEifFg8AnUsjchn63wzN5RROEnPS3dHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789858327; c=relaxed/simple;
	bh=/3e7pEb1Ry4OQ89RHAjhOAOlPu3sm1fJ6UBJj38yI0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mU9894FXYL5dGna+AmpKMqjJhpH1QuGhSIii8uEF7g45Hx9YmlJBqVlbEgd9jzhtM1UZwsqTkAW+WuJ6ivVkKW2C+RWudD4AOYhUy1AIgnHgMh7UffEXg2a6JXd2jRLIcXS2z1pULQ+trfmg5RHM01caxD0+WCtUzU5NmjvAFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1D6A0Wn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1D6A0Wn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43191F000FF;
	Sat, 19 Sep 2026 22:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789858325;
	bh=VSSTxITpUWvWNAxjWvm2I8+gLWkOVIP8XcTsfe65lc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H1D6A0WnpAzNF3AtQ8s5tqSoIBxjfXc/82h6f6T7GC4zKql4TI6hnW74xKDuPCCqn
	 TWGo1SQRUT4w+2cgQMhuPRdkt3goAOhx8JogjBtAnAKN5SR2NTtCbE9Yyrz47QBUiG
	 EEVE2PCIlWKOlzOnlsLvdoDeRE+VNtmMj596e81g3w2XtX0LAA4d6TpeJT5pY7m47B
	 kIHc4Ib3Zet021LGzmIFirYhEfuWdIdgaGMT3WwOuxLBjhUI6w5AftANfR49ZOilSu
	 pt7QfQimtyGgtHslq18uRiLoLthFEqv0a1n3DvNiqwxUUY+4zUBNmzw8UsWTOdPcY7
	 qc2giLUnU6wLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: fix sony Rock Band 3 IRQ sleep and
 hid_debug_events_read() UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260919222630.3798292-1-benquike@gmail.com>
References: <20260919222630.3798292-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:52:05 +0000
Message-Id: <20260919225205.A43191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: commit message and code mismatch
--

commit e51431362491e22e949d7055095af58151300ef8
Author: Hui Peng <benquike@gmail.com>

HID: fix sony Rock Band 3 IRQ sleep and hid_debug_events_read() UAF
   =20
This commit aims to fix two issues: deferring a full-report feature
request in the sony driver to avoid sleeping in interrupt context, and
preventing a wait queue leak in hid-debug.

> Fix two issues in drivers/hid/:
>=20
> 1. In sony_raw_event() (drivers/hid/hid-sony.c), defer the Rock Band 3
>    Pro controller full-report feature request to sony_state_worker()
>    instead of calling hid_hw_raw_request() synchronously from interrupt
>    context.
> 2. In hid_debug_events_read() and hid_debug_events_release()
>    (drivers/hid/hid-debug.c), remove list->node from hdev->debug_list
>    under hdev->debug_list_lock before freeing or when hdev is unbound so
>    hid_dump_input() cannot access a freed debug list entry.

[Severity: Medium]
This isn't a bug in the code, but does this commit message accurately refle=
ct
the patch contents?

The code does not appear to touch hid_debug_events_release() or=20
hdev->debug_list. Instead, it fixes a wait queue handling issue in
hid_debug_events_read(). Furthermore, the sony fix introduces a brand new
worker rather than using the existing sony_state_worker() as claimed.

Could the commit message be updated to match the actual code changes?

> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index f44e6e708404c..edc45ca9e024e 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -3728,15 +3728,14 @@ static ssize_t hid_debug_events_read(struct file =
*file, char __user *buffer,
>  				break;
>  			}
> =20
> -			/* if list->hdev is NULL we cannot remove_wait_queue().
> -			/* if list->hdev->debug is 0 then hid_debug_unregister()
> -			 * was already called and list->hdev is being destroyed.
> -			 * if we add remove_wait_queue() here we can hit a race.
> +			/* if list->hdev->debug is 0 then hid_debug_unregister()
> +			 * was already called; break out of the wait loop so
> +			 * remove_wait_queue() is unconditionally called before
> +			 * returning.
>  			 */

[Severity: Medium]
The patch comment here in hid_debug_events_read() correctly describes
breaking out of the wait loop to call remove_wait_queue().=20

However, the commit message mentions removing list->node from hdev->debug_l=
ist
in hid_debug_events_release(), which isn't present in this hunk or the rest=
 of
the patch. Is the commit description perhaps meant for a different or older
version of this patch?

> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 50f5ad6bbeb4c..d3862ddf68c91 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
[ ... ]
> @@ -657,6 +658,14 @@ static int rb3_pro_instrument_enable_full_report(str=
uct sony_sc *sc)
>  	return ret;
>  }
> =20
> +static void rb3_pro_poke_worker(struct work_struct *work)
> +{
> +	struct sony_sc *sc =3D container_of(work, struct sony_sc,
> +					  rb3_pro_poke_work);
> +
> +	rb3_pro_instrument_enable_full_report(sc);
> +}
> +

[Severity: Medium]
The implementation here in drivers/hid/hid-sony.c creates a new
rb3_pro_poke_worker instead of deferring to sony_state_worker() as claimed =
in
the commit message.=20

Should the commit message be updated to reflect the use of this new dedicat=
ed
worker?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919222630.3798=
292-1-benquike@gmail.com?part=3D1
