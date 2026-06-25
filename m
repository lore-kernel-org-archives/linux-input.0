Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A62ECE93;
	Thu, 25 Jun 2026 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375811; cv=none; b=mc88+E3gWBMg73gBX+6B+UhGg417FfLROp1fUkgOnw90ANEFFJ3H0rPJ8d6f3MJ1CKoQmtIAaA6cJgueBfy+3Mlb+dh4LoIxVKBuHR+ronZKq4aPcH8zzXheFqMwQLBzKSzTM4DVBVyM/H80+RMhAbvm7XVsCH36aOA9pzTuKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375811; c=relaxed/simple;
	bh=Za0MpbPDeLiXLY+RmvqoHynOx+OcOscyTWSLCe8fMSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pRHKzQgvNaq2bKKp9Hdm8OXMypPXRxhl1calDIfixw1hzQzy11x0HH0n4LA1k0ZICkzGp0Cr+slpVsc2WLkqZ59cpATa6sJdYDGtSi3esFxkVHfsxbp3862IwbtX+7I69rYvo3VtUYq0yPuAsdlwvSWd3u1en8Imu+7F0ckIOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQjtLbho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQjtLbho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BFB1F000E9;
	Thu, 25 Jun 2026 08:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782375810;
	bh=Za0MpbPDeLiXLY+RmvqoHynOx+OcOscyTWSLCe8fMSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BQjtLbhod5das5RyL0cOIj6PTKtPli4xcV3xfzZhnfmfwF43p7sqzM/Qw9jvuoPhK
	 7SZufE6HsKcCFLB8+9NYdywszj+FbuJ/F754xg1R5VHeYw1Y18icpNZLs5AEAeJVzm
	 QTNCy9zji3xwbg9/oumQxsQ97cVTwCNwt42AHeXb5x2ezt4lQBlUel0Kron3mXLZ+1
	 71tx7MEFBsT0URCgZsddsT03L0Gn7pZcWXUk1tfEGlazaaQxGhRdU0So3QsTGQVRJg
	 SAhYps62o5chW/qKyGdv7IRRa+LodTn3TGCSdjPregaj97LZdjKFWmkIp/U6KdDcgq
	 PJMXxdMvhNtqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 7/7] power: supply: Add charger driver for Asus
 Transformers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, lee@kernel.org, linux-leds@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260625081529.22447-8-clamor95@gmail.com>
References: <20260625081529.22447-1-clamor95@gmail.com>
 <20260625081529.22447-8-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:23:29 +0000
Message-Id: <20260625082329.B3BFB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>=20
> Add support for charger detection capabilities found in the embedded
> controller of ASUS Transformer devices.
>=20
> Suggested-by: Maxim Schwalm <maxim.schwalm@gmail.com>
> Suggested-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625081529.2244=
7-1-clamor95@gmail.com?part=3D7

