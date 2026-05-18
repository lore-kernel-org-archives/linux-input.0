Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135C21D3F5;
	Mon, 18 May 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098958; cv=none; b=W/6PCuoPlr5RIHgd+jHcdyYq9q4XS/z0PElHEzg6RlOXuHpiZjUkN47M/1i1wPmA/FWiH/9E9DgG5k2bLSIYaD1qm4F5dn5TCe9zAeeiDRaCT+NzVLSEsnIfVa/DuWzd++lwWHJsH/HXGgq4DuNQDIV/LaQ8BXXlc/WHvq0Soyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098958; c=relaxed/simple;
	bh=LQ13ebAO4UAXqbS/+/OyQ1q0rMBzWh0nkMrJYsP8yGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ssIXr5+ih16FeYpBHxzH4KsV4IBtmHLT/bdLLPOid1gRYN7GHc1yzztk/smOptw92UHlYpx2OJ/J8MgwP6ID+upYeZCpYVy+Ax/hPZz4MnkR3e1rG4DR2mCyJCXcLIqQW/nrz4zwE9/Wvt+KK85dowcmehjV/48asL2eBX+y2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THt1RafR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THt1RafR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53345C2BCB7;
	Mon, 18 May 2026 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779098957;
	bh=LQ13ebAO4UAXqbS/+/OyQ1q0rMBzWh0nkMrJYsP8yGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=THt1RafRYxc1QTFiabyiyjuG/Sb6ASo61uirT7RHgZV+hxQ2/kwiPO0HeCc0okzIo
	 lTViDaD5kYRNLytO9K9kzW7szwtsek5xaxsYlxPail2zxN6hPl3Vtmdjca8S6Y9AEM
	 LD+56s7BleuLLMwbdGLQCq8xdXp70qGTFeONCVteEoNI1iA1vOyFqSaQc90bUPI08H
	 ZijM+KCzCEXQiDAHinge0LbMj1QdqxX6TTZFOCweH1nqgGBilBhWHgJUT+a4lveH1q
	 OLflW0dyfd7uqQ6CroBBSKq1c70AS9gGJqAPcUScY4l8MOa0Oa46EeV9X0rFtqcAv/
	 ucwKt7Lm0l29Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260518095907.36158-2-clamor95@gmail.com>
References: <20260518095907.36158-2-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 10:09:10 +0000
Message-Id: <20260518100917.53345C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `reg` property specifies `minItems: 2` but is missing an explic=
it `maxItems: 2` constraint or an `items` array definition.
--

commit 1a4f9a19859ef3d1429d7fbcebe0842f0c3684af
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: embedded-controller: document ASUS Transformer EC

This commit adds device tree binding documentation for the embedded
controller used in the ASUS Transformer device series. The controllers
are attached to an I2C bus and run custom ASUS firmware.

> diff --git a/Documentation/devicetree/bindings/embedded-controller/asus,t=
f201-ec-pad.yaml b/Documentation/devicetree/bindings/embedded-controller/as=
us,tf201-ec-pad.yaml
> new file mode 100644
> index 0000000000000..60b6375864aaf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec=
-pad.yaml

[ ... ]

> +  reg:
> +    description:
> +      The ASUS Transformer EC has a main I2C address and an associated
> +      DockRAM device, which provides power-related functions for the
> +      embedded controller. Both addresses are required for operation.
> +    minItems: 2

Does this property need an explicit maxItems: 2 constraint or an items array
definition to properly bound the schema?=20

> +
> +  reg-names:
> +    items:
> +      - const: ec
> +      - const: dockram

While the reg-names property correctly defines exactly two expected names,
without an explicit upper bound or items array, the reg property definition
might be incomplete according to standard dt-binding conventions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518095907.3615=
8-1-clamor95@gmail.com?part=3D1
