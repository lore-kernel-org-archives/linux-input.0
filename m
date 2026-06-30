Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD86336883
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832206; cv=none; b=pbH6S/zv/I8kWeSWmhxwBYwNCCELPY3SpptTQ/OQsiMYZBkUPhHrkAd8AEirZejW4yIiojeixX+YL7Jy99g6YATSkmuqBYWcvhB53aSxVtS+bIgougSCyjaveR2PispffbNisuoqJFmbVjJ8/qkdSPEEW1lO04ncFeu3x/hjuxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832206; c=relaxed/simple;
	bh=z66QHhYj7Tm3YtGWzwssL7b3fA5zmeuE8Ac5ksYkkWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bHdf1v4WkZhZysG6bZNWBCGwARHfmIkSR4Fx/C5pufANOcLrBGRg7ZG79NryzeMhvgUXl8fbP4aYMJ6dsKDNwLvWqyXxRbSRZiBljyqJ4qL62W7rLfaJd/x5scxpFZ7KrZVbfsfBAqnasdIquC5SkpsbbbUnJS+jMJaz685XsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu13lGeU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu13lGeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32C41F000E9;
	Tue, 30 Jun 2026 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782832204;
	bh=zIgx+jyffOjQjUl6XbZQ3QjMViAQCDKhNHF6OZGA67I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gu13lGeUzLyRB6Fn/hBHYsBDFHaByqAgiG1O/URcWtxJ3z4ms5GbzRWVM1PWeM7vg
	 FEo+/mBr8FpvsMiKXsSSkbrq4m4muQLW+bR024vgynXBy0G7o84JBR466n8k6bS299
	 FyZ1lHQFAbHWgd1YVspDNj8+DTsrj8P5dN272ZTkC4XRFTMVUJwFnPr0gY3ygYSyWS
	 sWocapRU+xOEgNe8BzOu5xKgCvI/mFNujggd6ckgMeqnDQO8IqGtEd+lpF4BcNSV++
	 PR0zrzIotL9HzJbACufCRIoE3+hUCFOZtMhoOSTNPz9RGdMhSb7G3zWnpmyRG3qTUz
	 v/4fHT2VdUtWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: cleanup help indentation in kconfig
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julian Braha" <julianbraha@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260630150134.514348-1-julianbraha@gmail.com>
References: <20260630150134.514348-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 15:10:04 +0000
Message-Id: <20260630151004.C32C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The help text for HID_VRC2 is incorrectly indented with 6 spaces in=
stead of the standard Kconfig indentation.
--

commit 175ea4114d8a3fc5eba72e7a349e9cf65a9b45bd
Author: Julian Braha <julianbraha@gmail.com>

HID: cleanup help indentation in kconfig

This commit standardizes the indentation of help text across the HID Kconfig
file to use 2 spaces, resolving inconsistencies where some texts were not
indented at all.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig

[ ... ]

> @@ -530,11 +530,11 @@ config HID_VRC2
>  	tristate "VRC-2 Car Controller"
>  	depends on HID
>  	help
> -        Support for VRC-2 which is a 2-axis controller often used in
> -        car simulators.
> +      Support for VRC-2 which is a 2-axis controller often used in
> +      car simulators.

[Severity: Low]
This isn't a bug, but did the indentation for HID_VRC2 accidentally get set
to 6 spaces here? The standard Kconfig convention expects 1 tab plus 2 spac=
es,
but this new text appears to be indented less than the help keyword itself,
which contrasts with the commit's stated goal of standardizing indentation.

> =20
> -        To compile this driver as a module, choose M here: the
> -        module will be called hid-vrc2.
> +      To compile this driver as a module, choose M here: the
> +      module will be called hid-vrc2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630150134.5143=
48-1-julianbraha@gmail.com?part=3D1
