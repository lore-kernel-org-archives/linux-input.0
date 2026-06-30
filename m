Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80D3C1973;
	Tue, 30 Jun 2026 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839244; cv=none; b=M0BWLFzK1ObBbatCIc0KLzl3TVirgkV8YRpfCpIIPcqraJGaaO9iXX49U/+wN79+S9PSVW6wMEnnATyRtE+yean9bUyATmjcn4vQkTSJN/mE0OxMJGgMfpOgPKQm48wVHVn9NeUCtbj1F0DRC0aEa8UsuzieYKsLbd77mOV2800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839244; c=relaxed/simple;
	bh=w9+8yBW/ttWJz+sinWqg0S6VzMzDxjVFTIDj+qWEu/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTSTVdmiXs4Z1KsTRZGAhaAwvwXfFvr2KfNo7PPljmDBOn9TxIsuBbTh4dc6omdfHHGEsnjvWCWZfgQu6f8ISaqys1LvNW4w+pGEKHo10mYzWcvhgAngu0IgGIAHEql8nPQ0uT+G6gcuZS+xgoGiXyOAVL+UKCBNSll7PRn9Lek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNINN85G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNINN85G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8498C1F00A3A;
	Tue, 30 Jun 2026 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839243;
	bh=w9+8yBW/ttWJz+sinWqg0S6VzMzDxjVFTIDj+qWEu/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lNINN85GsqYxbZSA0cZrfT+mS9QPr/3HQNG3o2NNp0YXCFSr834FMhQ2IZNp/fAe7
	 P5rGd1mUhDMbduz0GObTTm7ZDHYzM4Fz79WL5XeRzU2PPe3lh1PGM7YYdPa0LMSLIg
	 8uyrwrzmOFTOxGlKEDkdlT9NKlUzaAI5qo63eppfL59O4YSOQU6ttbW46hVIbp0PBi
	 WCia1Qc4OkRn2tMVURK1Fak2z4ICqLQk6HDy/FpG/AGZ0URhCKccnlAcupJmycj4Fx
	 C6/VrCBFnvwbjpVfmKBdXYAQIPIVJUupP9ylTPYuCnP6vGgKJ14SIO07v/3Z/Uv8DG
	 ilW3BYTjTW+WA==
Date: Tue, 30 Jun 2026 18:07:17 +0100
From: Conor Dooley <conor@kernel.org>
To: michael.reeves077@gmail.com
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: iommu: apple,dart: Add t8122
 compatible
Message-ID: <20260630-drove-uniformed-e27afecdfd05@spud>
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-3-506d936a1707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pZtEHyUigp4Yu2He"
Content-Disposition: inline
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-3-506d936a1707@gmail.com>

--pZtEHyUigp4Yu2He
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--pZtEHyUigp4Yu2He
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakP3xQAKCRB4tDGHoIJi
0gb3AQCSuvpncMB3eYqYLTAgeavZu0OiQNNyInzS7FsL7f6VuQEAqq6x35gFBmaW
Fe9uycvWkdrYfgFhEe8fftzjNsB7LQw=
=lwzJ
-----END PGP SIGNATURE-----

--pZtEHyUigp4Yu2He--
