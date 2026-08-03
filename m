Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD42D7DF1
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721184; cv=none; b=PzWg06E+5zfuTu9+O+2BDzjDiZ6XrYvLq3o4135ZxjHHOWl//UmZH5oeit2kK76YOcy0E39kg5RD7ouypv9jqwTyTC6ara6KbbEQuJjYzVOT3XKHIMX59e49damkXZn0eMKIjH7OKl5Fw+HtLOjYBiAJBnaWugOyNXxg7bw9yHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721184; c=relaxed/simple;
	bh=PDvSkoa3EBUsmP8mUzQvaGS8nAPvJ/4RbmSuVExaPEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=siI4Uxyvkiyy7PqzRpWogN0og8YEwI1hw2BZ4FVwh3yAx3au5S0/4pZJGOd+qTmdtPhsyXHQznh8PDMynACXPOuU63KEBfdWeJPMVCaMalg8wQ7Itilm9SZAiUQDExMNk5584R6jofZ+Y4Uza0ZjO75A9E6iJgSiU3B9icLZnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adgkYkUm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adgkYkUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5761F000E9;
	Mon,  3 Aug 2026 01:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785721182;
	bh=c6ye07a51X/zp4+yNOZBrnz0Jhdatbb4ZN8kczylNGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adgkYkUmTS6CnDefYiXS6wZJ4LSlBQ4FSPvlCQ3AFsqtHe7k7auxMjxT56me7nu9Q
	 gRsOztUzpevbqzyOiN3aL6GIwN4A3/s6xfzKWDnUgnbWnJibKUA2TJFQpJzBgGpr1T
	 2hoTfaTZU477niu3jjrg+31XKZu3xiSsW8JiQvzZeay4yZQiWgRiHsl/GJbn8WhcGX
	 lPRkplPqhebMb1YGmqaSluYWmWIsmXb3KG2fG5uDayWfSD9FxiJWE/xC0wD5oBIAW0
	 JV3rCR8egLjnPDJK49bcz9h1PUkobZAjfi4mxIyPTa77Tpd0GemkOxCdTMGKkv4oLA
	 IXqAZAr8HDWxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: focaltech - use signed coordinates to prevent
 underflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <am_tH_F938rK6ask@google.com>
References: <am_tH_F938rK6ask@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 01:39:42 +0000
Message-Id: <20260803013942.9F5761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch changes internal coordinates to signed integers to preve=
nt underflow jumps, but fails to write the clamped coordinates back to the =
internal state, creating a wind-up bug at the screen edges.

Pre-existing issues:
- [Critical] A signedness bug in `focaltech_process_rel_packet` allows an u=
nused finger index to evaluate to -1 and bypass bounds checks, causing an o=
ut-of-bounds array write that silently corrupts the touchpad's physical bou=
nds limits.
--

--- Patch [1]: [PATCH] Input: focaltech - use signed coordinates to prevent=
 underflow ---
commit e1624dd1b0cb6c1665dcbaeda6430fe12e1a62aa
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: focaltech - use signed coordinates to prevent underflow

This commit changes the internal finger coordinates from unsigned to signed
integers to prevent underflow when processing relative packets. It updates
the variables in focaltech_finger_state and the clamping limits in
focaltech_data to avoid erratic cursor jumps when moving past the touchpad
boundaries.

> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focalt=
ech.c
> index 43f9939b7c63c..4c909c4ca76c9 100644
> --- a/drivers/input/mouse/focaltech.c
> +++ b/drivers/input/mouse/focaltech.c

[ ... ]

> @@ -126,14 +126,14 @@ static void focaltech_report_state(struct psmouse *=
psmouse)
>  		input_mt_slot(dev, i);
>  		input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
>  		if (active) {
> -			unsigned int clamped_x, clamped_y;
> +			int clamped_x, clamped_y;
>  			/*
>  			 * The touchpad might report invalid data, so we clamp
>  			 * the resulting values so that we do not confuse
>  			 * userspace.
>  			 */
> -			clamped_x =3D clamp(finger->x, 0U, priv->x_max);
> -			clamped_y =3D clamp(finger->y, 0U, priv->y_max);
> +			clamped_x =3D clamp(finger->x, 0, priv->x_max);
> +			clamped_y =3D clamp(finger->y, 0, priv->y_max);

[Severity: High]
Does changing these coordinates to signed integers without updating the
underlying state create a wind-up effect at the screen edges?

When swiping past the left or bottom edge, finger->x or finger->y will now
be driven into negative values. Because the code clamps these values for
reporting but does not write the bounded coordinates back to finger->x or
finger->y, the out-of-bounds coordinates can accumulate wind-up.

Would the user then have to swipe a significant distance in the opposite
direction just to offset this accumulated negative value before the cursor
visibly moves away from the edge?

>  			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
>  			input_report_abs(dev, ABS_MT_POSITION_Y,

[Severity: Critical]
This is a pre-existing issue, but does this out-of-bounds array write in
focaltech_process_rel_packet() explain the original erratic jumping behavior
the patch aims to fix?

When an odd number of fingers touches the pad, the hardware reports unused
fingers with an index of 0. In focaltech_process_rel_packet(), the index is
computed and checked like this:

drivers/input/mouse/focaltech.c:focaltech_process_rel_packet() {
    ...
    finger2 =3D ((packet[3] >> 4) & 0x7) - 1;
    if (finger2 < FOC_MAX_FINGERS) {
        state->fingers[finger2].x +=3D (s8)packet[4];
    ...
}

Because finger2 is a signed int, an unused index of 0 evaluates to -1.
The bounds check -1 < FOC_MAX_FINGERS incorrectly evaluates to true,
bypassing the safety check. The exact same signedness flaw exists for
finger1.

Due to the struct layout in focaltech_data, accessing state->fingers[-1]
offsets backwards by exactly 12 bytes. This perfectly aliases
state->fingers[-1].x to priv->x_max and state->fingers[-1].y to priv->y_max.

Could this out-of-bounds write be silently corrupting the touchpad physical
bounds limits, continuously adding relative movement deltas to the device's
maximum coordinate limits and causing the cursor to jump erratically?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/am_tH_F938rK6ask@go=
ogle.com?part=3D1
