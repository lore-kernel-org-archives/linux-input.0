Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AE837755D;
	Fri, 15 May 2026 06:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825531; cv=none; b=dY8EHZxy1qI7VcN3xCprvRpIv5tmLJTc5FsSijfkFe0HHkU1JefK8IgeJAcoCz//SuXK+SbjYVfuU/9Y89QpWcvojKE6hY9AniDJP92xtYVpAp3i5mvtTvg3qywifqyHMhOh6rYP7yn7Te51XDuAobFqMMPP63R0wY32zQ3BicM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825531; c=relaxed/simple;
	bh=HaP+HuyaCZ1iLbbpXoGGM6EohGYoHLIqubUUfGyF7lw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kr6Oa7EQV9B5VwS+fpezly+qaOdCU7VBr0AAipsUy20hGcDFX8MYnlnqmnKne3zVas7m6HHnEx6Rh8FW44ys7GnnTYcrysvya6Nfba3h9douZykW+qwNy2kSBmdfxofQZwChxsMxA0gqaflNjs2rsppwmaefRiIbqSiQm75Y5kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf+gixvi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf+gixvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7C6C2BCB0;
	Fri, 15 May 2026 06:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778825531;
	bh=HaP+HuyaCZ1iLbbpXoGGM6EohGYoHLIqubUUfGyF7lw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mf+gixvi5GmOBZEKW12gNI8oiSxYqq6aaG7An/uWNSRR2q8bq8AV2nwcGqFBvQ5uO
	 /oIJxhld5rkllfMt0LSCHnl9s0laQ1HouYr/WDIH5NiVmb8Kp5lQ9qDdvjBj52xVU4
	 nrnbjeVfMNSGKz6fsUldoN6I5gVQPkmwqKgkvQkA83HuJXtv+gV1GdSpDmL9KhaiWI
	 EQ9sVa7KPYUpXVvoEM24lPS1UCSiStsG4JqU22QUEVaj9vpH2/7JxVTaguW+02YeS9
	 AwvjjJ+erUlaET3eEpzjssI7WGA3XkcXmXo6t92pixrvkNm84jeYUbaOgm1/lXADYM
	 kMxGcNlgwcqpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] hid: Pen battery quirk for Surface Pro 12in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harrison Vanderbyl" <harrison.vanderbyl@gmail.com>
Cc: dmitry.torokhov@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org
In-Reply-To: <de275cc63e764d2acddf72bf3f50e89f307f41b5.1778822464.git.harrison.vanderbyl@gmail.com>
References: <de275cc63e764d2acddf72bf3f50e89f307f41b5.1778822464.git.harrison.vanderbyl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 06:12:10 +0000
Message-Id: <20260515061210.BF7C6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added macro uses spaces instead of a tab for value alignm=
ent.
--

commit 41dd30be72b9f45b17d28788bd19cb4c73988147
Author: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>

hid: Pen battery quirk for Surface Pro 12in

This commit adds a battery quirk for the Surface Pro 12in pen, which uses
bluetooth for communicating battery levels rather than i2c. Adding this
quirk prevents the device from reporting a phantom battery or hanging.

> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 0cf63742315bf..d16f55479786c 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h

[ ... ]

> @@ -459,6 +459,7 @@
>  #define USB_DEVICE_ID_HP_X2		0x074d
>  #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
>  #define I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM	0x2F81
> +#define I2C_DEVICE_ID_SURFACE_PRO_12IN  0x4376

This isn't a bug, but it looks like spaces were used instead of a tab for
alignment here. The surrounding definitions use tabs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778822464.gi=
t.harrison.vanderbyl@gmail.com?part=3D4
