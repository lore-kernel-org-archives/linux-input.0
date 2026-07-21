Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FE45BD78;
	Tue, 21 Jul 2026 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628516; cv=none; b=PfBVnt73K02TQoWVG33Mgtwf7kdnoK6VgGNQVuV0BG8PoDA28/31oDqh8pWAhm5ePsH7LtAd9gDIwQaEiWEsuSXWMkr9X9SfuKuU1yeW3mZWn6PoIK8VvZKujEwtDKU4+bfgk0ejmpfinX/Y9MbwdoM6cAJpa/mBosOai33VBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628516; c=relaxed/simple;
	bh=qrh+LLdRsZa/cbyHZi6FdZRYJ0HNhsWVeBAhAyuLzqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eZjakwcP/Cso9E2T8c9XtLuLz1S/JHk/gjYmTI0RYfy7OYhhMB/Ek0vIUAhXvaZDxrbASEE74mjPt/jf4JyAr78t7ZckL4r1cXasy7GYuFK5Zu4tLCndwx7ZFAYJi0lsOQgMPbMN4usC56t7FJfvpUNoCqMpaIYQ5ABTZMO5nNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq21DZeK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq21DZeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D2B1F00A3D;
	Tue, 21 Jul 2026 10:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628515;
	bh=4rN1XsclwEYobsUcGrpM2xP6PXs8J2naPTDAZ37k0EQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bq21DZeKz5/LN498t5AYGIS/XwpFj+aSTKn2Xk+YIJ4WTqcqJAaTs3lWvgneYaCwG
	 vAz7rOvYrpo4m7warHwLvzXjyP0E1Ze2Yf6Q8wh4UaI018twbLvCxnQopOhtKadi+y
	 OsDFD1GFQxv11+ACL1+bkiZn418nrKVkoypiUQC6y+Us1zk/+zRJ+I+hrXgKh5Dfs8
	 BWEax3ENz65Qow5v2GTxUE6x7M8cXiBqFK2oGpwkFbZEAEI1cQk/sXc24utfB6IB0D
	 0ERKO5nrUaNjh+KhyvSRhjpwGXCQNeovL5NV7Mei0GtgH8WHFK7zwKqLFj7sYDgqdb
	 c0O/eTv/b+tUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] dt-bindings: input: cpcap-pwrbutton: convert to
 DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, lee@kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260721095654.429346-3-clamor95@gmail.com>
References: <20260721095654.429346-1-clamor95@gmail.com>
 <20260721095654.429346-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:08:34 +0000
Message-Id: <20260721100834.A0D2B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The conversion to YAML format creates broken documentation cross-re=
ferences between the child power button binding and the parent MFD binding.
--

--- Patch [2]: [PATCH v7 2/6] dt-bindings: input: cpcap-pwrbutton: convert =
to DT schema ---
commit 04f32d0760614b206c7745dbb0c714f9b7720ee6
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: input: cpcap-pwrbutton: convert to DT schema

This commit converts the device tree bindings for the Motorola CPCAP PMIC
power button from plain text to YAML format.

> diff --git a/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbu=
tton.yaml b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutto=
n.yaml
> new file mode 100644
> index 0000000000000..77a3e5a47d1ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.ya=
ml
> @@ -0,0 +1,32 @@
[ ... ]
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:
> +  This module is part of the Motorola CPCAP MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The

[Severity: Low]
Are we referencing a file that doesn't exist yet? Since the parent MFD
binding hasn't been converted to YAML yet, the referenced file
motorola,cpcap.yaml doesn't seem to be in the tree.

Additionally, should the parent MFD binding
(Documentation/devicetree/bindings/mfd/motorola-cpcap.txt) be updated in
this patch? It appears it still explicitly lists cpcap-pwrbutton.txt in its
"Optional subnodes:" section, which is being deleted here.

> +  power key is represented as a sub-node of the PMIC node on the device
> +  tree.
> +
> +properties:
> +  compatible:
> +    const: motorola,cpcap-pwrbutton

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095654.4293=
46-1-clamor95@gmail.com?part=3D2
