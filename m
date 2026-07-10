Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA053DB322;
	Fri, 10 Jul 2026 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718806; cv=none; b=qEv06L7EDs/pVskj+ajvicQoG2AK/LHXWadXsszQgSdfgTRrHfHektDcBy+CRyvHToQGrkg/nQLJP/67wmH1XhA/F0VcZHLEogyUJ6e2DR4OvvsQrjPWJGmSE8NVXEaj7UCLPNtx+Fmizeemwg7xOqaOE3DVsD6WaoAaeHo72RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718806; c=relaxed/simple;
	bh=rRQevHBfIp4Rh5tsS1VfV0h2LUYoJDuW6K7GrGK+C3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SPputG28Q2JUIXbJuLYU1GSp1Y7sZ8BwWXqyXQzpzGcIv7Rns2TDQXNL5cCVrDPFAI70oL9q1iwalHnUj3B0EWBeQ3lk18vyC+FGGYqiqLYt5s4s4BPhjAR6ZwQCBcpCS3Zep0dueDGrhaTH8qNgwmKsUm5s2qAUx/WMU2N1g6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6e2NfOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6e2NfOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F92E1F01558;
	Fri, 10 Jul 2026 21:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783718803;
	bh=rRQevHBfIp4Rh5tsS1VfV0h2LUYoJDuW6K7GrGK+C3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G6e2NfOYLhQvT/m92P9hZpp8tYWhVXXMRvxbmOWuxUisQKdWr3yG+sna6fgsPa8mD
	 aBr4JsF61oIoXShzGwmeEPek0DyC/3832TMZaOY49tz/JFHYBIzVoueHRmmzQgYE56
	 0K2l2qKJidUzvI/OuLtuJEbrlBSpEuree+BVFrt0lnEAYXZEZQd0lTVt0GZ9sxK6cT
	 +hPxO/ls++vrrTekihX0Uponvxngw7EHxrRNtkcjghtZsAG/QERhZc6Shwt8PgMj7l
	 cUjZ4R3v39rG/WAH1qqsoeUrHFIETXcqIlvdwHUkIRcLjmVaR6tpOThFwKicjW404f
	 vioGBFVsGTOFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] [v6] sh: select legacy gpiolib interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, lee@kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260710211854.1371746-5-arnd@kernel.org>
References: <20260710211854.1371746-1-arnd@kernel.org>
 <20260710211854.1371746-5-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:26:43 +0000
Message-Id: <20260710212643.8F92E1F01558@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Many board files on sh reference the legacy gpiolib interfaces that
> are becoming optional. To ensure the boards can keep building, select
> CONFIG_GPIOLIB_LEGACY on each of the boards that have one of the
> hardcoded calls.
>=20
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710211854.1371=
746-1-arnd@kernel.org?part=3D4

