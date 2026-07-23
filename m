Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A333433E81;
	Thu, 23 Jul 2026 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801413; cv=none; b=AgL9LcuzQo7h/ygPNy4iB3+djY9S8zfzl/mmZzhDCXIUFqmzAuGPpPKEb7hVp9hKCf9nZaXyFtJKWOOUvvMN19z8fJVPWKuKytoZX74sXKvy+8UlrJaYToQp1ylJNvAyw97HvvVRkkHKHkxONeYLXARwF8uwUUVE0Rs1qsEsxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801413; c=relaxed/simple;
	bh=ffDOQ3Xv1d+SfNqYpg9VjXhWon0RP1JKCxXKrHBd6YI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iYHQGvpz8lvaFSS80NN/oUkudVvRIWrKqhMfCKT1amJDhODtRx4rlXRwRgWLiwPkR1dfbQAAvaqForxPnbKjXibgswKykkucZJsWHV5COpluRa9jrfpVkFewsQ+Xm4PiIM34MEdQOJFbTDhKrp+hsFPXPI8qf/lf+5DanhHebnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JF7Fb9FO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JF7Fb9FO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4851F000E9;
	Thu, 23 Jul 2026 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784801411;
	bh=ffDOQ3Xv1d+SfNqYpg9VjXhWon0RP1JKCxXKrHBd6YI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JF7Fb9FOhgjvptO5TznRX0DWU5bGGWLhKGi85TJ7kC/WFwDMvvQTDFkbOLaM9tKA/
	 UyQ6ZpkFgC6o2HL5XbLGnSCAf8pYQvWYufkpqL+pn/7lKIsuP4qLmO2o/3Kx+zES7Z
	 yZMym8wEcgjHMqE6d/jvJhHfSU79M2DKzKP6puORrnT/pB/wwNldn0YSYgQPtaprhv
	 z8H1gfn/TrLxGoTgOAN63ZMUOdtQNBVqM2yj579CDANKjCpz7IYwxkKi5R1N7SHTK1
	 NSpR1B7kXNzDpnQDN77MKzjZgjX3axGnfjya0GOXJk/+jdd0lYhVR/XuuNkoZHfRM6
	 7sUWKu8UT6T4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] ARM: dts: ti: am335x-guardian: Drop unused
 isink-en property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: lee@kernel.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260723100605.628882-2-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
 <20260723100605.628882-2-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:10:10 +0000
Message-Id: <20260723101010.EB4851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> The 'isink-en' property is not documented and not read by any driver,
> so remove it from the TPS65217 backlight node.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723100605.6288=
82-1-egbostina@gmail.com?part=3D1

