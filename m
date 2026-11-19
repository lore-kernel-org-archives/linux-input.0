Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097115;
	b=MTq/4jDXKCUsHhOSR63y43ibAvy0YtHfjuebfup9LpEp+cgWVmVRxOccEPMeusAR8ClV
	 a7jGG3ITGQlvnExZe0lMefVQ6yfluSH1wy7IXUALpq1K+RmsojLIHvDHEuGycmzOsK64B
	 WHkTpm4gDP0YrnGyuUehDph28mymzKWt7ez5kw0DHZwWcD76Rz19D5qcJ48DiAO4/BeIz
	 LF6WFsdw32nHIrFrgL5+QUypcHkr/i2e55FeLo4/vbahdNnVGeYz3iWP3ABXuzj/uegp3
	 AREXJP8rSfrgOGhhiXwpLYX2vXk93KQr4+CZJf0jgSD+ILHKEIQHBoJsWQcz/Yj1+jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097115;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3wVoIWKe2Dfngpo9k99sYJdyHJ15FxUOZBxK12CiVi4=;
	b=EbXZmlBvlJWA4TItjv/VQFYxwZz3C1dcMQ1TQi3RAVKGZT2jtOCFXofqD+YOktcxQs4r
	 fwoHBzrR+nR2aBtE2dMqN4f61q+L4Mq5Py0wLz6o6aklDH2GbMHN2hm94Of0Kb3ltStxp
	 8fTKL63dYeVBO5sU1BeYNPjRkyoK72MIOeBeWF4MGqtSc7aOOaA0TQ7vKJ1Z5KKG/snNG
	 LyqQoFTijF66/0YqfDoYe9Apbnv9p7YbS1bPKvH8g7tSyrmRybLIWi2PH0t0Pr8Hrwigk
	 khc0jIu2pJ/5nNGPSwgEvf28poQE86MZcP7XpPqEbo4bLVywUHFjKJbBzEPYtzgugkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fcotb9tO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314CD606A320;
	Thu, 19 Nov 2026 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fcotb9tO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F3E1F000C4;
	Thu, 19 Nov 2026 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795097114;
	bh=3wVoIWKe2Dfngpo9k99sYJdyHJ15FxUOZBxK12CiVi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fcotb9tO0bAIGtT84nVgOsUfVEf2oysMnvQHU+MLEsYcmxyCSIVhfTW5kbke6YCVP
	 /BqZRbhW55LRGiLDlc8PXs+mmk1pREB48OjM5bULno505n1JYML1gDDZYwJDw1MKwX
	 qEi3vt3rMpf+AXjBJeleRhQwDoUxmO4/INsKdd0Uo5GcGuwOcPirL7YRNKAuA4wKre
	 IVfUqYs5UfdHrzeZuMvClTSAhF+9d1S3CZ8IpKohqHdFORceB2SjE+QqtwYJRbxAsF
	 513FxngYAhAHuqXx7WL9w5PWbFPAOPAlMEHlpQq/FQuwJ1LbtvvSFgRA+w6Pzcvym3
	 vU9CRNv3GHGcA==
Message-ID: <sashiko-outbox-223245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 AW8695 haptics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin.kroah@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261119-aw8695_haptic_fp4_driver-v4-3-9d107334bdb2@fairphone.com>
References: <20261119-aw8695_haptic_fp4_driver-v4-0-9d107334bdb2@fairphone.com>
 <20261119-aw8695_haptic_fp4_driver-v4-3-9d107334bdb2@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 14:05:14 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] Input: aw8695: broken work ordering and mode handling in
  aw8695_resume()
--

commit 0143deb4a0e86b5f6fa2fec12dfcfe91ccf02929
Author: Luca Weiss <luca.weiss@fairphone.com>

arm64: dts: qcom: sm7225-fairphone-fp4: Add AW8695 haptics

This commit adds the AW8695 haptics device node and its pinctrl states to
the Fairphone 4 devicetree.

> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm=
64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> index 773304b4759e6..25237b8fcb9e5 100644
> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> @@ -707,7 +707,17 @@ vreg_l7p: ldo7 {
> =20
>  	/* PX8618 @ 26 */
>  	/* SMB1395 PMIC @ 34 */
> -	/* awinic,aw8695 @ 5a */
> +
> +	haptics@5a {
> +		compatible =3D "awinic,aw8695";
> +		reg =3D <0x5a>;
> +
> +		interrupts-extended =3D <&tlmm 85 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios =3D <&tlmm 90 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-0 =3D <&aw8695_int_default>, <&aw8695_reset_default>;
> +		pinctrl-names =3D "default";
> +	};

[Severity: Medium]
Can aw8695_resume() in the awinic,aw8695 driver (added in commit "Input -
aw8695: Add driver for AW8695 haptics") drop playback requests or leave a
stale non-zero haptics->level across system suspend and resume?

drivers/input/misc/aw8695.c:aw8695_resume() {
	if (!haptics->suspend)
		return 0;

	enable_work(&haptics->play_work);
	aw8695_haptic_set_active(haptics);
	aw8695_play_mode(haptics, AW8695_STANDBY_MODE);
	haptics->suspend =3D false;
	return 0;
}

aw8695_resume() calls enable_work(&haptics->play_work) before its sleeping
I2C transfers and before clearing haptics->suspend, so any play_work that
runs during that window hits if (haptics->suspend) return in
aw8695_haptics_play_work() and is dropped.

Because aw8695_haptics_play() does not check haptics->suspend, an ff-memless
timer event during suspend or before haptics->suspend is cleared updates
haptics->level while the work is rejected or dropped.  After resume finishes
with the motor in AW8695_STANDBY_MODE, haptics->level retains the stale
non-zero value and later aw8695_haptics_play() calls at the same magnitude
return early at if (haptics->level =3D=3D level) without starting playback.

aw8695_resume() also wakes the chip via aw8695_haptic_set_active() only to
immediately put it back into AW8695_STANDBY_MODE (which aw8695_stop() in
aw8695_suspend() already entered), and neither aw8695_suspend() nor
aw8695_resume() checks the error return values of aw8695_stop(),
aw8695_haptic_set_active(), or aw8695_play_mode().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-aw8695_hap=
tic_fp4_driver-v4-0-9d107334bdb2@fairphone.com?part=3D3
