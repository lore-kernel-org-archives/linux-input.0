Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D8F9475
	for <linux-input@vger.kernel.org>; Sun, 27 Sep 2026 04:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790483078; cv=none; b=Ln8nC4IQqwcw+cIMN5Q67M3ZKNlIxpKDVTzCsXcOYYtAtr3cAj3lgypYVhXKeqgDIBCDIp+aT2Qhzb2eN4vDKnIFrCr7MEBSm5pYSRqZeyxAZ18ajLN4vcQi9/iPKyLw9Itn2boQ09TS/DdoWqWRYR59DiDenaikX+36mRQ2r78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790483078; c=relaxed/simple;
	bh=RqX8LwztQDcyZXECGNOA8Bg4TuU92m7ZS2LLyRrpO3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QzIwYMvj1Tb1euAmRxu2Pog8G30iNtQuKR2Q1Irwoge/nRQ1gkXoRFIegaUrF0FVlSjOgXrpo04Z2IAT/VllyTayl8zVFH0wfBe+GfDntvLwD8PdRi+XugkzS3aClcfULwdSDu5d1v/9P9jbJHaHR3AqxxSS0A0lPOf4w72Mn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHCTuyJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHCTuyJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616A01F000FF;
	Sun, 27 Sep 2026 04:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790483076;
	bh=43vQ442eeD6ZKyZtFMbjR3LR9BPhRbW0QVn5WWtTkHA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GHCTuyJkYXwKEm3ywhWWfKlJNLWEpSp3IXKQD8zcMyxazQPXXebJoHAEMatZBfrGS
	 pdE6f0tFVMYLeW2FhCwspfz/hslRwaN24MM5l6kSRxyOY4pF0KeKNeOIindCI6iVmH
	 TNAMtkLz4q4KFDufxWvDtbXxc4RkWiap2ZWeI86ljsWhieVfQ6GZaEvpKH+RU09uB2
	 D3lOrI+wDhLtGwKws3kQSILCHoTkLiFnGPnEiDvU4uMn0TluY2tOL8xaoCdQ6Y5UHT
	 6aohage++zp3aX8ZFfZ6dPnqqvO3qgIRkNDqXpsZxHUeL4/VE4aIBniagG6p4VO6oO
	 5HhBNyLiNTItg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] HID: wacom: check the input device in
 wacom_intuos_pad()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260927041138.4112920-4-jinmo44.yang@gmail.com>
References: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
 <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20260927041138.4112920-4-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 04:24:35 +0000
Message-Id: <20260927042436.616A01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: wacom: unintended fall-through for pad packets causes data co=
rruption or crash
--

commit b724787c53f0eff408a5ebd5d5a4bed152ed7f82
Author: Jinmo Yang <jinmo44.yang@gmail.com>

    HID: wacom: check the input device in wacom_intuos_pad()
   =20
    wacom_intuos_pad() takes wacom->pad_input without checking it. An
    interface that declares no pad leaves the pointer NULL on a fully
    successful probe, and wacom_intuos_irq() still calls this function for
    pad report ids.

    [ ... ]
   =20
    Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuo=
s/Cintiq")
    Cc: stable@vger.kernel.org
    Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 794c2865064aa..48a58a6672c21 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -553,6 +553,9 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>  	bool wrench =3D false, keyboard =3D false, mute_touch =3D false, menu =
=3D false,
>  	     info =3D false;
> =20
> +	if (!input)
> +		return 0;
> +

[Severity: High]
Does returning 0 here for a pad packet cause it to fall through and be misp=
arsed
by other handlers?

In wacom_intuos_irq(), if wacom_intuos_pad() returns 0, the packet falls th=
rough
to wacom_intuos_inout():

drivers/hid/wacom_wac.c:wacom_intuos_irq() {
	...
	/* process pad events */
	result =3D wacom_intuos_pad(wacom);
	if (result)
		return result;

	/* process in/out prox events */
	result =3D wacom_intuos_inout(wacom);
	...
}

Because wacom_intuos_inout() only checks data[1] and doesn't verify the rep=
ort
ID in data[0]:

drivers/hid/wacom_wac.c:wacom_intuos_inout() {
	...
	if (!(((data[1] & 0xfc) =3D=3D 0xc0) ||  /* in prox */
	    ((data[1] & 0xfe) =3D=3D 0x20) ||    /* in range */
	    ((data[1] & 0xfe) =3D=3D 0x80)))     /* out prox */
		return 0;
	...
}

If data[1] of the unhandled pad packet happens to match one of these proxim=
ity
bitmasks (like 0x80 for out-prox), wacom_intuos_inout() will misparse the
packet. If it hits the out-prox case, it calls wacom_exit_report() which
dereferences wacom->pen_input. If pen_input is NULL (e.g. on a touch-only
interface), could this cause another NULL pointer dereference?

Should this !input check be placed after validating data[0], and return 1 to
correctly consume the report without falling through?

>  	/* pad packets. Works as a second tool and is always in prox */
>  	if (!(data[0] =3D=3D WACOM_REPORT_INTUOSPAD || data[0] =3D=3D WACOM_REP=
ORT_INTUOS5PAD ||
>  	      data[0] =3D=3D WACOM_REPORT_CINTIQPAD))
>  		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927041138.4112=
920-1-jinmo44.yang@gmail.com?part=3D3
