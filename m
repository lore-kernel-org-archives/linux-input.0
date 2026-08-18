Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E2332637
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787086194; cv=none; b=LipyOvRGP8Zhx5NvtvA0DxyNh2xeD7IqM9O5Kf/nq7Vh+9pozFqiSPhwbKW9WLfy7zYOvkDFHV/M8Yzj6vksJ+r4BPbU4JtbYhPUwlVWMUFMCqsEsj4heILUvtySnNLYUsIE0tuf4mJVpiIH74rFnK+aaWp0ayfqo1O/d91QRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787086194; c=relaxed/simple;
	bh=7yx4W6Y6IF6+t5tB53ezx3kTOBG/m8k7Uux+WHz1pRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YDgHIw+LqV7Mak5LjIWKHsiJEz8kfNsGDBLiwIfcimKL6R/Q46jVZOdxrTrgeh4njhqnDrXA3dA/cmFHnmaUOX7P5b+YsIklhmnB7xn8z1NHnVgriOo6rkA+ByNP8b5nvrKn1i11G7BCK46yEMojMAI9498pNA1IakuEniKqN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m25xMGP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m25xMGP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF5F1F000E9;
	Tue, 18 Aug 2026 20:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787086193;
	bh=cLtHiCtnlvCU46AiukLoCzCBFZRMfs/ETBXEXpkewIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m25xMGP2mZ/Tr4myTzkt8xcsU/xQBQhvHNs3u2A2XWGIuacY6Briwwca3VWhwr8jB
	 2moMDpRl+WHrUbkoiYraRrHtH79AQRkdeOhzs5nDBNZ1MTIIkF+RxOC3MPIUvQMzbx
	 lLrz2yESsx1AVINuGE2do+hYfMgzb2AoppUpGS0FJVJx/jbA1KnbZZ6N7rDuOeirWS
	 L4dek+AL6pqGPJGdCPXG3IjJkt4/1SOC2KZvvUiKyGKUfOCo6oeDlKlrRxxcISziCu
	 3olaR16AvbdQlHuG82hzwvY5cc1qlq/uD7zDPgdtI9RCD+Dk8NlB5xQIAFQAaFkFvF
	 yqilgUtDuKkfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics - disable InterTouch on ThinkPad T440p
 (board id 2722)
Reply-To: sashiko-reviews@lists.linux.dev
To: "R. Larocque" <rlarocque@disroot.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260818204215.72914-1-rlarocque@disroot.org>
References: <20260818204215.72914-1-rlarocque@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 20:49:49 +0000
Message-Id: <20260818204952.CCF5F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Format string specifier mismatch in psmouse_info: using `%d` for `u=
32` variable.
--

--- Patch [1]: [PATCH] Input: synaptics - disable InterTouch on ThinkPad T4=
40p (board id 2722) ---
commit 4b10eb76fbd26fd6245ba466bd6e79e874e7afbb
Author: Rapha=C3=ABl Larocque <rlarocque@disroot.org>

Input: synaptics - disable InterTouch on ThinkPad T440p (board id 2722)

This commit disables SMBus InterTouch for the Lenovo ThinkPad T440p (PNP ID
LEN0036, board id 2722) by default. This addresses an issue where the SMBus
companion takes too long to appear at boot, causing the touchpad to become
unresponsive.

> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synapt=
ics.c
> index 2170bbe4c5897..141d58a716180 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
[ ... ]
> @@ -1838,6 +1838,16 @@ static int synaptics_setup_intertouch(struct psmou=
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
Since info->board_id is defined as a u32 (unsigned 32-bit integer) in struct
synaptics_device_info, should this format specifier be %u instead of %d to
avoid strict type warnings?

> +			return -ENXIO;
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818204215.7291=
4-1-rlarocque@disroot.org?part=3D1
