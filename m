Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80802BE053;
	Mon, 21 Sep 2026 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015363; cv=none; b=U0slOhAoChH8e0D5ghwM+/TVYlJIdvJq+S2j2Kjx0MD2FcKfUaHFZL0lKubWe/+BRUhV+TjrUAOql/EdZgnqxx1i0uOS4MW74anG9w++MGE53/LU0NyhAXmAMouv4cazcKWjL0ZwSwYOM9jK6xoand9zzMPfne9l7MdnGIK+X0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015363; c=relaxed/simple;
	bh=NRyQEYaWH941wL+8aByrcxqHER+ik4WBavW1SfWp7JM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MsI6VWazUIR65PDei0GwACh57tkjptdZ7TtU4zpIcajSRoInaMyBQ9QG7KJYmtWYtB0O0/nzbqfPkpbZJxiVkznbaQ/GRj6sYdPreKJGhyuw38FMubHyG33WwZqr5jGwv+m1+nr4pRfGc6UptIu3RkvMhWKK2voR+/UIcmHgDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGB9J7l3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGB9J7l3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A7C1F000FF;
	Mon, 21 Sep 2026 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015361;
	bh=H62gcGWcKbrWTMkCd01zYMB7sv2iKehtP20WLbKlyIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGB9J7l3gJREfd1Qyl8enfohbQD20I1vJdBiXfoF0uwrIJ3bWBPwrpVDcJyP4S8co
	 ag5+ahJTnQOa2CMFQleiMxg9BTkj3RhML5jkYUKEpERbx4eQuW6IliiHSpRlhTpjcg
	 /fPynkQMx4C01qvCjYL2IjLDwjLPEN47xeylnSdok1nBzBPn4+zObvivXOG4+NHMFQ
	 IM9QCu2ftE/qgR33maeYHQFdEyDGLFx6BIViw4Aaa5/JTbO9CxeRNY6l1bRAEgCP6V
	 IbQ8+d6YEEW4CbGMQ5tFiFwILsVnvKSaEwVs/fOwZPvC8MYJeW1ILdpV4Ph6/WJMAH
	 wiifybudk+ehg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/19] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org, linux-clk@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com, mfd@lists.linux.dev
In-Reply-To: <20260921-msm8952-initial-support-v3-18-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-18-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:29:20 +0000
Message-Id: <20260921182920.F3A7C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] input: touchscreen: goodix: incomplete GT970 support causes conf=
ig length mismatch
--

commit fb8dc3b0be08be515a9f9b03de04ea7da115bf6f
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

dt-bindings: input: touchscreen: goodix: Add binding for GT970

This commit adds the goodix,gt970 compatible string to the DT binding.
It specifies that the GT970 should fall back to the goodix,gt911
compatible string to use the GT911 driver configuration.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.y=
aml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> index a26a54d63a1c0..4be2c137abd7c 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> @@ -14,21 +14,26 @@ allOf:
> =20
>  properties:
>    compatible:
[ ... ]
> +      - items:
> +          - enum:
> +              - goodix,gt970
> +          - const: goodix,gt911

[Severity: Medium]
Will this require a corresponding driver change to work correctly?

When the driver probes the device, it uses goodix_get_chip_data() to choose
configuration parameters based on the hardware ID read from the device, rat=
her
than the DT compatible string.

Because "970" is missing from the goodix_chip_ids[] array in
drivers/input/touchscreen/goodix.c, it appears the driver will ignore this =
DT
fallback and apply the generic 240-byte configuration instead of GT911's
186-byte configuration.

Could this incorrect configuration length cause the driver to read or write
past the end of the configuration registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D18
