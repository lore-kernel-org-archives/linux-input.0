Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308061714AA
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079148; cv=none; b=dQ57rPuGrJO+d0c/mAIirnj0381vRlvHQijIZBSAEet8F3z+LxdCE+imhTkxp1soKQh+CcxBfAz1sc40/1oB8ytsiC8kkNk1YjPB51WFvY5Ke/HX0jwi2/xaP6lUUVD011EGOl96y1K/pRaNpPFBx9ngUMVyFAJ4EM5ZhQCjlOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079148; c=relaxed/simple;
	bh=kNUJA9yU24C6BICRxkMGUN0cOn7VIVY4OodFppLhL8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c7OkPAQlQtj9j/89pB8AzZ22PDTqbtteYZenVTMu4OMVRjaAqVotl+vgMsqiULj3mWUfCdeUlZ+WslRf/rU9stubm3+sh2Dl/h/wz1MI7hTqHTO/+tOdBd5XIzffZhn9/rlgc3iks1jmDAyujmQhy96wtZJWn7VTk6aYQMyWbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHyRJRPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHyRJRPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B981F000E9;
	Wed, 15 Jul 2026 01:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784079146;
	bh=IefNoxcIkD7QQetksk2w9DWwP1VMwNlw0mk3pDpbMTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jHyRJRPqHBInR4vMnLPA53O5be9jsvN5+zK7yzsS1sq+yUe2sLcPiqdhX1QS8D7j5
	 ujexNPbM480LnC0NRZ5KZowKHEos0ao4zLFXEyOd56rrtiYxEzTnMedXAJsfWEeZJS
	 AiW/wRLwvQVhkxNqpBz3WZx6ZIbt0rm9LLo/IrE28pvCowzt+z63hpP/2DdskfnqhM
	 USg77eKemGWCQGk44g0u5whEIGOxssq+VMHoyglNWHshhdim6Eg0PeGVP70rTEdGYB
	 EIblC6fTYnPtb/Ku2DcydsS65HM5sqU2iPr0wysU4WA8RE5H6jlBY7OrTQzQ8l5QlZ
	 dxzjUVdvx+SHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: wacom_w8001 - replace strlcat() with a strscpy()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Bridges" <icb@fastmail.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <albg4Rv7QxvLJD05@dev>
References: <albg4Rv7QxvLJD05@dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 01:32:26 +0000
Message-Id: <20260715013226.88B981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `input_free_device()` on a successfully registered device =
after `input_unregister_device()` in the error path leads to a Use-After-Fr=
ee / Double Free vulnerability.
--

--- Patch [1]: [PATCH] Input: wacom_w8001 - replace strlcat() with a strscp=
y() helper ---
commit e4f21712f81562322908d563a501b6a8bead0360
Author: Ian Bridges <icb@fastmail.org>

Input: wacom_w8001 - replace strlcat() with a strscpy() helper

This commit replaces five uses of strlcat() with a custom strscpy()-based
helper, w8001_append_suffix(). This prepares for the eventual removal of
the strlcat() API.

Link: https://github.com/KSPP/linux/issues/370 [1]

> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touc=
hscreen/wacom_w8001.c
> index 45930d7318733..d8d1cdc3f09e3 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c

[ ... ]

> @@ -534,7 +541,7 @@ static int w8001_setup_touch(struct w8001 *w8001, cha=
r *basename,
>  		input_abs_set_res(dev, ABS_MT_POSITION_X, touch.panel_res);
>  		input_abs_set_res(dev, ABS_MT_POSITION_Y, touch.panel_res);
> =20
> -		strlcat(basename, " 2FG", basename_sz);
> +		w8001_append_suffix(basename, " 2FG", basename_sz);
>  		if (w8001->max_pen_x && w8001->max_pen_y)
>  			w8001->id =3D 0xE3;
>  		else
> @@ -542,7 +549,7 @@ static int w8001_setup_touch(struct w8001 *w8001, cha=
r *basename,
>  		break;
>  	}
> =20
> -	strlcat(basename, " Touchscreen", basename_sz);
> +	w8001_append_suffix(basename, " Touchscreen", basename_sz);
> =20
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but calling input_free_device()
on a successfully registered device after input_unregister_device() in the
error path of w8001_connect() leads to a double free.

If w8001_connect() successfully registers the pen device but subsequently
fails to register the touch device, execution jumps to the fail4 label:

drivers/input/touchscreen/wacom_w8001.c:w8001_connect() {
...
	if (!err_touch) {
		...
		err =3D input_register_device(w8001->touch_dev);
		if (err)
			goto fail4;
...
fail4:
	if (w8001->pen_dev)
		input_unregister_device(w8001->pen_dev);
fail3:
	serio_close(serio);
fail2:
	serio_set_drvdata(serio, NULL);
fail1:
	input_free_device(input_dev_pen);
	input_free_device(input_dev_touch);
...
}

The fail4 block calls input_unregister_device(w8001->pen_dev), which drops
the device reference. Execution then falls through to the fail1 label, where
input_free_device(input_dev_pen) is unconditionally called. Because
input_dev_pen and w8001->pen_dev point to the same device, this results in a
second free.

Could this error path be updated to avoid the double free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/albg4Rv7QxvLJD05@de=
v?part=3D1
