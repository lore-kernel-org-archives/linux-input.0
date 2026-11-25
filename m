Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573082;
	b=eQq196wmCB8Qg53+XNWNCPfFmGj1PSHvIvZcdtQVL9CV7Lp0bQ+G7CWdzuLtWyjuwwQN
	 JuCj/NXaeWX/13yipbR9pGCLcm7RUxeW33I0UA5uBWABFFjKB7EtaSE1tEUviNj3P99b6
	 EDrqBNg1rPnmPemVAOrOFwKzE4CLU7IWWw+LUV3YrmTGXoY3AU678AkJuKAwWHmCSDaAW
	 v/621oc5/EFqXDGff0y6i/k7/rhwkrDW3se6lOpZ+QCwh8upSWWYWqWBF6+UrZ6r+QKZ3
	 LEVPoKd680FbBXt/M9qeHop/8a7B0YVvdn+o/INSgmLhYyiHCSO/WD9lGnXNnSTjzJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573082;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=krOqh55AbJ8Xq9vKnQT57fVEqt0Zmhd76IvPCZtU+ZI=;
	b=iq5396WZ6pXo0YEdzrl91tc0ltlJ3edWygbrL7u6VXpB2X1drGdRumFi2QchUqvK+I4T
	 N3AFLbq+m4PbAeXLD09qegcRrlBcxB9aPSC9Y29ffST0YYKhp5MNOVFLvkUpJLM7WBfNq
	 ijLRnx17FWYnXragZs1M5n4QydJ2xd/OnTpP7ZgEKNbkwvfTX3Lw0Cs/Q/cT8XLZkP70d
	 xed2IPYHy/QshS9PUMj+SyOc1zYd5yVHYVtlgSA2ny98LbS2vRiqh+WKtFN3+l+1prBgE
	 4C89iGwp3w/ddC5Num0GAnu0jpZm8iNsQTZKRawkSkN1/+FDhFsKslWeoo/INE3Xpnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flaCjsmb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2E606A321;
	Wed, 25 Nov 2026 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flaCjsmb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEA31F000D1;
	Wed, 25 Nov 2026 02:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795573082;
	bh=krOqh55AbJ8Xq9vKnQT57fVEqt0Zmhd76IvPCZtU+ZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=flaCjsmbEfawxVY/gZkpS6d4V+CdMXHCQzw5fHWpNSQ/LNnFCvzA0Ci4g10ZYifn7
	 MNHDIUixS6iFVe2RTvFcHlbLGqX9IDuZDb8yIQzhVsgGth6kwyNtZkEeqCR26/kH3O
	 98De1owhqI3sppaaP+6JMxDG2QkFAmQ8rSCEBFf8pPgFDkvOLrAz5073ShserQfeZr
	 9DFYiiVugxj1bAbUC6KmczsmOHud8CLDiCavkvCY5oZhbMiIpiTKvRXPzaY3UOcM1k
	 vTbOAWpJiIfkmim9tMHJaSM0BEEbD+3H7bpQGYEx8h/6//F2XrYSi0aD5hXt/AWdNn
	 3mtfWHBi9ToPw==
Message-ID: <sashiko-outbox-232399@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: input: add Jadard JD9365TX
 touchscreen binding
Reply-To: sashiko-reviews@lists.linux.dev
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_4AB695D7B71661EC93DAAF0E2AEDF8EEC706@qq.com>
References: <20261125020944.137-1-3066883572@qq.com>
 <tencent_4AB695D7B71661EC93DAAF0E2AEDF8EEC706@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:18:01 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] dt-bindings: input: redundant binding in subject and invalid
  commit message
- [Low] dt-bindings: input: jadard,jd9365tx missing interrupts and
  supply mismatch
--

commit 5025f445b383095ff3ce67c95d18c172670d9482
Author: Hefei <3066883572@qq.com>

> dt-bindings: input: add Jadard JD9365TX touchscreen binding
>
> Signed-off-by: Hefei <3066883572@qq.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>

[Severity: Low]
Under DT binding conventions, the "dt-bindings:" prefix already indicates
that the patch adds a binding, so the trailing word "binding" in the
subject is redundant (for example, "dt-bindings: input: touchscreen: add
Jadard JD9365TX").

The commit also lacks a changelog body describing the hardware and why the
binding is being added, and uses a non-standard Co-authored-by: trailer for
an AI tool, both of which trigger checkpatch.pl warnings.  Per
Documentation/process/coding-assistants.rst, AI coding assistants cannot
certify the Developer Certificate of Origin as co-authors and should be
disclosed in the changelog or with an Assisted-by: trailer instead.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,j=
d9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,j=
d9365tx.yaml
> new file mode 100644
> index 0000000000000..aaf2a7e00ff04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx=
.yaml
> @@ -0,0 +1,64 @@

[ ... ]

> +description: |
> +  In-cell touch integrated with Jadard JD9365TX DSI panels. The module F=
PC
> +  often exposes only I2C (no interrupt GPIO); the driver polls coordinate
> +  reports. The touch controller is commonly powered from the same rails =
as
> +  the panel; those supplies should still be described here when dedicated
> +  regulators exist.
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: jadard,jd9365tx
> +
> +  reg:
> +    maxItems: 1
> +
> +  poll-interval: true
> +
> +  vdd-supply:
> +    description: Analog / touch power supply
> +
> +  iovcc-supply:
> +    description: Digital I/O power supply
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - iovcc-supply
> +
> +unevaluatedProperties: false

[Severity: Low]
Should this schema allow an optional interrupts property and reconcile the
power supply requirements with the description?

The description notes that module FPCs "often" omit the interrupt GPIO and
that the driver polls, but DT bindings describe hardware capabilities
rather than a specific Linux driver implementation or single module FPC.
With unevaluatedProperties: false and no interrupts property, any board
that wires the JD9365TX interrupt line will fail dt_binding_check.

In addition, the description states that the supplies should be described
"when dedicated regulators exist", whereas the required list demands
vdd-supply and iovcc-supply unconditionally.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_EE81D0ED29E=
97716D56BDCF1A3C5AAE35B05@qq.com?part=3D2
