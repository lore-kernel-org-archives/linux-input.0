Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027E034EF07
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428419; cv=none; b=eh+Icu9QC2Xk0treF7eGDwoOTJm8w+Oo5TWJdOT4JzBSrNI5NQSWEoJqX0sYfKNbgc4JdA8SUF0q2McvutLw9VVnVHCrWp3U3Du3zxxrGsqPf9mW6A+hhPvz8/0ElnGouHBxy5n5Ye0lGx1GehoL0I/fqcEbV+WdTXRm+q820DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428419; c=relaxed/simple;
	bh=IxefVSPJ3BMIPf9kBAnN/te7rO8tb4FkgooETdLIH4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rZ1+/Nhaite1hw9Owkj8rQmO81wYxEBTEcaRDd2fSzuG4ulbqyLU86BxV5Lx8fwFieHRLp3Zov8Y43aDXQ+aenZPPgHnfDv1afo2TRx6PTZIJY+n9nc/ANYEplGcv5J3r4IVwfhQrfXuJd0ExjUBgOtORWwrap2gHHHiC5HfBas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib0BtUmz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib0BtUmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A751F000FF;
	Mon, 14 Sep 2026 23:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789428416;
	bh=MyhYDt95vfMLz24eWyfdGj59de5P9EkHmEUgWGSTFzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ib0BtUmzdGymq6KsUzgsYkClleqfUfKiFX+z9UySsdY/2AprmqWgQdYJKDLR8R5sv
	 OjC7tbHfAp020EFy75xOEo9B1vRR3dWPnNJifNFpiQtEY3e+S/SZItRHHTyiqxmFJq
	 d4wV553aPqOGA0NhoJBXLWoDvDVCEQSbMlVkTmj7vubEenPmac1b36MYUuROg6HWQ3
	 FueabtyDoowrJqEujLdjBoqbd4MSY2xQIWNWZUunRX6cf7fmwpEFB95u+4Ue4ehvMC
	 M68SLIBI+XMhBaFZfvmmb9PSjnzglGyjMu1L/yYI3gTNjv2cRfiksZ8UDA1qj/xV6M
	 I+j99u44CImVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] HID: hid-lenovo-go-s: Bound stale reply window
 before reusing send_cmd_complete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260914225303.868569-3-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
 <20260914225303.868569-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:26:55 +0000
Message-Id: <20260914232656.45A751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] hid: conflating MCU error with timeout in mcu_property_out()
--

commit b76b36bd4347a4e16200e7b5eadeaf196d8595bd
Author: Derek J. Clark <derekjohn.clark@gmail.com>
Subject: HID: hid-lenovo-go-s: Bound stale reply window before reusing send=
_cmd_complete

This patch mitigates an issue where stale replies to timed-out commands can
silently satisfy the wait for the next command. It introduces a short bound=
ed
wait before reusing the completion structure and tracks when a command has
timed out using a new pending flag.

> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
> index 68301d4c762a1..36505d8402ff1 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
> @@ -479,7 +493,9 @@ static int mcu_property_out(struct hid_device *hdev, =
u8 command, u8 index,
>  							msecs_to_jiffies(timeout));
>  	ret =3D ret > 0 ? drvdata.cmd_status : ret ?: -EBUSY;
> =20
> -	reinit_completion(&drvdata.send_cmd_complete);
> +	if (ret)
> +		drvdata.orphan_ack_pending =3D true;

[Severity: Low]
Could this logic inadvertently flag a successfully received error reply as =
an
orphaned timeout?

When the MCU successfully replies with an error code (meaning drvdata.cmd_s=
tatus
is negative), wait_for_completion_interruptible_timeout() returns a positive
value indicating the wait succeeded. The code then assigns ret =3D
drvdata.cmd_status, causing the if (ret) check to evaluate to true.=20

Since the reply was successfully received and consumed, there doesn't seem =
to be
an orphaned ACK, but this will set orphan_ack_pending =3D true and penalize=
 the
next unrelated command with an unnecessary 25ms delay. Is this the intended
behavior, or should it specifically check for the timeout condition instead?

> +
>  	return ret;
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914225303.8685=
69-1-derekjohn.clark@gmail.com?part=3D2
