Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892049B5B0;
	Fri,  2 Oct 2026 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947615; cv=none; b=bGySwidQmg6pQ9cdm+hEmtjDI1dYa0EONewoDHrq+DkcgbrVcft7gSjqvkAYo1y5DEgByw6mU18aGjW2aRWhndVnRS0bWZsqxbZsn8oic3SL/BBpmu8xjZQGdUjje41i9qAWo4HcinwgYlcaIrbf+VCggS+1lyTaY8g7E0Aukqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947615; c=relaxed/simple;
	bh=1pnwwkQubkDwLdCpcqdwupsj9/qnViGcxUC7rJ1lrbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OZWuwQyPVGdQPho5aBbOnuoyyocZHK916tLiZ6eo7DYqN86QAGP2HSWcV/pXo0tUo3dGA1+FpMR2JLcYbM4YnzL24EXaV+BsKogzEhBv3xwgm8wJOy4GuWAcNCT/JO3cruNozjYsrTxW18fmU/1uXwf3ysyHqf4DkfVefEkmWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA9OP6gd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA9OP6gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06DB1F000FF;
	Fri,  2 Oct 2026 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790947614;
	bh=vCGJB4quEF05q1J9Qd9cW29CW7EbhQBCJb983SsaagY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KA9OP6gd2slVytZJt/KJanfE5rZaVsOelvicNibFA22kQyKouOB+Ce3lBtItN17K6
	 Nxlht8SVZ8UJdM0d6dDJ9EHomKt1LLB77br0ZE4kh/W3tFpJ1HeIFbS0S68EHv6ESr
	 GZ8vpaqtWQixV5iGTxt/9vJzdVbOghZx/M3Uzb3JAr6PmPCwG50Jbv0xX7NeNbdc1P
	 QKNOk4fC7a0d3NtZB7q78ZXi/4zOZYJeZYYn6Go8Kcj0hfOsqGM0DIhhiGOmV7Idfv
	 B+cE3Re5cWot1dwPdpP9o8cokJu7yv1j2wz0LwNlUpXPF3FyneATUPl6wLPmAPu9pT
	 Qnk+iPlNtoKAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] Input: hynitron-cst816x: power sequence with the
 panel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Golle" <daniel@makrotopia.org>
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <67e9a67e17a977053eaacef203416473f4c63968.1790944534.git.daniel@makrotopia.org>
References: <cover.1790944534.git.daniel@makrotopia.org>
 <67e9a67e17a977053eaacef203416473f4c63968.1790944534.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 13:26:53 +0000
Message-Id: <20261002132653.C06DB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kconfig: built-in driver links to module due to incomplete DRM_PANE=
L dependency
--

commit 334717615b8688937194889ec9606ffff8c712fd
Author: Daniel Golle <daniel@makrotopia.org>

Input: hynitron-cst816x: power sequence with the panel
   =20
Boards which mount the controller on the panel feed it from the
panel's rail, where a reset and the first interrupts are only
meaningful once the panel is powered. Register as a DRM panel follower
when the device tree points at a panel, so that the reset stays
asserted and the interrupt masked until the panel is prepared, and a
pressed key is released before the panel goes down again.

> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscree=
n/Kconfig
> index 9b9ae8ac3f7fd..0beb499e24f20 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -478,6 +478,8 @@ config TOUCHSCREEN_HYNITRON_CSTXXX
>  config TOUCHSCREEN_HYNITRON_CST816X
>  	tristate "Hynitron CST816x touchscreen"
>  	depends on I2C
> +	# We call into panel code, so if DRM=3Dm, this can't be 'y'
> +	depends on DRM || !DRM

[Severity: Low]
Does this allow a configuration where the driver is built-in but links to a
module?

The driver relies on devm_drm_panel_add_follower() from the drm_panel
framework. If DRM=3Dy but DRM_PANEL=3Dm, and TOUCHSCREEN_HYNITRON_CST816X=
=3Dy, the
built-in touchscreen driver will have an unresolved external reference to
devm_drm_panel_add_follower() in drm_panel.ko, causing a build linking
failure.

Should this dependency be tied directly to DRM_PANEL instead, such as
depends on DRM_PANEL || !DRM_PANEL?

>  	help
>  	  Say Y here if you have a touchscreen using a Hynitron
>  	  CST816x series touchscreen controller.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790944534.gi=
t.daniel@makrotopia.org?part=3D5
