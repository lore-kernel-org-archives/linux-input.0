Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16035B631;
	Wed, 17 Jun 2026 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728272; cv=none; b=otEQ7SoMD6CqKBBwgfhKgULd15g8t49f+aK7Mr6Ieow4wcXKRXgW0zkLDrHDRCEVkw6MV3RHgjU5igN4SebCZLmI2ZtqnwqJNIHJBAU/E/cSNpcVuJgEmeTtb2o9wGseNW0tTn1Lp/61DlVYVtj7ex0o21nP06fL0U6eQw/qAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728272; c=relaxed/simple;
	bh=5A7sAOhhb2RfiJ+NOx1F4HByPaknrUUEQtps2W92ePs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MRgDdvdH/s/lnq72ttFrqQqjhqpv8XK6tHWibCY+0hnDqqfJvBC68i8ad3bxferrKl0+exgYq0c1w1uEAPA0VTFb2VfhcultxPN9Vf9ya34VJbx1b6ovNzdUYX1IsWaPJkeRLsNS0v4aJaD2V89rs939MA9SfrlrcLKkVjsN5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3LfjN7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3LfjN7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FDE1F000E9;
	Wed, 17 Jun 2026 20:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781728265;
	bh=ozfQcw/O8CAMHls+vIGVb+Ve0akF50Yh5E7IY7QYNB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3LfjN7mRR05KiEjmhkwWu8skBH76BD4vfUODQcl2kWZqRzPEN4WV0Kt5LyPJfQE2
	 LMD0dtHNp8V/FFkhdH+HaTWeeQhXbbBv4gZmtRzjsbVY+vA8asIX7DsU6HkhoWx5LC
	 KnLI5bkJEBOuMRzdnWujJVx84DxhFPzDawamQFnQQvgAFpVRi3oyLFPqJQ1DsxsdGx
	 j7zmxnsFLgWFJ4iwioVxJwxtqZJ5or7lGtYfou2jktdqVxEz4SjjRIiS+W8TOI0AK0
	 H4PZVozVOvFOSC5Y5mKDLmbvb52G844lsfoWsVyDdveGusRagMbTpaUUbwV+LbXc2u
	 k39B7mmHASICQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] dt-bindings: input: microchip,cap11xx: Update
 datasheet URL and LED reg range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yan" <jerrysteve1101@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org
In-Reply-To: <20260617150318.753148-4-jerrysteve1101@gmail.com>
References: <20260617150318.753148-1-jerrysteve1101@gmail.com>
 <20260617150318.753148-4-jerrysteve1101@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:31:04 +0000
Message-Id: <20260617203104.A4FDE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete Refactoring / Code and Commit Message Mismatch
--

commit e8499e0ca62db6a2ee6dc0986e7c04ea1337f6c7
Author: Jun Yan <jerrysteve1101@gmail.com>

Add datasheet links for all supported CAP11xx variants.

Update LED node regex and replace enum constraints with minimum/maximum
for LED reg ranges in preparation for CAP1114 support. Drop unnecessary
led unit-address pattern.

> diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.ya=
ml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> index 7ade03f1b32b..eabf06a1163e 100644
> --- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
> +++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml

[ ... ]

> @@ -131,7 +140,9 @@ patternProperties:
> =20
>      properties:
>        reg:
> -        enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +        description: LED channel number
> +        minimum: 0
> +        maximum: 7

[Severity: Medium]
Does this fully prepare the schema for CAP1114 support as mentioned in the
commit message?

While the constraints on the reg property were updated here, the main
patternProperties definition for the LED node just above this still uses
"^led@[0-7]$".

Since CAP1114 has 11 LED channels, wouldn't the schema fail validation for
nodes like led@8 and led@9 because the top-level pattern wasn't also update=
d?

[ ... ]

> @@ -158,7 +169,7 @@ allOf:
>                - microchip,cap1298
>      then:
>        patternProperties:
> -        "^led@[0-7]$": false
> +        "^led@": false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617150318.7531=
48-1-jerrysteve1101@gmail.com?part=3D3
