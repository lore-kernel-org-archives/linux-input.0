Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433B391835;
	Fri, 25 Sep 2026 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338600; cv=none; b=h9Oyem5gN9pu75OxwXN27g9C6OhH3D1fEf34OJzkuj5XVxn1R5qGqICgxRYuFkNJ/NJ0YdWNkxqMIKX1eXT5qbMLO74U/8Xrotv+7wg5xcbxOmBaTonFSQcXgdYEFtnYogpEdqWstq4/gN63YV+d10jTK5axfmIYopcV3M+tAcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338600; c=relaxed/simple;
	bh=cl+BirkRfI6NFYfkJNGk709QGYsoIZkMFLeFiuVPl/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g30d6sHS4X+R/scepRTYJM+WLNOJqL2A2rOVs3007h8ntjhlC6Zbx6jyjrUvIajbZ4i2+XTWpaPjGnXOGn/1AQylFTbk0Haq3tOdmBwuc/uimp9Zt1h8INdcABl4JHv9OMGRs8ukUxtIgaSetnl59Ol6yEzgKOMhYnWl1am0b48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/yDy2Ue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/yDy2Ue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4B51F000FF;
	Fri, 25 Sep 2026 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790338599;
	bh=6Zs6/8mn9+Iw3vpg74F/mX4dpV8D9Lxu1+WpFhBLkro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l/yDy2Ue0Z/aRHgkdQzQOhJBV/PvIdOWdoGBlPg/EHBRD8XYD70M8ySzI4eq9ffTe
	 FvyhXct2MkaGigzu2vwMrux1rEaKcTDcrKXgWpNXOEUbfCJLDlvNUhfyS5Hn+eOeJC
	 9n/nFUVffa44TSpoa48eYx3w0a90ZN/5ejT9XxVXhBCVdS7rFfU/Jamw0RRylKD40v
	 Tq6uF01WGAIuiVxhpU2c1R4+HH7zuxgi5/0MSHv9vtpvjqK0WHPO4EwM9GJPVNxiaD
	 xb6hizDvQInMYLTXX/1zRfeWrGP15+DI/fuIufGavL5uyRbEQ3/h8tgD0xhtwQcI/P
	 KC9WQBXEPMEBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/10] dt-bindings: input: apple: Add DockChannel HID
 transport
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves" <michael.reeves077@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260925-apple-mtp-keyboard-final-v4-4-304c267518f4@gmail.com>
References: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
 <20260925-apple-mtp-keyboard-final-v4-4-304c267518f4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 12:16:38 +0000
Message-Id: <20260925121638.9F4B51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: non-standard property hid-country-code lacks vendor pr=
efix
--

commit e3509f43ebb443f3e104e1a4db767081a67d80a5
Author: Michael Reeves <michael.reeves077@gmail.com>

dt-bindings: input: apple: Add DockChannel HID transport

This commit adds a devicetree binding for the Apple DockChannel HID
transport. It describes the transport's mailboxes, DART, and HID child
interfaces, including an optional STM child and a keyboard child.

> diff --git a/Documentation/devicetree/bindings/input/apple,t8112-dockchan=
nel-hid.yaml b/Documentation/devicetree/bindings/input/apple,t8112-dockchan=
nel-hid.yaml
> new file mode 100644
> index 0000000000000..c25e072b68687
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/apple,t8112-dockchannel-hid=
.yaml
[ ... ]
> +  keyboard:
> +    type: object
> +    properties:
> +      hid-country-code:
> +        $ref: /schemas/types.yaml#/definitions/uint32

[Severity: Low]
Does this non-standard property hid-country-code lack a vendor prefix?

Even though HID country code is an industry standard concept, devicetree
naming conventions require custom properties introduced in vendor bindings
to be prefixed (e.g., apple,hid-country-code) or placed in a common
dt-schema file.

Defining hid-country-code directly in an Apple-specific binding within the
keyboard object without a common HID schema backing it can cause namespace
collisions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-apple-mtp-=
keyboard-final-v4-0-304c267518f4@gmail.com?part=3D4
