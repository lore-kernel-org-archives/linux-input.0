Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7383F33E360
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839055; cv=none; b=dRY8BXE9yy4olQwvm/CfcIPEloR8EAhnxy+06ZbrVXRniImUZo3/UguDK6mT24NO5uhG6OHf4b8BijLfIln7oi/Ja6eXRv2FcWltnfAveKzXkH/w/DOjrl4Hq5knZ6WAkkRGtktYwh8lFPAkiMDioIdhclbxkB5ZTmS7UM71ztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839055; c=relaxed/simple;
	bh=J7/c1KkwqPCETMo02cmYpZ3g7W0YD7rSbvh1LNOxIw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CdhohXjFUMstGG+RHma4YCkq044mlbEVqTVK8FMHy4jqtlEmlHKzIaSu9yeVEVaeBJIpnK2lQazUPVsa7pEyDS94qq3M9l8WiG4yFw+zywW468wntG0J3AHFaE/fgcdDukWaQzwyItNGlFkGy3ql6IxDBixqxwwZ4GGV5/OK9YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLhABbYd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLhABbYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632671F00A3A;
	Tue,  8 Sep 2026 03:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788839044;
	bh=x4Wrjb5qzL/KPtNdts3bl3SuAZN2M8LOtBb405hkzfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MLhABbYdDlklDZIlWS3zt3FRy1K5j1hw3DjET+cCLcO8SH5f8QT8eulu0KIP+wKz9
	 IOy1i/84f1y4ffz4Bu8qxdewkmw4HKTc7c8PmSuaM6SqmDJ72SYW0nnlUS7IsYUyPc
	 0WBEU8kVyXCJNagKwmHGNV/bdJHmHlfNEhLJmGgLoXCZcoLTxuOERVovDE8aYSOh24
	 EJ5USsxE/KojcIC4CYbpjVzmUTZcBAvQ0EyjUHdzUqF/JAxKZFnyTSw5edmgqqY2X3
	 5aDKKqrux/cTNwA6Hk/nTzGktAKuCdpFuyshEpTpebrKLW4B5C7m5yqVgheFaDpERd
	 blKWP+KZ1b5Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/12] Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908032145.2118234-11-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
 <20260908032145.2118234-11-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 03:44:04 +0000
Message-Id: <20260908034404.632671F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The deadzone and fuzz reduction loop in the universal force-feed=
back driver hardcodes its upper bound to ABS_BRAKE, failing to include the =
newly added racing axes.
--

commit 87216a5e9d2ce889923252443994d20643f1c840
Author: Vicki Pfau <vi@endrift.com>

Input: Add ABS_CLUTCH, HANDBRAKE, and SHIFTER

This commit adds new absolute axes for racing game controllers.

> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/=
input-event-codes.h
> index 3528168f7c6d7..5c881ed441771 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -879,6 +879,9 @@
>  #define ABS_WHEEL		0x08
>  #define ABS_GAS			0x09
>  #define ABS_BRAKE		0x0a
> +#define ABS_CLUTCH		0x0b
> +#define ABS_HANDBRAKE		0x0c
> +#define ABS_SHIFTER		0x0d

[Severity: Medium]
Will these newly added racing axes be excluded from the deadzone and fuzz
adjustments in the generic PID force-feedback driver?

Looking at universal_pidff_input_configured() in
drivers/hid/hid-universal-pidff.c:

	/* Decrease fuzz and deadzone on available axes */
	for (axis =3D ABS_X; axis <=3D ABS_BRAKE; axis++) {
		if (!test_bit(axis, input->absbit))
			continue;

		input_set_abs_params(input, axis, input->absinfo[axis].minimum,
				     input->absinfo[axis].maximum,
				     axis =3D=3D ABS_X ? 0 : 8, 0);
	}

Since this loop hardcodes its upper bound to ABS_BRAKE, it appears ABS_CLUT=
CH,
ABS_HANDBRAKE, and ABS_SHIFTER will be skipped.

Consequently, these inputs would fall back to default HID core deadzone
calculations, which might result in inconsistent behavior and unwanted
deadzones compared to the gas and brake pedals which explicitly receive
a deadzone of 0.

Should this loop's upper bound be updated to include the new axes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908032145.2118=
234-1-vi@endrift.com?part=3D10
