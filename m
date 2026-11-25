Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573242;
	b=TyNBJ81bQfdiqzf+ukwymgeHssOLBnhUNfUXKDJiWQtIBR0Yu50jVQ4a1f1E3/8zYTq2
	 xy5Gzh8TwrkynJ7Rxv3vLBL2mGcg8QoKUXcMfSRZMUNHWTMYGOsleJDZxRfUyjvnHJ+0b
	 sPuF9QujPqR4p7Wh4FwLkGUyPHMgMNcvJ3GwOIaCmDAP8aC7zo89fkhLw5id+Cxv2MCkI
	 jqOSRlSoQYjabwhR6qZ0vAizF2jHMt4Wv4vM1gmyyFba+CWpVphVtBHo6fmDULYL1RgeN
	 eqKXrgQmFJTz9QMryYYxH5513mLSMs3+4nEpn63De8rVmcvp7c5Ws9RQu2temYZF1aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573242;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Be+2+teRwIEJN14tU3TOyJO/XJZb54sJqv072ygKOYY=;
	b=oA+UGPwDm7o0R49F07EZdxTT44UuUxArxIbIcK6sSf/ypH6LameWg2UJLk+cpn0n0nup
	 zhcO9UMCaeg9fO0QIcJAx0Fxt/U/M0zlnmSub7smByX/W6EC3SKTts8rSIhHVTLl/40W3
	 mYvU+xLNA6LaodJKh0e2ldN6qNa0SzuAImbPi4r7ME/jeUveSZNRVsx8CnYDmT7EhB65W
	 RUbf4I3GhiNmWGZ+v6TUrdLF3hn36olayGu6XbVOV6znqq+My+Sr6HIoah285zfABZrGQ
	 fDBPF4Hh1Z6cHIZFEybcLz88MVVWtZAoKWpwvPG1KtJFMnr0PLJeQp+OgT87byArJzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f21BkGaX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1429606A31E;
	Wed, 25 Nov 2026 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f21BkGaX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14901F000C4;
	Wed, 25 Nov 2026 02:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795573242;
	bh=Be+2+teRwIEJN14tU3TOyJO/XJZb54sJqv072ygKOYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f21BkGaXJaG5QG/NXF5TUJ/zvgwtNCCRA015OhqWUUV2XcbHO9tl3RkQ8WwGwgOYF
	 EfjJB6ZKoICWG1HupiF+lZTEDFL4Kd0HHSWTkjWo7vrOzCpo/6G4igLpqOZyhZ2YLB
	 yEttr9y6ystazXn+/G445bBoMk5UkqpIPf9z21MVfDSpYTnZwFrYW+Q2jOSyBy8Zfh
	 JRkjiwfBz8l2welmwdsnFlN8jofMz85A8GJM7y4rZrt0D0TroGbM6shc4qD6EpLbCF
	 W6Vyig2JC1SqqDBHnvnFhr7KeU614MFJUW8vgjI4ccw8V0twUwB9wNQV+5yM+gq80j
	 WmHMynmoluXSA==
Message-ID: <sashiko-outbox-232403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: display: add VIEWE JD9365TX panel
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_EE81D0ED29E97716D56BDCF1A3C5AAE35B05@qq.com>
References: <20261125020944.137-1-3066883572@qq.com>
 <tencent_EE81D0ED29E97716D56BDCF1A3C5AAE35B05@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:20:41 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] dt-bindings: display: panel: undocumented viewe vendor prefix
- [Medium] dt-bindings: display: panel: schema filename and $id mismatch
  compatible
- [Low] dt-bindings: display: panel: redundant subject, empty body, and
  bad trailer
- [Low] dt-bindings: display: panel: redundant panel-common.yaml
  properties
--

commit 23e321059ffa404a62a9dbc2300a4993242b19a7
Author: Hefei <3066883572@qq.com>

> dt-bindings: display: add VIEWE JD9365TX panel binding
>
> Signed-off-by: Hefei <3066883572@qq.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>

[Severity: Low]
The dt-bindings: prefix already indicates a binding, so "binding" in the
subject line is redundant.  The commit message also has no description
body, and checkpatch.pl rejects Co-authored-by: (kernel commits use
Co-developed-by: paired with Signed-off-by: for human co-authors, or
Assisted-by: for tools).

> diff --git a/Documentation/devicetree/bindings/display/panel/viewe,jd9365=
tx.yaml b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.ya=
ml
> new file mode 100644
> index 0000000000000..1043f93623c00
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/viewe,jd9365tx.yaml#

[Severity: Medium]
Should the schema filename and $id match the compatible string
documented below (viewe,7kf82.yaml)?  viewe,jd9365tx.yaml does not match
any compatible string in this schema and pairs the viewe panel vendor
prefix with the Jadard JD9365TX controller part number.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VIEWE 7.0" 720x1280 Jadard JD9365TX MIPI-DSI in-cell panel
> +
> +maintainers:
> +  - Hefei <3066883572@qq.com>
> +
> +description: |
> +  The VIEWE 7KF82 module is a 720x1280 RGB888 video-mode MIPI-DSI panel
> +  based on Jadard JD9365TX. It uses two DSI data lanes and exposes in-ce=
ll
> +  touch over I2C on the same FPC.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: viewe,7kf82

[Severity: Medium]
Is the viewe vendor prefix documented in
Documentation/devicetree/bindings/vendor-prefixes.yaml?  Without a
matching entry there, make dt_binding_check and checkpatch.pl flag
viewe,7kf82 as an undocumented vendor prefix.

> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Panel VDD supply, usually 3.3V
> +
> +  iovcc-supply:
> +    description: Panel IO voltage supply, usually 3.3V
> +
> +  reset-gpios:
> +    description: Optional panel reset GPIO (omit if board uses POR only).
> +    maxItems: 1
> +
> +  backlight: true
> +  rotation: true
> +  port: true

[Severity: Low]
Since this schema references panel-common.yaml# and uses
unevaluatedProperties: false, reset-gpios (with maxItems: 1), backlight,
rotation, and port are already defined there.  Can reset-gpios use
reset-gpios: true (since omitting it from required: already expresses
that it is optional) or can these common properties be omitted when
unevaluatedProperties: false is set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_EE81D0ED29E=
97716D56BDCF1A3C5AAE35B05@qq.com?part=3D1
