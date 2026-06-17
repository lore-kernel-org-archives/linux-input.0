Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC875347C6
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 03:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781665455; cv=none; b=Vg9zXDL0JFpPP0ElLzaqwazkiwRwgt/mf4FJgALdq0NoP+RjepEsgdcJbThKxOd0T3h1zt5i3ba4wQiH19nY+LdqGMNexdMQxRhpBas5wL/PRL5WaJ7gPX8g0uiubWinbgu/Z+QQD/7KICAa8fGbkAtRL4FcY2w9Q05bMhmIt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781665455; c=relaxed/simple;
	bh=/E8lpW3YtBip1xnxTryVQDNNxhnTGDdKRbMJMKYWHvI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=trC1g8WjcGShEJlRhURkE/TOdoNG/uxf8Npqd4C/zgM/gcR/X2Jkd562OS7AqQGlmy89zYEM+H/pfTxEKVzWzdp14XAcC0KHhemplFc5646+kNreh3Qb/lhVtqJ2Mawpijwjk6RSgXctRTkx6V7o8iBzrm4GDqeW8fQ079Ll72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8OtPnIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8OtPnIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265D31F000E9;
	Wed, 17 Jun 2026 03:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781665454;
	bh=SChC0cRG0KO73j756LGrnFc+Q9LLcLYM6gsPFfa2Kzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U8OtPnItG7eIgtwssVTgh6bOuazGoEHXWoFC9yA1V6Y4fMr8FTTszUo2T5n20ILnc
	 8hQgxN+hm54yNLZvK6RUTzTiqLfGL5N3y07TZZZDu/TeMrMTm9iVop5LarQI3QzKpF
	 TrbOgJgKG4o2IQxFRPO7ykcUCS3Oxz2taE2R7WBFx3So2G0L8TUwcyrmcXDQSev2jc
	 z9JBBaMST/iUnnlGcM3nGfh+FROqwuPJxefgObCJm2fgFZdQgDEPEFI5kJ53RTA7Tv
	 9wO9HTexFvHwX9u+6XU5s4fAmRUydtaKRr0GgZw8CpJxKT1dJY0F8lvlYGcquKte2p
	 p702yZi4oFZlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics - disable InterTouch on ThinkPad T440p
 (board id 2722)
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UmFwaGHDq2wgTGFyb2NxdWU=?= <rlarocque@disroot.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260617025619.41237-1-rlarocque@disroot.org>
References: <20260616171137.19069-1-rlarocque@disroot.org>
 <20260617025619.41237-1-rlarocque@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 03:04:13 +0000
Message-Id: <20260617030414.265D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Format specifier type mismatch in `psmouse_info` call.
--

commit 0fa38fb74cf1360727ab0551657ea6c7dcbf7b75
Author: Rapha=C3=ABl Larocque <rlarocque@disroot.org>

Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)

This commit disables SMBus InterTouch for the ThinkPad T440p (board id 2722)
by matching its PNP ID and board ID. This ensures the touchpad works via
PS/2 immediately at boot, bypassing a long delay caused by the SMBus
companion device taking time to initialize.

> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -1837,6 +1837,16 @@ static int synaptics_setup_intertouch(struct psmou=
se *psmouse,
[ ... ]
> +		/* Disable intertouch on known-broken board revisions */
> +		if (psmouse_matches_pnp_id(psmouse,
> +				(const char * const []){"LEN0036", NULL}) &&
> +		    info->board_id =3D=3D 2722) {
> +			psmouse_info(psmouse,
> +				     "Disabling intertouch for board id %d\n",
> +				     info->board_id);

[Severity: Low]
This isn't a bug, but should the format specifier for info->board_id be %u
instead of %d?

Looking at struct synaptics_device_info, board_id is declared as a u32:

struct synaptics_device_info {
	...
	u32 board_id;		/* Board-ID */
	...
};

While 2722 easily fits in a signed integer, using %u would avoid potential
format string warnings under stricter warning levels.

> +			return -ENXIO;
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617025619.4123=
7-1-rlarocque@disroot.org?part=3D1
