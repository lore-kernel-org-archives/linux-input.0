Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6BB3BD62C;
	Tue, 17 Mar 2026 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749671; cv=none; b=tGJKotaegc4Xfk3e0hpMwApKmceo8ANpi08rWrlTqGRXip0snwZdrSajT2xBvhr76B7yvHigDluU58OkGRhHSCVFJB1jbF3yYtseDth9Dxr0RjZpnm5wnISBf6O+BaWAF27j22ovwC9GTZiT+OiC+gAKNvhfmKoyTyy/+uMc7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749671; c=relaxed/simple;
	bh=ASygDz6sSyIaS0SK9AEjmrDyiQzlpOSdO5zzoTwoSAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLMWvr6zYRv9u94PUeT0NrTrErvN9tvrO+mTRPgn1OarsZlvzOhBjCH+MeUDKd78SqgVI/hYsMkPzDvhyLYRjwxZpHGh2HRP82vWaydTf8VmMP2PFYI07NpHnc3HjKZvvCV4Y533reoyjbtE/f6McU5seSDjDuYSw4Ux8HHBmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psKJRogf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psKJRogf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A44C4AF09;
	Tue, 17 Mar 2026 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773749670;
	bh=ASygDz6sSyIaS0SK9AEjmrDyiQzlpOSdO5zzoTwoSAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psKJRogfzJ1edm/+wq9dJJQuZnEGVCDan6uRoAobtKLifYZLurY8CqxasGWZ+Fpic
	 rwNWm0X11isCNKnp6+l2+6fwXU/92Yzai31Gk82laFALoniSwXuHtmcieV8d8KGbU7
	 Ya4/zgJ1/HhFVjoJfzDCmvsl5vKtcIBFaLssWeLjDkfSUogrFUtQNYIeAcYNw14+0U
	 hOpWzpPDB6kSW1wfYuPkrBrlWiwT5rUpiNDlHIZ1LMBQPTpfrNK0OnPE0Ygf3CD9Ii
	 Yy2LiA9+ir3CsP8oOta0SFk2To5GYjX30yKerMR2+JTCjV0fkzFEE5lo9wA/cupgc9
	 zraV4E1pFuggQ==
Date: Tue, 17 Mar 2026 12:14:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: phucduc.bui@gmail.com, robh@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
	krzk+dt@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, marex@denx.de, mingo@kernel.org,
	tglx@kernel.org
Subject: Re: [PATCH v2] dt-bindings: input: touchscreen: ti,tsc2005: Add
 wakeup-source
Message-ID: <20260317-another-wrongdoer-5b4c56ab6027@spud>
References: <20260316034606.11304-1-phucduc.bui@gmail.com>
 <20260316-refusal-disband-54161c7b96e0@spud>
 <fef8779a-a5e6-45f0-82dd-0cd8a892c0ea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aMWwtA2HMBOPqCXl"
Content-Disposition: inline
In-Reply-To: <fef8779a-a5e6-45f0-82dd-0cd8a892c0ea@kernel.org>


--aMWwtA2HMBOPqCXl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 06:10:23PM +0100, Krzysztof Kozlowski wrote:
> On 16/03/2026 12:13, Conor Dooley wrote:
> > On Mon, Mar 16, 2026 at 10:46:06AM +0700, phucduc.bui@gmail.com wrote:
> >> From: bui duc phuc <phucduc.bui@gmail.com>
> >>
> >> Document the "wakeup-source" property for the ti,tsc2005 touchscreen
> >> controllers to allow the device to wake the system from suspend.
> >>
> >> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> >> ---
> >>  .../devicetree/bindings/input/touchscreen/ti,tsc2005.yaml  | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,ts=
c2005.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005=
=2Eyaml
> >> index 7187c390b2f5..c0aae044d7d4 100644
> >> --- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.y=
aml
> >> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.y=
aml
> >> @@ -55,6 +55,9 @@ properties:
> >>    touchscreen-size-x: true
> >>    touchscreen-size-y: true
> >> =20
> >> +  wakeup-source:
> >> +    type: boolean
> >=20
> > wakeup-source: true
>=20
> I am not so sure.
>=20
> The property is multi-type, so we want to choose one - bool, IMO,
> because device cannot wakeup the specific system idle states. Or am I
> misinterpreting the phandles behind wakeup-source and every device can
> be differently routed in such system?

I checked before my original comment, and there there's a bout a 2:1
ratio of defined v true. I suppose my comment can be ignored, I am just
used to this always being true.

--aMWwtA2HMBOPqCXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCablFngAKCRB4tDGHoIJi
0kEeAP98umSSJX6oyrbjuxf17H3ujp+qm5Zy7r0h4GxQl0mk1AEAsFnjPGl0nSRf
rYL/rNVk7TQ2dfmndai7Wo1Euwklgg4=
=/+ge
-----END PGP SIGNATURE-----

--aMWwtA2HMBOPqCXl--
