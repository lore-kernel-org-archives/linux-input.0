Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4B233932;
	Wed,  9 Sep 2026 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960912; cv=none; b=uwgoZyigVitcjM7oNBI8uzQY14cyOoC0+s5Gh7Xy2GQcRpdIU8EMhKBUdFQGz0DcWJM0XiP006XakAzBcSKdCRU1p5nrF7E21APkPp8HacZyCEmvPsMwCSJZuzY8GEmaahYO/DBlGSa+VhDeQf/9gn02CnqLtLGt/iLhBsKCKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960912; c=relaxed/simple;
	bh=6IPZb+DjA9Xe9u9zaVGENONz/pk2+GSkOj+Cx5WgyXo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ULxbO42D6gFqyJ1hn3PdIHpH6ZpiYRAxchKt5JHFeVMIRzUAT0zx/7Zvjp7I3kczqcFQqh9IOHBGlXe7RwrNtgDh260CpfEazjAXz0mTGen50z3ZWrf2y+zIOUsg+liWXOkAhl7obacFenjxogYdRBNvW8Kef6xQdj9STJqPgdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsVvuv+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsVvuv+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67B61F00A3D;
	Wed,  9 Sep 2026 13:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960911;
	bh=6IPZb+DjA9Xe9u9zaVGENONz/pk2+GSkOj+Cx5WgyXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QsVvuv+lnLCKRB2lb8hn9DjHf8JXR5Es0JW+5chU721mxiR959klqmSxguhaQendf
	 lQvecJX13uckW/blp1eNpYylQeL4I+dBWeI1n7BxY0mxSNu7Lr8LYRnRJCp1HWmk0m
	 YdEJKnsz9knkLFd7QWGdHeS2qOd4I8bFlSbmONTHpv0SuaaUMB5+alVv/tRj6jTbfq
	 lRrqrbFjAKW+GnTAfHhRsbtSZnYMX/+lg5AoPslxe2GjIg/+h/x6KueGTcR0yUi+bt
	 NV8gi6tBiEKRNPI4pfb4iS9YJyhQGBhsCnliPn8WL1eWo4LNnMDJ7qSFpq750776c9
	 uA+sgHdzKEIgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/14] mfd: remove unused lm3533 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: conor+dt@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, mfd@lists.linux.dev, linux-hwmon@vger.kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, media-ci@linuxtv.org, linux-rtc@vger.kernel.org, linux-leds@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260909132153.1596191-10-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-10-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:35:10 +0000
Message-Id: <20260909133510.E67B61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Leftover sysfs ABI documentation files for the removed LM3533 drive=
r.
--

commit dd454943eacd9b46650ee0d6e1e22a90fadba749
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused lm3533 driver

This commit removes the lm3533 driver, including the MFD core, LED, ALS,
and backlight components, as it has never had any users and lacks devicetree
support.

> mfd: remove unused lm3533 driver
>
> This driver has apparently never had any users, as it does not support
> devicetree probing, and no lm3533_platform_data definition ever
> existed upstream.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[Severity: Low]
Does this commit leave orphaned sysfs ABI documentation behind? The patch
removes the driver source files but it looks like the associated ABI
documentation files were left in the tree:

- Documentation/ABI/testing/sysfs-bus-i2c-devices-lm3533
- Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als
- Documentation/ABI/testing/sysfs-class-backlight-driver-lm3533
- Documentation/ABI/testing/sysfs-class-led-driver-lm3533

Should these documentation files be removed along with the source files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D9
