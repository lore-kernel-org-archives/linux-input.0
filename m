Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443057083C
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 00:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778631410; cv=none; b=NDsN/VdpZuwYRE7cJqCF8anNjmqyhFpMG/xzuHxdD/cPK9celz9Eq1eGqUVm8Kn6exBRLBytMgG/yU1GjXNguXSuEdjb0Oqq8pxfa7slb756S+DzhR/W6z2UxmfwRJJZXLtb5bLLy+AYdwmqSUPzO17fQZxiZRLDTlhHarzOKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778631410; c=relaxed/simple;
	bh=wp/7HKpoLGwnkwCANS4T8lYWuk514t45RnxWES5T8q4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uL7asF0kXTDyIwBvcPpQ9G+TkvqQkgn4kTnOWev55lHw+j1ISwN2YxOK/a1yJOy5Sz1hxmiciaQkzPr39gIzyCpX6cLmstWuR48OScTtBc2v6LmU+noig/G/8DKph9bdUIbPEmj2YbcFhsP2AdUwmVOn9B/KBa96xC8WqOdW5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGsmLGJc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGsmLGJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EE5C2BCB0;
	Wed, 13 May 2026 00:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778631410;
	bh=wp/7HKpoLGwnkwCANS4T8lYWuk514t45RnxWES5T8q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aGsmLGJcWZnoF/0QnTd881iogPCens+FCpAGLjZYlvaS4WCS8X8fpNw3O9+eDALAX
	 DVFZQHHxOASLkvxC6ECg9Uu2Q6wR023jc69acyNf691RJWLaSGLHZg2fFiXvBFkn+0
	 k+BiY8+U+DRlEibQX9TepetZoSuR7nAwhm0to55XzyOx9SuQulbgolqF+oODuInDVO
	 3au26XFHNung6tTtFdVkFOu0Voeaat0PDDI/M0jqiRcvRnY6Qqyby/k5hymHLPjmKU
	 sK2XpgQDHO0apqSO+WU+4Wh9kM5Of3BbJB/WM6niGvEZb8JrRO3YZiQhRR+M/nyYWb
	 eeDl1u9jfoCRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: magicmouse: add haptic click configuration for
 Magic Trackpad 2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Fressl" <christian@fressl.at>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260511203115.104087-1-christian@fressl.at>
References: <20260511203115.104087-1-christian@fressl.at>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:16:49 +0000
Message-Id: <20260513001649.E9EE5C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The module parameter `haptic_click` is read multiple times without =
being cached, resulting in a Time-of-Check to Time-of-Use (TOCTOU) race con=
dition.
--

commit 160ed71822c4a0697b90debaa037251a7e50642c
Author: Christian Fressl <christian@fressl.at>

HID: magicmouse: add haptic click configuration for Magic Trackpad 2

This commit adds support for configuring the haptic feedback on Apple
Magic Trackpad 2 devices. It introduces the haptic_click module parameter
to choose between unchanged, silent-low, or off states.

Link: https://github.com/mwyborski/Linux-Magic-Trackpad-2-Driver/issues/28#=
issuecomment-451625504

> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index e70bd3dc07ab7..31002cb1f1089 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c

[ ... ]

> @@ -812,6 +827,81 @@ static bool is_usb_magictrackpad2(__u32 vendor, __u3=
2 product)

[ ... ]

> +static int magicmouse_apply_haptic_click(struct hid_device *hdev)
> +{
> +	u32 click_feedback;
> +	u32 release_feedback;
> +	int ret;
> +
> +	if (haptic_click =3D=3D TRACKPAD2_HAPTIC_CLICK_UNCHANGED)
> +		return 0;
> +
> +	switch (haptic_click) {

Since haptic_click is a module parameter with 0644 permissions, can it
change concurrently between the if statement and the switch statement?

If it changes from TRACKPAD2_HAPTIC_CLICK_SILENT_LOW (1) to
TRACKPAD2_HAPTIC_CLICK_UNCHANGED (0) right after the early return check,
this regression could cause the switch statement to fall through to the
default case. This would result in an incorrect warning and return -EINVAL.

Would it be safer to read the parameter into a local variable once using
READ_ONCE() to avoid this race condition?

> +	case TRACKPAD2_HAPTIC_CLICK_SILENT_LOW:
> +		click_feedback =3D TRACKPAD2_HAPTIC_SILENT_CLICK;
> +		release_feedback =3D TRACKPAD2_HAPTIC_SILENT_RELEASE;
> +		break;
> +	case TRACKPAD2_HAPTIC_CLICK_OFF:
> +		click_feedback =3D TRACKPAD2_HAPTIC_OFF;
> +		release_feedback =3D TRACKPAD2_HAPTIC_OFF;
> +		break;
> +	default:
> +		hid_warn(hdev, "invalid haptic_click value %u\n", haptic_click);
> +		return -EINVAL;
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511203115.1040=
87-1-christian@fressl.at?part=3D1
