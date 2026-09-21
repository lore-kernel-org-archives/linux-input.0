Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B54D90D4;
	Mon, 21 Sep 2026 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015122; cv=none; b=D+xxOJEuylfHtGc3vEOlqDZ4NqhSDrvkzmLJJlRZ4IRv/y9l3S+dxxfgLRllnEk6EnhHELrKrMunzjXW7Ircw84Isa9m1JI2qCkBL+hKLk8qw8CqZ6UySDruZ2fUWgk7EXxNktwSvKDJp/TNoWpW7iXqQ7DZ+2aPmVmbTmEhYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015122; c=relaxed/simple;
	bh=ldPfOGDHEqy0DlvoBCEvjq6kprrJml9/imvyraCti+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lYAiLiiP1UeL7b0TV4M2a0fSYJJ6hHGewO7CdE8dQ1WENJxnOCs3357BVtIEMnYKWv8tjlbyAZFDoQvqJaG9EutpvaE77gDjHNw3FammPnVUf+Ahgl2fE/nbrqC8kLoyker1Rs5Lty6DMlU9I785CRdYYvNtptR62ddOQwQPSws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCM5jMah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCM5jMah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7192E1F00893;
	Mon, 21 Sep 2026 18:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015121;
	bh=ldPfOGDHEqy0DlvoBCEvjq6kprrJml9/imvyraCti+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hCM5jMah4fMaUAPaTEtWW7+M0v7w7HUvU7JGRKKa41RQUMydnVu7qQqc1r5aPb7Se
	 TRCuBQ26LjYVqprAZCTbGpUcCprOQAv97Lg0b6WHvvi/tLTJioJJC4mHOASqO12V5N
	 ujU7uizDyIt8rKt5VUrp8vH1Xtz2JKmUgq1zthj+RShvSJcOHoxwpmgF/d/Bu3k9Cs
	 cbHTOnB29jA3CgtKywiRkn8dbEdtxrA/xYRq9YfjwCu8tO7PZNyXBGktQ9VitWtyOW
	 zDmCKB0XDul0bUVR+CCj5Do+ZBwHxA5Sec7JAHhGK2srYXyMi3u+ODQrcqjfNRghhn
	 jWrfdveasJgIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/19] dt-bindings: clock: qcom: Add MSM8952 global
 clock controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, mfd@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-1-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-1-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:25:20 +0000
Message-Id: <20260921182520.7192E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add a device tree binding to describe clocks, resets and power domains
> provided by the global clock controller on MSM8952 SoC.
>=20
> MSM8952 GCC driver is mainly based on MSM8939 GCC driver.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D1

