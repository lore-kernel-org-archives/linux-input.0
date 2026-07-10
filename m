Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B4395AF5;
	Fri, 10 Jul 2026 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718776; cv=none; b=OGyNZMi+kGLgw7pE5a0Y60fBDUeQX5TEABe0cesO27ljCjuxMT6Hkza9ROR/aR/E+lQf++9ELP/wjcMRIfHUK+wtRY8yb/fkucr5+h/0VgVaz3e5qAjZjQ/5FpNDMscYkvOHtgM8BsBrjwIvaJHGjTHF+wtlyWVmrbje/6TZRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718776; c=relaxed/simple;
	bh=ImAdpjj6L7TePNCLILLQLrYE8S2FWD4xJGB6aL5SP20=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GlIh6+eNNZAQlMfoUqapGJ0iZbNCPBloyaQ/cKoyVcGpZ7t404jFHTBN/Cydq4NOLJGaQ0DCfabZZAl5op3Uth3d1DmZVMaPsXbZ8y3zlhAqZ7eXB3PnVwvKd4859NL/9XsxsQdI28SgVNfwOGDbKudZOT1WC20KUPycWqprAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUjtMk2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUjtMk2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4CC1F00A3A;
	Fri, 10 Jul 2026 21:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783718775;
	bh=ImAdpjj6L7TePNCLILLQLrYE8S2FWD4xJGB6aL5SP20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUjtMk2Zb5L0iHHrWATUMSN6gJGdvakM3vq+Eu4eA/hDZoH6Kcvdb0KuWDw4A6C43
	 njfSUgtE0gkb/gidI+Mg/MsNxpav7Tytj2LGECIyZxV4usJHPKv+v0apsq8LOsiKL+
	 fJRHyclX7C6+irbLKbXGEJzkcIESmQphnX4kXTEXkcbomT2C5S8S44EmK9MWtskB5s
	 fn0JVUzI30IOD6xcHTIjaFuVEOuaoqLFKsjlaVVaWyhOnp4jDhQXVYz0cvoaa8uAFf
	 IPk2P49lXSpMziUC610FLBh6aSt1nq4qDjCi5GwvoA0QNIIJjyY6+hX+NtreAp0eQH
	 q31GfXxYENgyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] [v6] Input: soc_button_array - select
 CONFIG_GPIOLIB_LEGACY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: lee@kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260710211854.1371746-2-arnd@kernel.org>
References: <20260710211854.1371746-1-arnd@kernel.org>
 <20260710211854.1371746-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:26:14 +0000
Message-Id: <20260710212614.AD4CC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This driver converts information from ACPI in x86 based tablets and
> laptops into platform_data for the gpio_keys driver, using the obsolete
> gpio number based interfaces.
>=20
> This should really be converted to some other method, but since the
> conversion is nontrivial, have this one select GPIOLIB_LEGACY for the
> time being.
>=20
> This enables turning GPIOLIB_LEGACY off by default on most kernel
> builds. Since the driver is only used on x86 portables, add a CONFIG_X86
> dependency, which means non-x86 allmodconfig builds usuallly build
> without the legacy gpio support.
>=20
> Link: https://lore.kernel.org/all/ah-1z9LhVG0wtfBw@google.com/
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710211854.1371=
746-1-arnd@kernel.org?part=3D1

