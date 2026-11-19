Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119305;
	b=L21+8MyU1i0cTDEggOwUr4J6yTTZEA0eJsBvzTwg0jHl9uxe3qZSNpHZFrcftFVNFAJm
	 6h1NkTMiMlj6QR33XmNLHW3UbWlZSrf8GN3LmeLWfbkRV1L6bqgSld7t2glJvlaW04haM
	 n+/qsMJ0JZMt48RVU5fbNy9waxi9zL/Rn4ueyvDo2XrCSs+yfTVwy+l+pX3YZdWT86I5Z
	 7lKQ3CW6DYtuLPKlEQEyN8WnaBRJR2ait41gKUNRytxMCk7hN+Z+TfDw9jXVToQWx/Jgt
	 6/QoE0hEFdWLepjntGt2lWIpOsQmmrZvduWGkOpI3YqYNhiMdaap8z8c2IKC0ZSL0Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119305;
	h=Received:DKIM-Signature:Date:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:Cc:To:In-Reply-To:References:Message-Id:Subject;
	bh=ZFP1KdKJOpORb419ON5uvKPl/QdtChge5ZGA23yIqR4=;
	b=D4iT5qXDBAK+kzOky4UVG2NLNyJSodoxCnCAR6Y9Uld44DiluKflYH8DUc75yegmamyV
	 zXRWtR4HgLfJJSDpfdT/GciU2pDK9gj3cBTX0caZsPr+MWYtLj8x2tmiAgo/Js4UBhSwu
	 GsNpLAvCPZVPYJuQVkxS4KdWxIf+r9AfmJuzIhnO42SMVxou0ZTy3QS8sz1r0jI44FI2c
	 ZdaK19J64O0SgoGtFB/7cgNRLMa9tS7AaF8s83Wwbk2ofeDzWFH4SHPMIGrIe+KT96e+a
	 RSfHEj/tSez9tARhDH+5hvffT2uMIt9DOuteU0RlDdm16dFKSsVD/9uIi4np+kam+Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1y55w+u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C4606A324;
	Thu, 19 Nov 2026 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1y55w+u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3961F000C0;
	Thu, 19 Nov 2026 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119304;
	bh=ZFP1KdKJOpORb419ON5uvKPl/QdtChge5ZGA23yIqR4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=N1y55w+ukoBuAaoIpV9697PFKD+LkkgqSjniDb3jEnYmGlW1Nhh1myVpSZ54jiBzh
	 Iqwn65mKganneME9L2Sbw3782RiZqNxud+QbippqCanl4TS6j/FYmmmGdyEbiZlZvX
	 HUJuBBOOoKcpZGVa/5TL5PjoWwprsOONZ86FWUjYNNadAmhaQBU8FRD+dZq4JfIe3w
	 ySOKFgCnUhU+5ioEIdHpDno1FVBcbYfn7nYUiVHmrEAXZ7VQd+iCytSEAmyMuY7eye
	 emgkueK5KBrBi/lVNPDMPHfuhS5YHeN1+hFKClfLbO2RaJ0OCNTFwYpErjgDSJCIjy
	 azvX+rkEu6BhA==
Date: Thu, 19 Nov 2026 14:14:58 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org
To: Hefei <3066883572@qq.com>
In-Reply-To: <tencent_C97CF8588D7C3312CE3D51FCDEA1E68DA70A@qq.com>
References: <tencent_C97CF8588D7C3312CE3D51FCDEA1E68DA70A@qq.com>
Message-Id: <179509880891.714790.13159454991217439265.robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: display: add VIEWE JD9365TX panel
 binding


On Thu, 19 Nov 2026 10:48:01 +0800, Hefei wrote:
> Add the device tree binding for the VIEWE 7KF82 720x1280 Jadard
> JD9365TX MIPI-DSI panel.
> 
> Signed-off-by: Hefei <3066883572@qq.com>
> ---
>  .../display/panel/viewe,jd9365tx.yaml         | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.example.dtb: panel@0 (viewe,7kf82): port:endpoint: Unevaluated properties are not allowed ('data-lanes' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/panel/viewe,jd9365tx.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/tencent_C97CF8588D7C3312CE3D51FCDEA1E68DA70A@qq.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

