Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C63403F4;
	Fri, 25 Sep 2026 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371948; cv=none; b=p1+tSww+ZpaIx+WYfwHTcdNoZfSz9COf+tfwNYKqe7ZezZruRnljW9I2BO4QjPUddrNtNCqDLEho31mLnHDtaWKIAYBAi6SFI57HaJfkRji1di6wXHjab0rKXaFMbzq8Oja5ahVhtMEKKAvI7ejVv9PqfmAxSW4lduzSgYogyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371948; c=relaxed/simple;
	bh=CZKpggtx+GxY5GIJrCJPoEnuSnN5mmH66PMOKA8pSF0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RkyI1MONWsCgBNPxbkha9fotBFjQK4gVcYO3rNooKogdjgi6uvzXrlhO+6qBw4wPPDNpJffyPtCsLESuXb+56wYBYVy2nxObqatXvaOPgRvUjKob91vkFoy9ZZSSDCCPFjtmQoTGyJ84zS8DBXmb/mGnJXIl/oYcko8W7/oO0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBPuvHel; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBPuvHel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C175F1F000FF;
	Fri, 25 Sep 2026 21:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790371945;
	bh=8eYjmKnnL9Y+2Cv7U40rrkrK6vfoRGwALtjc7/oKDQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DBPuvHelinbDO9LL/dE4PdjxPZ/ZHQq6WlYVtOAGDAJEDdW2xEZLdW0oUWg5rpVWl
	 smb6HLEw6WePe5tl7yaThrLmOOyyXdhYc5vRCZDQtqIyIwowtGpe+NhYl2V5yLu4D+
	 0CNuZgGwK7zyrpS0uX6OOyx/vDUYKlk4YlAi4NLs1vGLRyz6vcbXT0ADSWCpNm9oFG
	 LDahRsaY55FTr1SnJg1dfdabt3XaaL90SYydwqjK0AG17g0jRD3mKcpZPJLZCelQ35
	 TSlWEpCr6CJdihjINQ7EaW3DshBInvZY49GckrSklbxAeoYEkNJlUAqyLCMLFASwJv
	 tAZxXyKjqXuDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/5] dt-bindings: input: touchscreen: st,stmfts:
 Introduce STM FTS5
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260925-stmfts5-v8-3-0fcf49e2c85f@ixit.cz>
References: <20260925-stmfts5-v8-0-0fcf49e2c85f@ixit.cz>
 <20260925-stmfts5-v8-3-0fcf49e2c85f@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 21:32:24 +0000
Message-Id: <20260925213224.C175F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: incorrect compatible match unconditionally disables=
 mode-switch-gpios
--

commit c0479420ff01b8ddcb3ee0711384a0b5753693d1
Author: David Heidelberg <david@ixit.cz>

dt-bindings: input: touchscreen: st,stmfts: Introduce STM FTS5

This commit adds support for the STM FTS5 touchscreen variant to the
existing st,stmfts binding. It introduces the st,stmfts5 compatible
string and a new optional mode-switch-gpios property specific to it.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmft=
s.yaml b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> index 6eb1ad6582d82..3de4bc5cd3f78 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
[ ... ]
> @@ -51,6 +54,17 @@ required:
>    - interrupts
>    - vdd-supply
> =20
> +allOf:
> +  - $ref: touchscreen.yaml#
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            const: st,stmfts5

[Severity: Medium]
Does this scalar string match fail against the compatible array?

The dt-schema tooling evaluates the compatible property as a string array.
Inside if blocks, const: st,stmfts5 strictly compares the entire array to
a scalar string, which is always false. Because this match always fails,
the not condition evaluates to true for all nodes, meaning
mode-switch-gpios: false is unconditionally applied to every device.

Should this be written as contains: const: st,stmfts5 instead?

> +    then:
> +      properties:
> +        mode-switch-gpios: false
> =20
>  unevaluatedProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-stmfts5-v8=
-0-0fcf49e2c85f@ixit.cz?part=3D3
