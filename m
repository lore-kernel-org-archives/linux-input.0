Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D442C159A
	for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857884; cv=none; b=G0vL85WievDrv3mTtiaDBXrCKWkJKQYqJRWyoIatJeLFFkJTXRBn2lfG8xZbxamb9RIU94RXdHuypy1v5IcfWQu4MpNM7yQjJ9nSz+fGl2QzTBIrvvw7GV7th5uiC/SSbHieWNzyR5T7U5V9W1YjvNYBDXVIcggX2wQnljUUXRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857884; c=relaxed/simple;
	bh=NI+dDSFb+B4wbwRhOwzVtiWfHdckWtXrPaqJM/br4Gw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W75iCgBh1oBKnW51806PJEYzFWRCXmILhX0opGEFeb1g8kvLXsRKX8b2kfrbuPWG3RxGvidwV0VAU2+fXvpMZaX+t3p45ZN7yt53fKAw4B6C5wMmY/guTYiLeZhRYQ2O/wuRYJwknjj7HETfxJe663CnVt3Ef7NQOxxWXKzMqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BuLAqCs+; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BuLAqCs+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A8ABEC40683;
	Mon, 30 Mar 2026 08:05:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A8E525FFA8;
	Mon, 30 Mar 2026 08:04:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC6F110451B68;
	Mon, 30 Mar 2026 10:04:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774857874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=e9yXhXYtA6S7FCEzYya4xIi0QVtCAmYf97xEC+a39pE=;
	b=BuLAqCs+HBjveDvPLCofBbG3aZy+a93jX/iMOoC574ORAOecwYhDZ09PuPx2PYleznVEuX
	F+SVcj/mvXpWnUqakXVfj+24ofCXLNpg87FiS2fkHDdD+N3uvb1Bn7M50LKueAwkimYCwo
	F/ebg/i4BGA104opCHdNPWw1/pDQjewsSbM95bsM5WAhx8lkUEI5YEXlVgKMOp3K7ZrEWc
	gVT/CrDIU/adbPBjqFewfx+8OGL8KnGZz9vUtT3JdgwqkiZbe7+ynqPhXmf/ozL6pj7INl
	VBJN8D7+dUhrOX1ksxOMMzZVABbl7TaBhcjPKVIQuxBi1Ov5yE84uCqiP9rQTA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,  Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,  Bartosz Golaszewski <brgl@kernel.org>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mips@vger.kernel.org,
  linux-input@vger.kernel.org,  linux-gpio@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] MIPS/mtd: Handle READY GPIO in generic NAND
 platform data
In-Reply-To: <20260328-mips-input-rb532-button-v1-2-98e201621501@kernel.org>
	(Linus Walleij's message of "Sat, 28 Mar 2026 16:55:48 +0100")
References: <20260328-mips-input-rb532-button-v1-0-98e201621501@kernel.org>
	<20260328-mips-input-rb532-button-v1-2-98e201621501@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 30 Mar 2026 10:04:30 +0200
Message-ID: <87a4vpbv5d.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 28/03/2026 at 16:55:48 +01, Linus Walleij <linusw@kernel.org> wrote:

> The callbacks into the MIPS RB532 platform to read the GPIO pin
> indicating that the NAND chip is ready are oldschool and does
> not assign GPIOs as properties to the NAND device.
>
> Add a capability to the generic platform NAND chip driver to use
> a GPIO line to detect if a NAND chip is ready and override the
> platform-local drv_ready() callback with this check if the GPIO
> is present.
>
> This makes it possible to drop the legacy include header
> <linux/gpio.h> from the RB532 devices.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  arch/mips/rb532/devices.c        | 36 +++++++++++++++++++++-------------=
--
>  drivers/mtd/nand/raw/plat_nand.c | 24 +++++++++++++++++++++++-

Fine by me for the MTD bits!

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
