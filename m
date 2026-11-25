Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573066;
	b=ci4ahdsDcrHeAMbF9vYQrmNmlwyTbqCgDhKuBEROIuyxnCTrWizf+xYCrwiTnN6l9DPY
	 4+G9GCefk1xK/QNR0yPFyYDXARLVNATXm5GXbx/+u/RUHWROori319BaeQIucbnUPmfCR
	 5vR/k4bdF5iRqQcxFhJfU124c9PI5DA6nO+GAp3G5FmCY1+d453ivPRmNoZKRfZt90ffT
	 wpd5pFSQBXiqgls28gQEuTqF7YxwU0yXKWhiBSCNct51Z/hnv9jCdOkPl768v9twXrg2/
	 07AeJcN/zBjnucCDPONeKb8PbwjoIWh8/88iknpKz0zRzXP/UOpqt44d7/4DXw42Ckw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573066;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gBAzenmpcwPme1hRfQxhK7S392gYIIlb4xI4HrOvunw=;
	b=my28rp659l6RQAC9G8wZNk78WRgGA6kBj/RZLOkSmKi1H6KatgzTE2q6kX0NFtQoE3MQ
	 etSIcsX10RDSexee/fwdDgTxwJk+VC0YzQFVGprS6/yTUKrYzPMOBBCjOlHTbJ9x0E6b8
	 h6qwNmCKQ74wMaGUfba6mOmVCTxfgMBFD4tWAET5g5CK+CNl9dvE3QC3NjF+aqJBkaTmk
	 0/AVPff+xxhOBz/En3btlM9aEJ8AltlbPh5Y3aI+kqzNda8zz3GJRVq4QblNnLP2kjHZf
	 2ndagmJ7TV9o0pam2t8X2kOi50W2eGkdX/8HRsPuEH/PloVcbr5PFh2j9AAUBz91n2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABV+o+uT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9972B606A31E;
	Wed, 25 Nov 2026 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABV+o+uT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C801F000C4;
	Wed, 25 Nov 2026 02:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795573066;
	bh=gBAzenmpcwPme1hRfQxhK7S392gYIIlb4xI4HrOvunw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ABV+o+uTJ0IqwVmbJSbaqO3HYZMsll074zR9ISHqx96z1OxcRqErj/dP6sLlRWv3A
	 u5LenYaWaUBBrDQ6RPJbnjgUqgowWK0nNMa88SP9dsWdTcFIZrmodVaa4zar0Bwo8Q
	 Jpk+/AE6FsXFe7fo9foGqB48Clh7U5uPK9yjV30h0FLVUNvp4aapAlm6Ql7FF4xDTa
	 +ctnSwOHdlmWh5la1TbOGv0XoM1XGQSokFWNWelBxvyRCl0frt/CNzM6bz5+xW7e4Q
	 LtUYsEsMiTdQCsNpt9Tkf94h1mhLBhXrIez05cTKbU7SEZ3x0Z14fJcROcy7K/iQpV
	 KCLCStRIkziIQ==
Message-ID: <sashiko-outbox-232398@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: backlight: add VIEWE I2C backlight
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_655009C68D3E3EAD3EBE65084B9F9A7FE509@qq.com>
References: <20261125020944.137-1-3066883572@qq.com>
 <tencent_655009C68D3E3EAD3EBE65084B9F9A7FE509@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:17:45 +0000
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
- [Low] dt-bindings: backlight: undocumented vendor prefix viewe
- [Low] dt-bindings: backlight: schema filename and $id mismatch
  compatible
- [Low] dt-bindings: backlight: redundant word binding in commit subject
- [Low] dt-bindings: backlight: empty commit body and invalid
  Co-authored-by
--

commit 30cc2981090ca10d47ee3c9cabb7273eb616720b
Author: Hefei <3066883572@qq.com>

> dt-bindings: backlight: add VIEWE I2C backlight binding

[Severity: Low]
The "dt-bindings:" prefix already indicates that this patch adds a binding,
so the trailing word "binding" in the subject can be dropped.

>
> Signed-off-by: Hefei <3066883572@qq.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>

[Severity: Low]
The commit message has no changelog body describing the hardware or why the
binding is being added.  In addition, "Co-authored-by:" is not a valid
kernel trailer (checkpatch reports BAD_SIGN_OFF), and per
Documentation/process/coding-assistants.rst AI tools cannot certify the DCO
and should not be credited via sign-off or co-author trailers.

> diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-b=
acklight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-=
backlight.yaml
> new file mode 100644
> index 0000000000000..9be4bc93087ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backligh=
t.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/viewe,i2c-backlight.ya=
ml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

[Severity: Low]
Should this file and its $id be named viewe,7kf82-backlight.yaml to match
the single compatible string it documents, as required by
Documentation/devicetree/bindings/writing-bindings.rst?

[ ... ]

> +properties:
> +  compatible:
> +    const: viewe,7kf82-backlight

[Severity: Low]
Is "viewe" documented in
Documentation/devicetree/bindings/vendor-prefixes.yaml?  Without a vendor
prefix entry, make dt_binding_check and checkpatch fail validation on this
compatible string.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_EE81D0ED29E=
97716D56BDCF1A3C5AAE35B05@qq.com?part=3D3
