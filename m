Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCAF46D56E;
	Wed,  9 Sep 2026 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960644; cv=none; b=LTdhb7RAJAzhy4xpH++e3k3pRnuGs+RtWeLfBo2Ucw7ZHuIj6KnrUKOlP703g65HzYaR/ORCf2qqECfwc/BcyCz/YaTKkXDuWvCZm7/4gwhqcOyN2J++2vBnbSkcsQrnqs7nrWKBDX7VR//hoVCfenuTgRRVIDgp6QbDkFItdpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960644; c=relaxed/simple;
	bh=lfPcFf9koNkKSbGEgY2V9DzwoXfXgtwsL3fbXf3UeTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qCGjpGkjYtuU6oPUVZ+kLV9aX6+GHuz+q2cgg+OF1YCmOyG6TLwekcazOUlXWqIP9xNpqxgNoe6B3i+ZxK0ilDDbsmoWtZ1NE7uqcuWaiJE6foCBJHUs49+v/EKv1bt2Hm5qgFDVViVg2znMZ1fpQnyvDjL0bDNTpi21rXIPF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7dVNgZm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7dVNgZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDFF1F00A3A;
	Wed,  9 Sep 2026 13:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960642;
	bh=lfPcFf9koNkKSbGEgY2V9DzwoXfXgtwsL3fbXf3UeTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W7dVNgZmo9CpEWWWvfGOjYw2tv4EqENvzwHW1NUCK2yuCBNtuWvAQwf0VXZMdiXxp
	 TfsNOjMvqcBZKoXWyDa/b7Q9I2/7WC0dwe+IZVeTedDQco7ySdaGxYOgqX3ukIM5jS
	 9AeBa7F2YYZCWJHl6aiVONC01Wg/dHrnS/ARJOoVVONgs6RvvynNd45oHW0dQSMaa6
	 1gL/3OOg6fu2hPf9fqYunXu4X10IBz08Hz5kZOWTU1hUsZ2ySLGsL/tGD+xtpSGPln
	 QfG1IiPaD3mYzC1DjPBsIW5dV83bk7oKw0d80mj+quzOMXDYQLX6X5f0IICYApngRC
	 IA0FF+JCqW8GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, lee@kernel.org, mfd@lists.linux.dev, media-ci@linuxtv.org
In-Reply-To: <20260909132153.1596191-9-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-9-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:30:41 +0000
Message-Id: <20260909133042.0CDFF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This driver was apparently never used, as it has has no devicetree
> support and never had corresponding platform_data definitions.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D8

