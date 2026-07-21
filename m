Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C283C0A14;
	Tue, 21 Jul 2026 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633105; cv=none; b=AS6kwlWjQQ7rfc0wbhIBC9oUSn1wEAJYU/UhMj6BUfj7hc3xi3QdFF6rlZ0zY9pUqV8Fvco1xQaXEh+Y+JJNZn3GDUJtACPotKcIxji+zp7OSQPwUSHEu3bLXx4wIvYl2KF9vb8j/QBdP3LWOT1e4qzMEbpJzEmFAxv5BD2uoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633105; c=relaxed/simple;
	bh=gXaREL3EkpKWuDwmnG5P1zsk8plAbmrbEAU7NWAipFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uXXqGl3P0wWZLAM26lhadCaBu00Rk2FsptG+Q11WNV3TDetZE/eUkZwRJtSoWSm6dB9a76cWKan7VX+LrVGcwxoMmkqfDAC+X1Ux39+8Q0g6IHZ0aMAlXLelnsTWD6wpa/EpVb6FC5R+vJ8y9ozDBBEGZ1FYSY/JzxbmMGNS8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcKs0izP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcKs0izP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC8F1F00A3D;
	Tue, 21 Jul 2026 11:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784633098;
	bh=gXaREL3EkpKWuDwmnG5P1zsk8plAbmrbEAU7NWAipFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TcKs0izPI3yf97hq3tAGIIIX1q9uBp6hcsg/Wx0/VJ3rah1jZ2IDcEGIBpuOR8OxC
	 WXbpOVOAfD0PxA6shaZltr9GaLzpkiTuB6ed9ovJDEpnbRYnhEHiT380F9yPYQdN3J
	 BphgZr6MK3g7CHuQBBl+8Pm8D8IHsQzFWVi0A70sSyflF+J/z5DTvuqsjHyxrcNaWq
	 aBkk0G9T6lN/gAtJTTDrPjyrj+UMSxGu9vEw9cnynhxJOtaAaPsW+ifyELf1QdFc08
	 9BpX7IEgBozthj5hjxESGmQxHEvzQqb86C20XnVe21eCfw5upCcyC160cXsZwg5wUr
	 QFa3IEtJBt+9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] ARM: dts: ti: am335x-guardian: Drop unused
 isink-en property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, lee@kernel.org, linux-leds@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260721112133.70382-2-egbostina@gmail.com>
References: <20260721112133.70382-1-egbostina@gmail.com>
 <20260721112133.70382-2-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:24:57 +0000
Message-Id: <20260721112457.AFC8F1F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721112133.7038=
2-1-egbostina@gmail.com?part=3D1

