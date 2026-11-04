Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793768332;
	b=uVtFwTnYi/T+tsGmsMvcc9E/Rne2nV4XY3LNc5+ZRodiiaMG0HEILo/SRNTnIvP2eIy7
	 9yTnn3pv/kxOROnnsa/cOkjxWei1YG8GRjjjfLak3dy0YhwQKSccNbSmtt17CBZq8YlAI
	 YkJieTFI3oYZDkgKu70Ivg25umn03Aa5SYbHbRfCdSO/pc6hp03HJp96V0FCKoFCj44ym
	 yX70khe3guRrpQlqPYJ6O2c4i5rPRCNjMga3tH6TLdMarT+4z6wYkCHF54/HJbQ1h6THx
	 aO8232URmxPhsXXHMaVHLqXgIAqRSsYm17rNQSTVgWgsyjg5lgxwef9uHpL8xKjyLbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UsAPboTebbwEnZ65v3FjNs+XaMIOh4il68XoeaJW4MI=;
	b=DRzDf2AtdNGamWp6CQ1da+vqNtIvn32KH6XJOOhX/ZXa7Sg/dDjWGN/MCak1cTcI8Yf2
	 J2vK0qf5/MXckMpSKCIa86tJxdIB94Mixeka85M+Is4ipb+P8v0Gc9lcwZyhfaFMutKKK
	 Qg8JMGFFyLV4TDNxmCw/oPAven5+PG6Sjal6WPMnLdCHah//aAJjilwO4EHMuAL5A9e7S
	 gsvVR2AVVTLHR1A9cwvdD/0nCTNMr/GTPbMmDoiLi+EtVnEGGMdWmeD9ms3CC7lRAbfgj
	 Izi8m53hNiGK9dzbBxa6V+secmGVoA33GP6mFH/lxQyBO8MUizuZdlYMFQJtcBG5SZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iN7N4kX7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA5606A32E;
	Wed,  4 Nov 2026 04:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iN7N4kX7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33371F000C1;
	Wed,  4 Nov 2026 04:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793768332;
	bh=UsAPboTebbwEnZ65v3FjNs+XaMIOh4il68XoeaJW4MI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iN7N4kX7SnuDi5ZbsoKu099OENlo1IOtWlmBE+2N3p3VaQ7bjFiD6Rex0zPYAGCAm
	 KY3lSxe1TmWqwC16pAdGKUCIbIaBXWY9DPo4gDR+HuLmN/8BIxn20vnKN5LjRWKJY6
	 4vviPMv1RhFX0PXb9BWlFOL76IambMHyS0P52n6/z4gzqLuHSYiK0+lG4dJ6c6vHd2
	 sZn/AaZEis+rh7fiujSEd4a6NkW/y9mHyfUiP5iA8lqJ67z3Qk8uYCxSuoAj9ybXZL
	 VZ3Fiqu1ZyPzEqNQ+Fd5cFTfi5RCPK+Dnw8JYvFVP87dI+5Bh4lkeyJhS8FNBI/k8L
	 5fpO5C0JQwIOQ==
Message-ID: <sashiko-outbox-196665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v7 1/2] dt-bindings: input: Add Qualcomm SPMI
 PMIC haptics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261103-qcom-spmi-haptics-v7-1-418de67ef84a@oss.qualcomm.com>
References: <20261103-qcom-spmi-haptics-v7-0-418de67ef84a@oss.qualcomm.com>
 <20261103-qcom-spmi-haptics-v7-1-418de67ef84a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 04:58:51 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: input: qcom,spmi-haptics example fails spmi-pmic schem=
a check
--

commit f214feaff6e5674dfe8f6c74a27c54575bdbebcc
Author: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

dt-bindings: input: Add Qualcomm SPMI PMIC haptics

This commit adds the Device Tree binding schema for the haptics module insi=
de
Qualcomm SPMI PMICs such as PMIH0108.

> diff --git a/Documentation/devicetree/bindings/input/qcom,spmi-haptics.ya=
ml b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> new file mode 100644
> index 0000000000000..ce2c9e893a0d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml
> @@ -0,0 +1,139 @@

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/spmi/spmi.h>
> +
> +    pmic@7 {
> +        compatible =3D "qcom,pmih0108", "qcom,spmi-pmic";
> +        reg =3D <0x7 SPMI_USID>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        haptics@f000 {
> +            compatible =3D "qcom,pmih0108-haptics", "qcom,spmi-haptics";
> +            reg =3D <0xf000>, <0xf100>;
> +            reg-names =3D "cfg", "ptn";
> +            interrupts =3D <0x7 0xf0 0x1 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names =3D "fifo-empty";
> +
> +            qcom,vmax-microvolt =3D <1300000>;
> +            qcom,lra-period-us =3D <5880>;
> +        };
> +    };

[Severity: Low]
As reported by Sashiko on v6 [1], in the examples section of
Documentation/devicetree/bindings/input/qcom,spmi-haptics.yaml, the child
node haptics@f000 is placed under a parent pmic@7 node with
compatible =3D "qcom,pmih0108", "qcom,spmi-pmic".

When dt-validate checks this example against all schemas, pmic@7 is validat=
ed
against Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml, which li=
sts
allowed child node patterns under patternProperties and sets
additionalProperties: false:

  "^vibrator@[0-9a-f]+$":
    type: object
    $ref: /schemas/input/qcom,pm8xxx-vib.yaml#
  ...
  additionalProperties: false

Because patternProperties in Documentation/devicetree/bindings/mfd/qcom,spm=
i-pmic.yaml
does not include a pattern for "^haptics@[0-9a-f]+$" referencing
/schemas/input/qcom,spmi-haptics.yaml#, will a full dt_binding_check (and
dtbs_check on device trees using this node) fail schema validation on
haptics@f000?

[1] https://lore.kernel.org/r/20260807062927.548EF1F000E9@smtp.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-qcom-spmi-=
haptics-v7-0-418de67ef84a@oss.qualcomm.com?part=3D1
