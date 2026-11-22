Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795324989;
	b=wo2t5SxISBZpv6xrvSbqEljifEsKO72aSpAuEkmOxpn7gfI7X/4nhGwzwtL3wL1h+gGJ
	 leVNHVceEZZJqTDEspFD7ZMZdg7wvp1df2sksjZEoSxI/OZe5o9S0T0+3/55AUf1nN9Zi
	 a9+5CQroh5CoSKbfQk0WvPINV6jU0nRPMs8svs3rj9yXy6JW4T9BD3xjj/Cj7h0g1s/1t
	 V6mCTChyOq/bq6odPCEVBdSiw3BypQkvgpkv8RJa9k2Hhh4YkY09JmlKFWYuZoVicqkU3
	 UvmQ7PbhNG/y9E0YavdcYoUyssS+D4sp4+IwpMG0U/vZYGLmBnpMYalpj1SpTQywsVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795324989;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/otnF/3oceHd43cECVWJx4RQuQ9I299JQj+zlVgewKo=;
	b=VYv/vSmPe50F6RdmAJYHP1Dn6nFdg48NEhOfyQZYrdQAGtRL4wpKV9gR8988FSpMNeKy
	 6Nm8mvhZY1By3VT/pT45Bl2pvD/IONyznvLnBkGR13G32uGC5PxnUqzrAQ+4SsQ27P9JA
	 YHApgGnsGcGOYK0yd5HldY5lDHlCpcx2mzK/QdY/3peb/DsK0rPxJDxdHNkObXymrzBwT
	 PdaW5XMNA83n8w1TVYCA+eysv77+u0VgblYg86919Lgo0R3Dpaz3C/o3XMA3ikFtCTrtX
	 QDFpcC1+2AXlfNPb66Ms3OoDV235KgQa/7MDrwrCWaBUm6VqiqLIx86QPb7bkCrsIMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cc8XAeAP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C04606A320;
	Sun, 22 Nov 2026 05:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cc8XAeAP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96821F000C0;
	Sun, 22 Nov 2026 05:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795324989;
	bh=/otnF/3oceHd43cECVWJx4RQuQ9I299JQj+zlVgewKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cc8XAeAPyzt+bAmMiQAFzoW9mHqCV/EszYNkq+9EUd9R1RaAtC7twHBt7OwyZf2D2
	 53LE7Wx/McPx+qHzdDjs2vLjj0nTmstcH41VjUFjODAPOVdlQ6qAdeFevRpU2rDhO2
	 yKXCg9fqeFspMlfyU/4DOdqOOFDTl6qxxQd5cX6ChTHEclWs6Wa3QAkgwIKbk5KQXo
	 qpQoIB2srlruOAAFmv6AZnA4BTPohhneMeNn3zqdJLDF9K8PSTQpOrbZVWewfLhKQ9
	 HspFhl31bKUQn/WIFR9XJdjTdTfck2gRBx2ptrfvwg8jyHxaA7unD5fpcSEnsIQqEA
	 QKapribAXmN+A==
Message-ID: <sashiko-outbox-227741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] Input: synaptics-rmi4 - keep an I2C device that may
 wake the system powered
Reply-To: sashiko-reviews@lists.linux.dev
To: EMCP333 <emcp@enser.io>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261122-b4-rmi4-wakeup-v1-2-1b662be4a9d6@enser.io>
References: <20261122-b4-rmi4-wakeup-v1-0-1b662be4a9d6@enser.io>
 <20261122-b4-rmi4-wakeup-v1-2-1b662be4a9d6@enser.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 05:23:07 +0000
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
- [Low] Input: synaptics-rmi4 - missing Fixes trailer for commit
  946c8432aab0
--

commit 83b2656443640f5726e0dae2d6e9d52155752d68
Author: EMCP333 <emcp@enser.io>

> Input: synaptics-rmi4 - keep an I2C device that may wake the system power=
ed
>
> rmi_i2c_suspend() arms the attention interrupt for wakeup through
> rmi_driver_suspend(..., true) and then disables the vdd and vio supplies.
> Unpowered, the controller cannot report a touch, so the wakeup it has just
> armed can never come from the user. Where the attention line is pulled up
> from the switched I/O supply, cutting that supply also pulls the line
> low, and that falling edge ends the suspend by itself.
>
> On a OnePlus 6T (S3706B, attention on a falling-edge GPIO, vio from a
> GPIO-controlled fixed regulator) with the touchscreen marked as a wakeup
> source, every s2idle ended within 3 to 4 seconds with nobody touching the
> phone, with one attention interrupt per suspend.
>
> Keep the supplies on in system suspend when the device may wake the
> system, as edt-ft5x06 does, and skip the matching re-enable and startup
> delay on resume. A device that may not wake is powered down as before.
>
> Tested on a OnePlus 6T on v7.4-rc3 with 'wakeup-source' on the
> touchscreen node. With wakeup enabled and nothing touching the phone,
> "rtcwake -m freeze -s 30" slept the full 30 seconds with no attention
> interrupt (2 of 2), and a double-tap woke it (2 of 2, 120 second RTC
> fallback). With wakeup disabled the supplies are cut as before and it
> slept until the RTC (2 of 2).
>
> The code and this changelog were prepared with the help of an AI coding
> assistant. The submitter has reviewed both and takes responsibility for
> them.
>
> Signed-off-by: EMCP333 <emcp@enser.io>

[Severity: Low]
This fixes a bug introduced when regulator support was added to
rmi_i2c_suspend() and rmi_i2c_resume(). Should the commit message include:

  Fixes: 946c8432aab0 ("Input: synaptics-rmi4 - support regulator supplies")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-b4-rmi4-wa=
keup-v1-0-1b662be4a9d6@enser.io?part=3D2
