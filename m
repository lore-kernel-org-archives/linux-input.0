Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9FB33A005
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145431; cv=none; b=W9PopYkLQ7Kmi1UxvenjAR9flzgcStTMkEnl4pOymIynDSDXpkdRRAKUMbNC5nF1wQfryzRcEcDbpGdtzH8gJM4RsEvs9LHZ8EvvNX40YgAgTotgdNJIcLhpPb7PrfPv6GLCEjls/biYn9GAmerxKqxb+P2xuLym4iUjmmur2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145431; c=relaxed/simple;
	bh=433FfMUSHmQ5hn4xS7fQfHWiZ+2WigeedsbIC9sevbI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m4LpM+rOHMuyM+BJLegJwk12HsnVaY9PMZqJUrHIpGw5AYtYKw4lXBIu8XHQjAHEYJAKeyf3U7j7zNa0D2LukxgA1ExVnGl2Z0S5BfB+WGhMaaYAzPcdRtY8QvNe4ZY+iTaqiNiFS4p3MkI+U4xe9WnueaZ46XYUIACg/czoIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1c4tPxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1c4tPxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B89C1F000E9;
	Sat,  4 Jul 2026 06:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145429;
	bh=wUHT6dZDtuEVjxOw15nnxZqOaz0dDAisHs1cDbgfuds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y1c4tPxQy+Ol9RYpkJ2IpqOH+n9nuqrbW2qwKNxOykAsUk2i0KZ7Fep384PkPgPWV
	 kxwOWtat/IeB91scBUgFenDlmIJfFYHnt6MKnFSRfKkJS7Ur9r+WPE0s9StQKivcbK
	 L63BSqqzUSsRH7jQhK1nlKSU5X2fNffYalEF0dImPhZITL+GQUQwjD3MlEWc6m9hdd
	 blt949BzAQC+gtE60JQMbyJw2vDzbdhii335OWUaqMzvXHa6Nqkb+7iOamHErAoUYi
	 Vs31foGWcCVBYO7WC7iu4+nYtz9I8hMy4zPVtM8KZJ+Njp6oa+SUEFpdAZH4rluZwC
	 rnhhzankBL1ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/26] Input: maplecontrol - simplify maple_device
 retrieval in open/close
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-b4-maple-cleanup-v1-6-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-6-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:10:28 +0000
Message-Id: <20260704061029.3B89C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The commit leaves behind an unused `mdev` field in `struct dc_pad` =
and a corresponding dead store in `probe_maple_controller`, leading to unne=
cessary code complexity and memory allocation.

Pre-existing issues:
- [High] The event reporting callback `dc_pad_callback` fails to call `inpu=
t_sync()` after reporting a full frame of input events.
--

commit ef26388745a1577b8ffbd7d6511bdea113150cf1
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: maplecontrol - simplify maple_device retrieval in open/close

This commit simplifies how the maple_device is retrieved in the open and cl=
ose
callbacks. It stores the maple_device directly in the input device's drvdat=
a,
removing the need to access it via the platform_data's dc_pad structure.

> diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joysti=
ck/maplecontrol.c
> index c66b2614e2982..9d623c9e8f22c 100644
> --- a/drivers/input/joystick/maplecontrol.c
> +++ b/drivers/input/joystick/maplecontrol.c
> @@ -62,19 +62,19 @@ static void dc_pad_callback(struct mapleq *mq)

[Severity: High]
This is a pre-existing issue, but does dc_pad_callback() need a call to
input_sync() after reporting its frame of input events?

The input subsystem requires all logical groups of events to be synchronize=
d.
Without input_sync(), userspace applications may not see the events until a
SYN_REPORT is forced by a buffer overflow or another event.

[ ... ]

> @@ -112,6 +112,7 @@ static int probe_maple_controller(struct device *dev)
>  	pad->mdev =3D mdev;
> =20
>  	maple_set_drvdata(mdev, pad);
> +	input_set_drvdata(idev, mdev);

[Severity: Low]
Does this commit leave the mdev field in struct dc_pad unused?

Now that the input device retrieves mdev from drvdata, the only remaining
used field in struct dc_pad appears to be dev.

Could struct dc_pad be completely eliminated by storing the idev pointer
directly as the Maple device's private data, avoiding the devm_kzalloc()
overhead entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D6
