Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009929;
	b=s5yDYztIk411a7dTm9Xjj0tKFDvDqZOHvmvMPYGPtEDegKhFAerrq5Uvs4TERDnDpULr
	 wkm7nOGKFAtXwLe2Qif2Mxm8VV8N+kN1ssWFeLiIEV8HW6yfsq6seyu4hTl1wYoGZtgoE
	 njyWeR9d8M7a9GNjYqG3/6/oiweJQcGsgkDs9/5hjHa85wL+j3QXiHe47VH/x0Vp63d7O
	 gSp7P2EOJG7C+O1yA/GqpqcSYJNZRwDwmgfvyt5oWFr7Ju4gX/bF46ZyijLlzseEYDecC
	 Lj6v4NsDr6Avb6eRnPE9DQwyqS+rBv4nexV5wpG/lUO4RO+EceFqb1B62cOWne0Bfjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009929;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Tge/JDtNehakL1B5lgPqMiIpy6xKwV9tSOLxSBV7ThU=;
	b=o2SlBoZAVuKqLue8VhgdhXL0sRv3mVP/qDZJ/QypDao9eHtiCqfylV2G/j8838Q1yADy
	 NzsoxK5w9K7jbs/qJlL5VNWACCvb8xsoLQtvtTABXtxkNIb5vetEGtXat3QkXkZW3nZ+6
	 XWxZkqndtItnsjpGoC6GsGlGBpRM5JuizXdz8EizYyBNWfB1lWmFvpxvW0pTuVhsIiCkI
	 lBBaI5dcnTEaZMUaNz2lLZ+rP2AjkhmcflNDxQtsGvu7c4q0gceSNVnLRSJ70wc5F4rZc
	 HnHESWsKoYUS29ApV0QTVFNs+rQZKMmNpzzqCLW0FjDi9nG6MUIAmQ18he6QxjD9dNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7HE+05Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C6606A320;
	Wed, 18 Nov 2026 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7HE+05Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425071F000C8;
	Wed, 18 Nov 2026 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009929;
	bh=Tge/JDtNehakL1B5lgPqMiIpy6xKwV9tSOLxSBV7ThU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m7HE+05QiUq7inf+28k/xQbhjk2Gk8btDAkEMG5DX0GV/cSz93FbX2NwUAx/fYhw8
	 /zOgG5IIT7+vyjybbZzZKeDlpeiQxUxVbVVN3/yTy3PRAPLCdjLwjxry7HROY1zD2E
	 AP1TwOoUefnaEwRveNmbom4bV3nog/dz4TiEYgnSdL3Xgx5U5eS5624F4Qp9Ehp7kt
	 4OdYaYGxq9v27Kxs/0XaNeYK8ni6jr8cMsGX2AE19xP+Aj9xaC2O8uv3zSMv/Zk4MB
	 U2GG7iPLwb+vT3MzkmEPkostKm7g17yXPqVc8Vg3oi81wOJLRdWQ+50DBmOKmGQSAo
	 bI5Mx654NfHpQ==
Date: Wed, 18 Nov 2026 13:52:03 +0000
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>,
	=?iso-8859-1?Q?Michal_Miroslaw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, mfd@lists.linux.dev,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, Input, LEDs and Power due
 for the v7.5 merge window
Message-ID: <20261118135203.GB98456@joneslee-macbookpro.roam.internal>
References: <20261104122606.215629-1-clamor95@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20261104122606.215629-1-clamor95@gmail.com>

Enjoy!

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-leds-power-v7.5

for you to fetch changes up to db6674a08304d03a194f5e09b7543323462b3516:

  power: supply: Add charger driver for Asus Transformers (2026-11-05 11:18:09 +0000)

----------------------------------------------------------------
Immutable branch between MFD, Input, LEDs and Power due for the v7.5 merge window

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEdrbJNaO+IJqU8IdIUa+KL4f8d2EFAmr9rC0ACgkQUa+KL4f8
d2ErjQ/9FdtsxmQO6kutCzEoBE2ka6/0khvWwQd3N/DwRcwqPNyeySlSph4IbA1e
2s3xxZRVOifOEOEmD/IQxbbUY35tJtge6KpIg+nVUVc2lI+GnV1LtA/mMkHG1CLQ
lUeNfOuZjnHqW1HvmORPrcChsHncofHa8yN53d7iykYvPSSxKcUzEVL97ijgdgeW
cajXj/EMx716qjj0j0cuulbXrScR6ySMiGeYCL8wQpc230x7w2qrBfj1flhdaTF0
SrZmV7UVeT+ogBF/L1bz+jq1vT4om9yCGkVt2+Ju6bY2fWfMJNnpwuJ9a1E+nCtk
b/0IgtKA7lVNAhJUMTSzg4GCtMyaE5LoOLEZca1ZgNLSjxKqicT55G5ZaKN3sBtF
2SW51u6SEO5lRZYnsth6bnCQTlfppRgw7oBuELfsUZ6esmyQ2zdzCrM8obqJBGN1
ES5hUC1twiw246imHU6Gla1GllAPkTR/Ck4ZHVJwPXVe3tBB4d4AouAZjjv45frC
kwhxMc8h3UpJ4YTKagEcCgz3Gj45oflv4Khcl8aH5YhY8MUDjIFvZU7M/OahiheN
WxT65pL55WNVmC6gNyEsqFKNkiGukf2IeuHRvWzSrLuy9GEa/RVk+w5JJmngoqzB
Ej4GtEu79gXcuRxd08AnFCc9P0zF84aaZ+q5kVH+0juFX/wb4aM=
=sFQA
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Michal Miroslaw (6):
      mfd: Add driver for ASUS Transformer embedded controller
      input: serio: Add driver for ASUS Transformer dock keyboard and touchpad
      input: keyboard: Add driver for ASUS Transformer dock multimedia keys
      leds: Add driver for ASUS Transformer LEDs
      power: supply: Add driver for ASUS Transformer battery
      power: supply: Add charger driver for Asus Transformers

Svyatoslav Ryhel (1):
      dt-bindings: embedded-controller: document ASUS Transformer EC

 .../embedded-controller/asus,tf201-ec-pad.yaml     | 119 +++++
 drivers/input/keyboard/Kconfig                     |  10 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/asus-transformer-ec-keys.c  | 216 ++++++++
 drivers/input/serio/Kconfig                        |  15 +
 drivers/input/serio/Makefile                       |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c      | 258 ++++++++++
 drivers/leds/Kconfig                               |  11 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-asus-transformer-ec.c            | 114 +++++
 drivers/mfd/Kconfig                                |  16 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/asus-transformer-ec.c                  | 551 +++++++++++++++++++++
 drivers/power/supply/Kconfig                       |  22 +
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/asus-transformer-ec-battery.c | 289 +++++++++++
 drivers/power/supply/asus-transformer-ec-charger.c | 208 ++++++++
 include/linux/mfd/asus-transformer-ec.h            | 100 ++++
 18 files changed, 1935 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
 create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c
 create mode 100644 drivers/leds/leds-asus-transformer-ec.c
 create mode 100644 drivers/mfd/asus-transformer-ec.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-battery.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-charger.c
 create mode 100644 include/linux/mfd/asus-transformer-ec.h

-- 
Lee Jones
