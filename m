Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54E52ED5E;
	Wed,  9 Sep 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961198; cv=none; b=OgHlc13uu1e+eMxpqwwtvLLTe9pqPyw9BDdfSsbMOl3JaitP4/TdkJukUj1N1KAnf4xF4si2Ax1Q11wfg0T0MO/BeO4wgaTN/VHpzLB6v2j30/7zBsUixr7CpCoww1DwdC2L72yDX+Ps35AP8jQWq0L+QujEnnmn/f0EAkF7lcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961198; c=relaxed/simple;
	bh=WA4y5vV3v0lUi1+6hd/3b8x4mAITSQ81uAkJYhdoYXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sRQpeci/7KBfrpkfg/wn5AfjY7pdgknBVbNyD58Qi6Ib3KqQtrJUc9axjJgr+NGy5wz5YTyCQcJPd2BFmmiBMKvi4CektzzsVLCC+lMvn80aDotlrr1WcKYIHSto89iw043LJkBua/WyerR7a3qJOlcy9gdf34SAH35kvbAQNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kK4Zzt0k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kK4Zzt0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DD51F00A3D;
	Wed,  9 Sep 2026 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961197;
	bh=WA4y5vV3v0lUi1+6hd/3b8x4mAITSQ81uAkJYhdoYXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kK4Zzt0kKlS3vN2zHQ8dhJw4lH7McJ00cIC+ipL9koVVCN/bhONTQ9VHYEId7n6aV
	 +BetxU1jr2pmTqo9KaZQAYP9MCk5pzScSUnfq7tUoa1/YH3Pox8UGMZtSv8oo/2S07
	 KKyQQ2oYGRgGRLjeVwR3rRTsj4yaqeoUofERsqHzVOBtXNMid9FC+iI+DodTsvpu/h
	 +kLor+mUrSdMJI0qR6XqXfJRMp5ll0TVND5+7dZ1g+sYDk+6FhZdMJ/9UVizatGX+K
	 5YvNhH1wrSACnUHH/Qj5z0FT6PncVAkkbMS28iCS4Jl6xFhQajRMwejA6/aYRdJGhe
	 f0Jpdh8gbMKqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/14] mfd: remove unused rdc321x southbridge support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, media-ci@linuxtv.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org, linux-input@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, dmitry.torokhov@gmail.com, linux-watchdog@vger.kernel.org, lee@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260909132153.1596191-3-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-3-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:39:56 +0000
Message-Id: <20260909133956.E4DD51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete removal of RDC321x support leaves dead reboot fixups, PC=
I IDs, and a stale MAINTAINERS entry.
--

commit d66c645a0b11af3b988f3b3f1fe1a950247d9884
Author: Arnd Bergmann <arnd@arndb.de>

mfd: remove unused rdc321x southbridge support

This commit removes the rdc321x southbridge support (MFD, GPIO, and Watchdo=
g),
as the older i486 chips can no longer boot Linux.

> Remove this driver, as there is no way to run Linux any more on the
> older chips after i486 support has been removed.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[Severity: Low]
Since the entire platform and driver support is being removed, should we
also clean up the remaining dead references to the RDC321x platform?

Specifically, the reboot fixup code in arch/x86/kernel/reboot_fixups_32.c
has a rdc321x_reset() function and an associated entry in fixups_table that
appear to be left behind now that the hardware is no longer supported.

Additionally, the PCI_DEVICE_ID_RDC_R6030 definition in include/linux/pci_i=
ds.h
is no longer used by any active driver.

Finally, there is a stale "RDC R-321X SoC" entry in MAINTAINERS that might
need to be removed to complete the cleanup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D2
