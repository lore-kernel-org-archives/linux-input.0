Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930394A4995;
	Mon, 21 Sep 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015195; cv=none; b=NGuT3rtFy0MWK7oq3D+YZjYbiX6FhjRwlzv0bJLrN2zy5G9SgLBxCpuOQDj8kqtVCP3leeAkhSIa/d9BL3+/6KZ5ttw91w7SyWepNjDDMb6oGL6RXTKo9rLnZlB8SWPVMhdNBHfEHxmXu1rO6ciO1yD4iVe1XNRt+gpIvhuXn5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015195; c=relaxed/simple;
	bh=usojy4x29VIsOghbWYENp1xqWc8lSwM4LSs/RoUUL7g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iQgaS78pxaaRKCWP4trBKXYG3Cxa2udwE01Fl3siIj9HmREBhxirpTPrngnDJ37HMlZibryRMis4a1gubo1gUcJDUErweS+b4FKpfk/x2J0XmZy0OVXGdmpKYP9quccvvw9sbjHePhE97a/myZvtHsD8PonFc/+pWjnRfJ0Poxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOdnZbI2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOdnZbI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982FA1F000FF;
	Mon, 21 Sep 2026 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015194;
	bh=W0aH694xxaoojSNRYyLlLh44l7vy/hpaF+r9VEUSMgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gOdnZbI2dOxrwDHL+p++DOOeat1WGShjE280jRHpCna79izreHHhkFfbd6Yu0ZUwA
	 3DLFoG8Ls+PthHGygAO09tGQx11rHskmffxGXNeZECfj9KSheghbFiGVXeHwNkSxBU
	 t/4uEtItd7ETB+h9H28iOVPy/QpHWOUzCKR3nmX3lvQvA9eerFdalY/luJJc4Ghvrc
	 DTuL34TaoUhthWPYIgDtczKEJcrVHV1crNqaaW4qZJkKlaZ+65THYHSVBRnMU0PoRb
	 /FfLZsmK8oSOLtATBhVWTZJEHeqTyvrVjyQN9mIfXoE1PTirI2qDxu429ToyvuS/PY
	 9hI+W0JtfMziw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/19] dt-bindings: clock: qcom,rpmcc: Add MSM8952
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: lee@kernel.org, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, conor+dt@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-12-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-12-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:26:33 +0000
Message-Id: <20260921182633.982FA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: clock: missing msm8952 in constraints conditional b=
lock
--

commit 08e2cd81c0f804c9a9db2e8d8d60babe26ca3d55
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

dt-bindings: clock: qcom,rpmcc: Add MSM8952 compatible

Document the rpmcc found on MSM8952.

> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Do=
cumentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> @@ -56,6 +56,11 @@ properties:
>                - qcom,rpmcc-shikra
>            - const: qcom,rpmcc-qcm2290
>            - const: qcom,rpmcc
> +      - items:
> +          - enum:
> +              - qcom,rpmcc-msm8952
> +          - const: qcom,rpmcc-msm8976
> +          - const: qcom,rpmcc

[Severity: Medium]
Does qcom,rpmcc-msm8952 also need to be added to the allOf conditional
block that enforces the xo clock constraints?

Because qcom,rpmcc-msm8952 falls back to qcom,rpmcc-msm8976, it shares the
same xo clock requirement. Currently, qcom,rpmcc-msm8976 is listed in the
conditional block:

Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml:
  - if:
      properties:
        compatible:
          contains:
            enum:
              ...
              - qcom,rpmcc-msm8974
              - qcom,rpmcc-msm8976
              ...
    then:
      properties:
        clocks:
          items:
            - description: xo clock

Should qcom,rpmcc-msm8952 be added to this enum list? When running
dt_binding_check on a device tree containing the qcom,rpmcc-msm8952
compatible string, the clock constraints will not be enforced.

> =20
>    '#clock-cells':
>      const: 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D12
