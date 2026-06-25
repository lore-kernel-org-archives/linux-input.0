Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599523806DD;
	Thu, 25 Jun 2026 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375693; cv=none; b=h45IT4cRuZk7VUAY5yYoG6NVoA5tWMZRaHe1zqYJyrrT+Icq3i4ay+n9jBxNSZA34LqbWZFLL9FuvtgYDFziV4qoCrz4mPWpa0WBxboB7DgmqwQ7Y00i7+RU+U036LuevMSQ59GhaMiwOCIoV9ogMZiBMZ+B4blXgXbMO4PZ1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375693; c=relaxed/simple;
	bh=Wv//trcUXmosHJOD5R3PIl/iK3oKG9bDYcWIozbHXjs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I45eSQXMJLTA3b/5J7/IU6sBx54piigTonbcX3h7aiumhuZJ12qO8rvyZhXo76Krr+XjOSDIO/mqvVdxVNnYZvt8xamHQC+k7ImINZWVoR3UtAt2hlUXqhnmeWMYuVCXvELX/9cd/YIApZDl7VeySldI8CCwuioDGcnptau7eys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7Zc+P4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7Zc+P4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A941F000E9;
	Thu, 25 Jun 2026 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782375692;
	bh=Wv//trcUXmosHJOD5R3PIl/iK3oKG9bDYcWIozbHXjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i7Zc+P4sWIC0dNEZ7pUsc5vIip2pLPxFE0pPu5CS/Ul4csRS5087T2/XxQR3Mxgov
	 nTuN3C+qHqJefiiWKj/LHlYmrL0D/F4IfaTHQbVr3XM3nyj6Y8ZhZDvLutZXFhx/C6
	 Haj6Q6LJREb+X+0Jj92M40/Xk8kkmguudWpF7ASN57XrfI16Ho3vd0ZgnyFLQUky95
	 Ou/OazDwMfGhZtm1q+uNd9pp6UOMUvRvKXJQACpatYShEp3yhuMhCTvacRBPQ0oY/J
	 LfXlx5Gt1TBpO64QsGyHNGGI84YsVHFQA5F77xlJ8FxkVOZGOxsN+UchHx43pfW3US
	 32CRO0Y5g9GLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, linux-input@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260625081529.22447-2-clamor95@gmail.com>
References: <20260625081529.22447-1-clamor95@gmail.com>
 <20260625081529.22447-2-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:21:30 +0000
Message-Id: <20260625082131.71A941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Document embedded controller used in ASUS Transformer device series.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625081529.2244=
7-1-clamor95@gmail.com?part=3D1

