Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE8143B3E7;
	Thu, 23 Jul 2026 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802869; cv=none; b=VPzvByBKGV2vjwO4zHthg003mLU6l7TR5t2r6l9H5UgYN1xhrbULCEtwDeesLFp/iPpVz1ID42WLCAiBZIduyQwEmm2BL7GmBZMR0Oxzcw+3Q7FLeh7YArPTnVPqe2Li5r7qTQVwhnSkpFAtQQtXWvhkTjExRk7ze0cbI0wATRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802869; c=relaxed/simple;
	bh=K7FsJb35z6jEDs1gKdsMSV+AYBwMwJHCmZGh7clmwVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CdcWqE/vhjD+dAVYS965iLmlgPtLZYNoZ5bIh1i8NsIj3uGzYC0/gTANLNAtbAtDJkyvANsB33ZOmP0olMD0qIbv2aXkhmRdqttAdFw0hOr185GsLeAbXbn1XgsUVkrG5KQcM/EH2QGsviAq3AswojpgFrrm9TI8qtUczXu2cDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510A11F000E9;
	Thu, 23 Jul 2026 10:34:27 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] dt-bindings: leds: backlight: Convert TPS65217
 to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: dri-devel@lists.freedesktop.org, lee@kernel.org, dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260723100605.628882-5-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
 <20260723100605.628882-5-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:34:26 +0000
Message-Id: <20260723103427.510A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The converted MFD (Multifunction Device) core binding is incorre=
ctly placed in the `leds/backlight/` directory.
- [Low] The commit message uses an incorrect subsystem prefix for a Multifu=
nction Device (PMIC).
--

--- Patch [4]: [PATCH v4 4/4] dt-bindings: leds: backlight: Convert TPS6521=
7 to DT schema ---
commit 1f4c2bf543a28045151b5cf16c5be1f7c2cee8e1
Author: Eduard Bostina <egbostina@gmail.com>

dt-bindings: leds: backlight: Convert TPS65217 to DT schema

This commit converts the Texas Instruments TPS65217 bindings to DT schema.
It consolidates the old regulator and backlight bindings into a single
schema file while documenting additional child nodes and properties.

> dt-bindings: leds: backlight: Convert TPS65217 to DT schema

[Severity: Low]
Is the subsystem prefix correct for this device? The TPS65217 is a PMIC=20
and its core driver resides in drivers/mfd/tps65217.c. Since this patch=20
consolidates the bindings for a Multifunction Device into a single unified=
=20
schema, should the prefix reflect the MFD subsystem instead, such as
dt-bindings: mfd: ti,tps65217:?

> diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,tps65217=
.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
> new file mode 100644
> index 0000000000000..4d2f4dbd2d52e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/ti,tps65217.yaml#

[Severity: Medium]
Since this schema consolidates the regulator, backlight, and other PMIC
functions into a single file, should this be placed in the mfd/ directory=20
rather than leds/backlight/? Placing it in leds/backlight/ seems to=20
categorize the device's primary role as a dedicated backlight rather than=20
an MFD. If moved, the id and file path would become=20
http://devicetree.org/schemas/mfd/ti,tps65217.yaml#.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723100605.6288=
82-1-egbostina@gmail.com?part=3D4
