Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508EE41325C;
	Tue, 30 Jun 2026 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826116; cv=none; b=kN1urEEyBzV65VDPA5GKU4TiXmuWJdRr+G+5GqseoeG8oqXlkiisdq0ufb31fjvsHnA/y9KUNa0PFuHl/oEMK3EQZLOfVZeGfnDK3N8bfaiXc0J7v9MkZOwmQZyLQUBqXCRA0EdlpYmHcqX0jsmmfvcWgk1+1q7g+f8vaw9Tb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826116; c=relaxed/simple;
	bh=8LIzb/kgenqW2kEBZw0WhW8ZoveKr4eYa4oPr/1u6oE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y6wSjLuFUoVJHWlkRckGdkC9pdrubEXOsusnTfMB5CmosLu93h9W+DLMKVTMTlDMNRgeR9nBwwD24+pOYN3cyXKJYlRtvQjKBodW1vot3Qrl4E6no0B/TbMOC/3JyKVECD++41EzCSf/U8YwZMPNPZ5p1BRp860EOJ3j41QkmTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDFGBfqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDFGBfqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B03A1F000E9;
	Tue, 30 Jun 2026 13:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826115;
	bh=bVQOQl0jRlDX5vv0kM3q6D/yJBdPNZlJCO8WFYYkED0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mDFGBfqNpQG+xW4EAMSJGsE42/E2qnxQ5qVsis5khPhV+4/UmiTiRpO9x7saznSuw
	 Swy0z4iscMjE7Dg9u4YjY9LOlvuHUvDUxznH41EdLNT0pimCOF79I9+pXx+ebYQxaZ
	 lGsLozTuwQfd1AMc+PdVAeP0/4aK+jmdrj5iITWieLqfQrdYX07ZbIVIrntuwEzFzR
	 aQqtA4TSfH4hmR4LFHNxClrK9nNc9W+paoqjKVt2tyEPnthdCdYFcnRQ7pS7lho4tK
	 X8WEGlqAz0bKakfLW9q/1uD4ZSFoCEJmB1EmJSfVVdiKNRxeHz5nkYNX30xiomRi2z
	 bGIiB+kAhTSGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13] Input: matrix_keyboard - replace linux/gpio.h
 inclusion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: olteanv@gmail.com, linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev, dmitry.torokhov@gmail.com, vkoul@kernel.org, neil.armstrong@linaro.org, linux-input@vger.kernel.org
In-Reply-To: <20260629132633.1300009-12-arnd@kernel.org>
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-12-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:28:34 +0000
Message-Id: <20260630132834.9B03A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Redundant header inclusion of <linux/gpio/consumer.h>
--

commit b60f4c5bf1d6c83cc34b3ab6030725489bd7c3e5
Author: Arnd Bergmann <arnd@arndb.de>

Input: matrix_keyboard - replace linux/gpio.h inclusion

This commit replaces the inclusion of the deprecated linux/gpio.h header
with linux/gpio/consumer.h in the matrix keypad driver. It prepares the
code for the removal of linux/gpio.h.

> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keybo=
ard/matrix_keypad.c
> index e50a6fea9a602..98d0269a978fe 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -16,7 +16,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
>  #include <linux/module.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>

[Severity: Low]
Does this result in a redundant inclusion? Looking at matrix_keypad.c,
<linux/gpio/consumer.h> is already included earlier in the file:

#include <linux/types.h>
#include <linux/delay.h>
#include <linux/gpio/consumer.h>
#include <linux/platform_device.h>

Could the old <linux/gpio.h> inclusion just be removed entirely instead of
being replaced?

>  #include <linux/input/matrix_keypad.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629132633.1300=
009-1-arnd@kernel.org?part=3D11
