Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870258;
	b=GTJXrrZO0vEzowjj+lcHoQXdMnvRFEDmKkkwD34OpbRXI1Q3qAflgJ+QpRvGmK7vEq5k
	 W2lS56qZ1fCBfhPb65ZWP/uRVs+LmNiUnipL+3LvfaMptYWx4oJDh6i3Lo4Z6x8jiNXNh
	 N61OuJamOqg4xWHQnPM6FcPshPLf9/ujlYQF/aqxepkGPa3iYNNjVmDoBs4FbQBjoZ479
	 x6evH6ifZ6EG7eQcAH9kNEZj/rG1ycNl0QZqMSr5wvvyW8Pxs+pmDY844w+2GdU2cZMjD
	 m0sX+cJNdIYbbaKFYH3id0LSfyhxwNiv7W/Abq1qHoT7T9TC50cLlsENeO7fVVXqwxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870258;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S0acPnlP0iV4l14pkqFont0JxRMUVVKJeDeW8DxDcNc=;
	b=stYoUpYC96m3c4euSfzxfqT0ikr6FF+jxnKSba5oEsT/acB5h0FVp87LaSrlRvq86g8n
	 ky313DZ9/antdktpazMXIXJr2+GVYmr/uIEB6dc9RkLwemUR7dZX4XCgnWYL+fIERGhkM
	 r5CzOgwPRIdZbCF5xcgUHnkfGlfyRkP1MMo7MRhXjnvbl2L+jjSpITkvL56HODNuT3wGw
	 7qAI10z3TeglzoQuSP/nRHHSZo6y75iQMQP8GVm2nF7XUsc541pnUK1ZrFkHfmX9eahDI
	 P5YetOGTYUL4PJ5Akjz54FZs3N+eI+lEo0ZvqiN413ilwM0s/sluUsapzcYEP4rLb8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFWGzYyx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC73606A323;
	Mon, 16 Nov 2026 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFWGzYyx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574741F000C5;
	Mon, 16 Nov 2026 23:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794870257;
	bh=S0acPnlP0iV4l14pkqFont0JxRMUVVKJeDeW8DxDcNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TFWGzYyxvGEgfi/6lnZ/VLb1khT131zO9GI+vShC6DPINblSIjN4nb6UN/1TjKxvn
	 E8OXYzShUMq4u6eGOktjoGvTIvV594e56+lDVjrCRMLWODC7rawt90CsbcIf7Deoua
	 1uz5m0VZ7QfG2BTcgbfho5oD3NZoL1ZqTgWS04Xg4Rn+pDAmvKk9QDp/ep8GC9uiH7
	 lIG3oazl0jiAx3RqbdMiQ8xJ+TMTso93EDWhDj9/P9id8yJr5lIScCYFLJ7WCGxcoM
	 JHPtYnKPWd+AmgYc+wo/k+WB8ANju9KA31t9elBF1ldXB5NXRaimyEc7XdF8T2A4Yk
	 QoGylNVtuYwWA==
Message-ID: <sashiko-outbox-217846@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] mfd: mxs-lradc: Pass parent IRQs to child
 drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio Estevam" <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261116224803.61154-3-festevam@gmail.com>
References: <20261116224803.61154-1-festevam@gmail.com>
 <20261116224803.61154-3-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:04:16 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mfd: mxs-lradc: commit message mismatches MMIO mapping in
  mxs_lradc_probe()
--

commit 7eada64ceb6fbaa203e6af701a0c04cb0afc5c33
Author: Fabio Estevam <festevam@gmail.com>

mfd: mxs-lradc: Pass parent IRQs to child drivers

This commit resolves LRADC interrupts and maps the MMIO region in the MFD
parent driver, sharing them with the ADC and touchscreen child drivers via
struct mxs_lradc instead of passing child platform resources.

> Resolve the interrupts with platform_get_irq() in the MFD parent and
> store the mapped IRQs in the shared LRADC data. Drop the child IRQ
> resources and duplicated name arrays, and have both child drivers
> request the mapped IRQs directly. Use the MFD memory base support to
> translate a single relative memory resource shared by both cells.

[Severity: Low]
Does the last sentence of this paragraph still match the code?

mxs_lradc_probe() maps the MMIO region once into lradc->base via
devm_platform_ioremap_resource() and passes NULL for mem_base to
devm_mfd_add_devices(), while both child drivers use lradc->base directly
without any IORESOURCE_MEM resources in mxs_lradc_cells[].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116224803.6115=
4-1-festevam@gmail.com?part=3D3
