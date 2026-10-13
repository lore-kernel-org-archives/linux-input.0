Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8DE524AE9;
	Tue, 13 Oct 2026 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913375; cv=none; b=WPSlqKEsd7rFwgv+3ej64fET4ljRpRq+tfb5F3SmE0sr2JGQ9jnFwzsLGAgfACKNkQ8pE14XBl3zqKGmGXHBE17xEt6Kdr37o5hkQ4ROSHxsyELakWoXm0b/zEOT0Y9X4xp8q8aEC5Zy1ACN4mk7h5QgfhQ06Psb+h2EIT/BBVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913375; c=relaxed/simple;
	bh=dspCkaIIbv/Ne9NgWDKxz+O04NePG0tyuPE+rA9uJPQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TgoqkQjrqGY2+INfCBflUdXZAPDDct9ezms8Pt0gAWHvxP2M4Q9dbv7Zdx4nvmg4QJulkCoLv2DvK5xgBJ1zFMLUHQQP2E56iNCegVdNu6LEfHOMyZMjx/Xt1Y7ATSzUvwYWGryJrHFKbreTdW2K3l4D8ZaGo3aJkwAhwCO66bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hzmej8ck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hzmej8ck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50741F000FF;
	Tue, 13 Oct 2026 17:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791913373;
	bh=dspCkaIIbv/Ne9NgWDKxz+O04NePG0tyuPE+rA9uJPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hzmej8ckOFd/gITMyGs9uKyQycxxDfsDpHAgOv0mcqfTnbF5NRJhKH+ug5NlweBpn
	 tQKPVeoEU+VToaDWY76eMor3psCbyBjHSFIPBXWtm79lzYN3D/YZJMUd9oBCIeaTqy
	 TjxlgvmNP/0HjlhrCyJz3soyD9dhea8XUlcXhhWZJAkIQZHiGrcIdRGghFXFqUC9i5
	 MFxgbttAqoRUB1PrmiYikZ9mFxBYfHDBWo1geNPIts9I3CF8qDbk8V8gfAQLUv7nLm
	 3dsJorEMuPLKdRb8uFYnx4RPAYLxmyK2V6teIgY5mntK1qgqhMCbo8BnpaLzNCqQ/S
	 kEOWHr5XzNzbA==
Message-ID: <sashiko-outbox-170246@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 5/7] leds: Add driver for ASUS Transformer LEDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261013173504.451391-6-clamor95@gmail.com>
References: <20261013173504.451391-1-clamor95@gmail.com>
 <20261013173504.451391-6-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:42:52 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] leds: Commit message prefix violates naming convention
- [Low] mfd: Driver-specific header placed in global include/linux/mfd/
--

commit 6dfd67b7a2e641ea71f3bcae79bf5a863c4f809d
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

leds: Add driver for ASUS Transformer LEDs

This commit adds a driver for the charging indicator LEDs on the Asus
Transformer pad and dock. It registers amber and green LEDs using the
asus-transformer-ec MFD core.

> leds: Add driver for ASUS Transformer LEDs

[Severity: Low]
This isn't a bug, but does the commit subject omit the mandatory driver
name segment? The LED subsystem guidelines recommend the commit message
prefix to follow the format "leds: <Driver>: <Capitalized description>".

Could this be updated to something like "leds: asus-transformer-ec: Add
driver for ASUS Transformer LEDs" for better git history categorization?

> diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds/leds-=
asus-transformer-ec.c
> index 0000000000000..1b129247ea6c6
> --- /dev/null
> +++ b/drivers/leds/leds-asus-transformer-ec.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/err.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/asus-transformer-ec.h>

[Severity: Low]
Is this driver-specific header globally exposed in include/linux/mfd/?

The MFD subsystem guidelines suggest keeping driver-specific header files
local to drivers/mfd/ if they are only used by the parent and its immediate
children, rather than placing them in the global include/linux/mfd/
directory.

Would it be possible to move asus-transformer-ec.h out of the global
include path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013173504.4513=
91-1-clamor95@gmail.com?part=3D5
