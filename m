Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F357ED96;
	Wed,  9 Sep 2026 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960792; cv=none; b=obocihLDVrR8RLVS2B+4ez6mu7ZcHQyJ9L9zCk6+HubFXiJZrv9t3b5Bo0W3fklg1YQAu+h9XXh44pIGOVrVy++Y4FLxvHxKez4FuDOWY9ZcOBUNTMQ99Zc1vzN8EylWYAnbtJpcUgzbSaMC8X4MlWIa98eEqYiu4QVRKLoDHoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960792; c=relaxed/simple;
	bh=Wk8PpiCIrPGt/oiboUlDrzwPDaTybYBaRQ8R1roEQ4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eUjqh+PtuJYJbl/poduxx+PzSIG6mXnUp2u0Dy3k6f2XnZV4n1mOwey9LsMbRCUtH4E4Xyaz3CkHoTb2sUX3KPQyj2MIPTAMdTKpB9XqBENs6dOs7F/i4DCYPIgvCtsJ2bQ3Qe4tiWpXlNHne71gZ6NK26U5a64sMoXVvmCKYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCwE0P6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCwE0P6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E79B1F00A3A;
	Wed,  9 Sep 2026 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788960790;
	bh=Wk8PpiCIrPGt/oiboUlDrzwPDaTybYBaRQ8R1roEQ4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OCwE0P6t8ivCk5MNm4nc4zmFE6fsZruYLpah2pjqw/uscfSPzLgUA86s6fNgmtZ4G
	 9qn+gTlmci4eMsu3f3/mNOfnqJlzlaoqeLaFmk+doVjMOIOR8YakJoNA7OAUvxOrDl
	 7WWFhvD4FH/vaPFrFomE1FFlokYgszUUhXtjCj++cpxH/0bPfe3qzddbqpX0WjB9yU
	 T+lFJfrL6Cspend5sG3V1XoUSjfHTZIbb1UyQJV11zmvz4sA7vBqm5u9FbG4b7e4zx
	 dDlIGVupUfJBSGQbK7UFbGnAGMylR3m+oFIY6D8F09QveQ2idjvvBwju4MaoFr6Mzd
	 sKvJNm6/CMXHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/14] mfd: remove unused wm8400 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, lee@kernel.org, linux-rtc@vger.kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, media-ci@linuxtv.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, linux-hwmon@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-watchdog@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260909132153.1596191-5-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-5-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:33:09 +0000
Message-Id: <20260909133310.0E79B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This driver requires a platform_data definition, which does not exist
> in the kernel.
>=20
> According to Mark Brown, the hardware supported by this driver was never
> shipped in production.
>=20
> Since this is clearly unused, remove it.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D4

