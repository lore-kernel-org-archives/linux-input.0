Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3074435A9F;
	Wed,  8 Jul 2026 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514474; cv=none; b=sMYNFZinCYR4c6XcHPuAF9ycWi3GrhsTAcYmoOja7sKGvvfWw3svCgZFZpivRblBi66VRW94ETXxnTpzaL1KUdE4aRh7ud4uN3JJHFtOhzndYQLP6xp0t7hBQonJLGNZ7CCR5fkt1l5CbFFoxaQDwWF+qmYRaD1RYn9Jsg2CKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514474; c=relaxed/simple;
	bh=WniDeSL+3u3oidbmJKW78jyl0Nqgqmt7S9uXaHtvp/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qjK6cElxxWdhbcglESc2U/TWM9lukN+/ueaD1P7iL3Dr/C18/JI0g9Wrpe9bSJmUsgJuwO2aFZGrFbBwpRLpGR6pA7/izZLOWup+Ut0rDkPsIebakAXSOXiCSti7e6EPZqWwgJY4c91UQwRHSGi7iojDsA3jf1/q/tm906qJZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvdkzLbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvdkzLbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC541F00A3A;
	Wed,  8 Jul 2026 12:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783514472;
	bh=w9xejsj/qYOpJeszETiH16n0Wj6bf9FW/vrXs/XpRoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dvdkzLbxgq0JpYZzIa4HzUIzPDNEPzSmHXiN3pe+B9LTnn9WmxXk+Hx/NjgoxvmSJ
	 TRpJ2fLSaJnkJQvGWVJDeeYEvCBw49Fkv10my2UAOJ0xWSOdfY7WBMwZvVFHHdllc2
	 4T+MURsJkr03lAAd0WD+o5nQ4c/PlF22lLbb15QqNmWifvb2PszhELVyyFlavqspjv
	 LNRG5l2oZRKnWXvrjM0VhnwriDJNF8eVMd8VAPa6LwAjiyAZev2BEdu/ejqpUY3/G0
	 XGqRNZPTozzoJzzdlyxqmN4IWkni/Xca6WGb8sbN0thsQLWr+sN1YkMiqfVojQtL0l
	 diS+bsqkz2cVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: input: Convert TI Keypad Controller to DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260708123252.1768355-1-egbostina@gmail.com>
References: <20260708123252.1768355-1-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 12:41:11 +0000
Message-Id: <20260708124112.1DC541F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Properties strictly required by the hardware and driver ('keypad=
,num-rows', 'keypad,num-columns', 'interrupts', and 'linux,keymap') are omi=
tted from the 'required:' list, allowing non-functional device trees to sil=
ently pass validation.
--

--- Patch [1]: [PATCH] dt-bindings: input: Convert TI Keypad Controller to =
DT schema ---
commit 31e1662350e854e7b96beb7e7de83fc2b0d265e2
Author: Eduard Bostina <egbostina@gmail.com>

dt-bindings: input: Convert TI Keypad Controller to DT schema

This commit converts the Texas Instruments Keypad Controller bindings to DT
schema format. It updates the autorepeat property name, adds the reg-names
property, and omits the keypad row and column properties from the required
list to prevent validation failures.

> diff --git a/Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml=
 b/Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml
[ ... ]
> +required:
> +  - compatible
> +  - reg

[Severity: Medium]
The commit message mentions that keypad,num-rows and keypad,num-columns were
omitted from this required list because enforcing them causes validation
failures. Should these properties, along with interrupts and linux,keymap,
be included here to accurately reflect the driver's probing requirements?

Omitting them allows non-functional device tree nodes to silently pass
schema validation. At runtime, the omap4-keypad driver will unconditionally
fail to probe via platform_get_irq(), matrix_keypad_parse_properties(), and
matrix_keypad_build_keymap() when these properties are missing.

Would it be better to enforce the strict hardware and driver requirements in
the schema, and instead fix the incomplete device tree nodes that are
failing validation?

> +
> +unevaluatedProperties: false
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708123252.1768=
355-1-egbostina@gmail.com?part=3D1
