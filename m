Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653294D90C7;
	Mon, 11 May 2026 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535452; cv=none; b=Rr7A3SUv4HSd8Mgx1roWne7qtSYXBYKs37KIWaiUi6GdtczMMj/jrLoVVR1AJo8asD9wLzVEnbiDp41tsLmxropQc+ZPbern+jGpps2p08w6DmV/457xsOkI2M4p9qvEKS0Z5CBNnASnq1JTyBDkUTtsZFgvGmy5Gfe4HhCppwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535452; c=relaxed/simple;
	bh=LpC8dEhUAYtNBitL6JLbgQXkI/W8PLjyplYzWL+mk9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FuqVK77jJygZp08RPySkk/f293NK9ZY+dpWfbT8grEWzIig2atN1rwNSgKsoKeGjeyRtUkNByMhUZkiUSwalEXgkY9N1aKzDfimIxi/67RQC1PhvCf/GTruOygML5sjXoJFx8EhdS3ZUlOPjH8JomX7w2He9Tqo6Xwc0eorFD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFznTjdi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFznTjdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB77C2BCB0;
	Mon, 11 May 2026 21:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778535452;
	bh=LpC8dEhUAYtNBitL6JLbgQXkI/W8PLjyplYzWL+mk9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KFznTjdiHST0zexWvDtOmvYWtJbZH8NlpWAEwk8vqjdRp7LCLou1NI6iy4JDVGqvV
	 A1KvR2S3SQfe1/wHv7+UZQh1g5RkYx342gf2DecsiduBSL+LXxDO6svnuBgueCBuHB
	 3iJ9bDD7e4pO+k8hOT5pNKm2Vtk4YG5AwXY1NXAP352RAPByE6b7DX+KhCBb6CIbnp
	 7/Bdq5d4SIWajjlDlYeIRnn5ynu/ZpHJ7CAuWQ5h+8fYsi1aJHvbxRItrEylVlsAYN
	 3VnOomtYjkirKpDsHF8bIOH9aHMIkTL417O03d6FR7xZLmzfuH3Ze/q0Nyrz2mBEOt
	 62OHzkLZtLurw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] dt-bindings: mfd: motorola-cpcap: document
 Mapphone and Mot CPCAP
Reply-To: sashiko@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org
In-Reply-To: <20260510110804.33045-5-clamor95@gmail.com>
References: <20260510110804.33045-5-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 21:37:31 +0000
Message-Id: <20260511213731.DEB77C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The schema prevents the use of the generic `motorola,cpcap` fallba=
ck for the new compatible strings, which will break device probing.
--

commit 43b55cbad252ef116a236dfd195512e35a6f5c82
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
   =20
Add compatibles for Mapphone and Mot CPCAP subdevice compositions. Both
variations cannot use st,6556002 fallback since they may be based on
different controllers.

> diff --git a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml b/=
Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> index 7f257f3a1a5a2..542d149d2b39c 100644
> --- a/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> +++ b/Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
> @@ -14,9 +14,14 @@ allOf:
> =20
>  properties:
>    compatible:
> -    items:
> -      - const: motorola,cpcap
> -      - const: st,6556002
> +    oneOf:
> +      - enum:
> +          - motorola,mapphone-cpcap
> +          - motorola,mot-cpcap

Will this prevent the use of motorola,cpcap as a fallback for the new
compatible strings? It looks like this branch of the schema requires devices
to provide only a single compatible string.

Looking at the OMAP4 board code for Mapphone devices, it explicitly matches
against the generic motorola,cpcap string:

arch/arm/mach-omap2/pmic-cpcap.c:cpcap_init() {
    ...
	if (!of_find_compatible_node(NULL, NULL, "motorola,cpcap"))
		return -ENODEV;
    ...
}

By forbidding motorola,cpcap as a fallback in the bindings, will device tre=
es
updated to pass schema validation (by using only the new specific compatibl=
es)
fail to find the node at runtime in the board code?

If the node is not found, does this prevent the initialization of the CPCAP
PMIC voltage regulators on OMAP4 devices, breaking power management and
voltage scaling?

Could the schema permit motorola,cpcap as a fallback for the new compatible
strings, perhaps by using an items list with the new strings as the first
item and motorola,cpcap as the const fallback?

> +
> +      - items:
> +          - const: motorola,cpcap
> +          - const: st,6556002
> =20
>    reg:
>      maxItems: 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510110804.3304=
5-1-clamor95@gmail.com?part=3D4
