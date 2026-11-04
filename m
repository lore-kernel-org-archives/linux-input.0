Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797246;
	b=iqnsP/wtrhjmzQr7oCUH8HDNJgwO8j58aG4Z0i6rySTe4FFLjZZuXZkZGxzyl8U2/rnq
	 9BemSTVY47AvfA7CZ7yIoIiI6ELzbxEfjWXIQE5N7B0EmrL6vHs5JCQUK40MpPYtm5KV1
	 iyScJj+70wOWBz5BPRAPNc8+7xQ5fSVFfitdDcf8b8vZB6K45VLAe9Ka80JPAM+lo096b
	 GAMA3+rs7vhR+ao+D2IgccG/dUPi6Ez7KPFnjpyLt0iAM/M9hHHRSDjWCgZe7yU6wPRg6
	 z8wGpY2c+fgsR4o33I0UPLKZgahmokppEOzCu6FjdFb1w5A+V1ByKpsF6FlJ38jYPvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797246;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UD40//OcIuMR1lC0i06JFbRnW3uRqKUV031SU597fIQ=;
	b=cmzQCXyhy23Ip2mCmaL81pzzhq6O+OL53NK/1i9OPuICwGoifqXuF4mcIEcWzT9uxGCZ
	 KDAWb4vhe/yti0vhDLS3M19LhevV4bPJmAhFvcUePu43Wa8t+HcD8BJDwPQ4D82mEIBOs
	 bIYlTLRyCKtHdKSSR+UKRKoglEJRxLy/QAjrut3boWlKfnVK8gMR5xrllAOQIiplK+9hq
	 hr4C19lkLczJqVEk1HJKO3MQxEByKFJipmIRME/KApMDdxVzMQrNcueprM4M9LQt/w+F6
	 eZDXLb4AGfw3Yx3sQMdQ7rvu4joSJlwVLJ+Ynur2fLwm5l9xqzy/tQ9hKPiFPwZMXVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDWfVok4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE1606D803;
	Wed,  4 Nov 2026 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDWfVok4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766361F00A17;
	Wed,  4 Nov 2026 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797245;
	bh=UD40//OcIuMR1lC0i06JFbRnW3uRqKUV031SU597fIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eDWfVok4bq4ZGGCxgS3htSnfDgiy/4J0nrfSxz2ELTspb+LhMpNImx3ew1krnRSO0
	 CYMtugg+D/I/qnAO4QtqmQeD2xk2mL0QF2VABQH/L2VPjOE9PypiJeRnPqmXf2Kbdj
	 M9cjz6b4r0Pfh2xvROzYotZLrCPmB6Ew2TLt0bkoc2W9RbMEwKd1AVFdvXvwVWCFT3
	 ceWsuOJdNttqDWWQ+wsXHiMI3LoX8Yq4J74FK6hv1lFz/bHjgGml56hvjWllwDfCq8
	 edUe0mKlAmvsbFwp/N2Pn+/fh3gXq8W6ozahMVK0oUqypiPMQtstM7nWgC5KP3NRoa
	 OgPDtePLycgjQ==
Message-ID: <sashiko-outbox-197316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/3] dt-bindings: input: touchscreen: edt-ft5x06:
 Add wakeup gestures
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261104-ft5x06-double-tap-v1-1-5a1bd80449cc@ixit.cz>
References: <20261104-ft5x06-double-tap-v1-0-5a1bd80449cc@ixit.cz>
 <20261104-ft5x06-double-tap-v1-1-5a1bd80449cc@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 13:00:45 +0000
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
- [Medium] dt-bindings: input: edt-ft5x06: event-* nodes encode OS policy i=
n DT
--

commit 6f5aa6f1554c8cb1ae88e2ea6e589e4befad85e1
Author: David Heidelberg <david@ixit.cz>

dt-bindings: input: touchscreen: edt-ft5x06: Add wakeup gestures

This patch adds event child nodes to the edt-ft5x06 touchscreen binding
to describe firmware wakeup gestures and map them to Linux input keycodes.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x=
06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.ya=
ml
> index 68b2f16016543..bfc540665a2d2 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> @@ -111,6 +111,25 @@ properties:
> =20
>    interrupt-controller: true
> =20
> +patternProperties:
> +  "^event-(tap-double|swipe-(up|down|left|right))$":
> +    type: object
> +    $ref: ../input.yaml#
> +    description:
> +      A gesture the controller keeps detecting in its gesture mode, repo=
rted
> +      as a key on a separate input device. Gesture mode is entered when =
the
> +      touchscreen input device is closed or the system suspends, provided
> +      the device may wake up the system. Only controllers whose firmware
> +      implements the gesture registers support these nodes.
> +
> +    properties:
> +      linux,code: true
> +
> +    required:
> +      - linux,code
> +
> +    additionalProperties: false

[Severity: Medium]
Do these event-(tap-double|swipe-(up|down|left|right)) child nodes encode
OS/userspace policy and Linux driver details rather than describing the
hardware?

Unlike physical buttons, printed touch-overlay segments (touch-overlay in
touchscreen.yaml), or trackpad controllers with per-gesture hardware
sensing and timing tuning registers (such as azoteq,iqs7211.yaml, which
configures hardware duration, distance, angle, and threshold registers per
gesture), a touchscreen panel has no board-specific physical wiring or
markings that determine whether double-tap or directional swipe wakeup
gestures exist or what keycode they map to.

Whether the touchscreen interrupt can wake the system is already described
by the standard wakeup-source property, and whether the controller
supports gesture detection is determined by the controller compatible and
firmware. Choosing which wakeup gestures are enabled during screen-off or
system suspend and which Linux keycode (such as KEY_WAKEUP) they emit is
runtime OS/userspace policy rather than static hardware description.

Furthermore, the description documents Linux driver implementation details
(reporting the gesture on a separate input device and entering gesture
mode when the touchscreen input device is closed or the system suspends),
whereas Documentation/devicetree/bindings/writing-bindings.rst specifies
that bindings should describe hardware rather than OS or device driver
behavior.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-ft5x06-dou=
ble-tap-v1-0-5a1bd80449cc@ixit.cz?part=3D1
