Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754D175A7F
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801054; cv=pass; b=Px6D70HOcjHtK1HPIO4MLhHcHcWfvbfrs+sAA7D3eacFmMTu4K30xe0wydwZZsn3GzFuLdHE5m4nFNHNwlPbOnPD4Z8f2KDsEMjkNKeC2EKCmw6hIPutG4g/aJnxCVCGClQlFcgeX+MpbWfHIdWxHR/xsA3XH7aX7EFetGcoY7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801054; c=relaxed/simple;
	bh=fy+it17j0+Ps8nxeetEypnBbCisckeo5PoSg9rMpSaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8PZ2+8+4cJF5c2iqYdldS71DOpXGXJUFcPkbzqYGRVgwML4+MrTfjpejmfvS/2LFYQHf1cOfWA1PyMbhyGe3jqsCUJRvJLk1S2SM/Is2DNIs4Kup5bdxdrpty3eWtoBxZ74kfzMnOR2sf8ZnN3H9rurkCKMSEExqYZWO5aV2Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoHoJnLa; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoHoJnLa"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35b90d6fe14so2264281a91.2
        for <linux-input@vger.kernel.org>; Tue, 17 Mar 2026 19:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773801051; cv=none;
        d=google.com; s=arc-20240605;
        b=NwO7zJp5tQo0RWNM4Vz5rBOLmBIDjrOzktKTsdahI5BzPdFnAahwxvQsSQQXs+BXW3
         lTT14OoiCt/bW+r8vOmXRnW2Ubwu/nwItWo4VXv21aBwm1qB3I/G3QSyRZryoNkFkbKQ
         w/ajcIlnk8gblUEaNnP2e/td6WRtDk6vM3v+/AAAy8RqQte4dX1aKgvgfPfQfBpFGt4z
         ISiuhm5SSGXNMoIEzdU+Noj7O4kfwwcRo9/yq1c6aDBwQgZe156bliTlT4vKKvxierqm
         AXxW2PnvGUoEyu8b/ZI8skxhadERcmLNy9Lgn+vST/j6CI1oSAq4vgN24q7hNFKqU/UK
         fL+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aq4o9QA1m9WGEfjaZga/92v/xHZ+8tcWtIREIt3RUjQ=;
        fh=X7tsTCRFxWdPH3EA4Mn4IcSACpnrgGBr8mOPta9gOSk=;
        b=aQ/aNzxdPqJ3+5BQ3o6aCI1jWXqoQEuBJpsXdPAw8qh+8Q/vFZsuPra4t1Jo2PdQ42
         V0HW5ZawuJRD3arseUEIlyFIWS5JDeUJa/2mnl4jw/y6BdIZa55UflYalR0Ew2xaXgll
         xdad/sQ4WKj/HYTfLTPb6ab5SztdzvMSuzV8vyxPwOQui7Sj+TxWsrVH8tCbfDVrgaT+
         O0d1zy8Bqwjz245s3qts5EmaYAAaFgh0S+IbQosv9iMwfwMtm8ABfhVcxdfx6gUf87SA
         dPlEuMbfTFsuE0MP2M9F3rL6kxMq2RcqIEthv9rIpcuLUwTjsKiqeWZBwSoFjt10hVGB
         SecA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773801051; x=1774405851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq4o9QA1m9WGEfjaZga/92v/xHZ+8tcWtIREIt3RUjQ=;
        b=BoHoJnLakeDvMm3ioyQkb01V9A31DAxJj/thy0/aRrGAc6fFbsg66dVhqtos1H7iKc
         7OI4HQKBap58a/6jx9df7QoXC5m4RGp9cFVPU5RIatALy8/jlBHzWNyDfEGAI+UMIWsg
         vKVIyDiT7MMkPttfaz+PQG7pkkH3dy9ygEN7EXn1PnZA8caxVCxWPMPETWbVG5+86KrM
         GA2voLMQedGNPjDdp58K/4CkAXybPcV7KUBV45S85xxV4NfHr5UJ3dFiHCmXrfixbuD6
         kDfJWu5ydD+hPDJCVN9fI8zaaEKLwcaqz7sIyQTp7GKzYyfRqchQTv9Mj10zUIcXxT0I
         b21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773801051; x=1774405851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aq4o9QA1m9WGEfjaZga/92v/xHZ+8tcWtIREIt3RUjQ=;
        b=XuMcW6x2NMmKYKmNvvq27AZHKmqxXauzFknot8/Yq5lCo+5vD93Kn5k3K+Ux+O86Vz
         nHd1PtDZmAUbXwLs0zI13vEr6uuBtH312issKD9x0bMfqkNByCOHKBtY5hYIduQLobeI
         /2eT/teqb9j4C1B+skmfBIbYnWJQLLhbm+a60TRmAARw7XMstbMtV9lPId9hjARUkj01
         IPw+6+GX0iXfMD1l3FHH8bauRpOEnW1H3ftHmfybALLMO7cFkh15OxMpnpvPh+30SXo+
         HlkrRetmBbZcZ+6RhW/RX4fTQLPFfSdUDfdFLfdeyeL29EYshqGu/weXOohigvsbNaeh
         04gw==
X-Forwarded-Encrypted: i=1; AJvYcCVDvinJdRqvUU5ogJNWPtglzNGurskspE6xHxxcqAxCfkgE/N3B+CyFWtLZWnzbMhAXS9PbT3pE3U3fjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj3cj0nO7J/+ff4IPJ4GuTTPUM4pOka64TdfGGO83EnkKICFDO
	KSARRUZ0QheD3ujXM2AaL39s1LGfTrGUosmy5xJ+gVORY9GkY+3bl6hUx1GxxsdMjfwWrBVBNan
	zHzLBgcebAZBF3YeMklcHTudC/QJrWpc=
X-Gm-Gg: ATEYQzzUCM37fky6u8QFUYVQpTPujZa15rNeqYZjw2KwLpSKhRQMrwcHvXY6X+7b2fX
	nx5I5VeUCW1lHlHh6XUV8e3KYlWiptsvA9OqsIek4KGO48F9ex9+X8hcnf+LIXB7br1gcR8b1v6
	YWJQRygyUfiiJzervkkRUgWqLI7yi2ZQ6GU+Bganygn+smdd/BJ3PdeTtUUp6WOE+KVPy20Y+pp
	QTDgeG1+TKH7OIUxkNtuldHVU0rUEPHVxZikJvvpqnX4p6/WJTl0JOYZhGxtMZkW5T25YDw4G27
	oDW2BF8MwomcJgPqVuklZgTLO/Ds06WOalBJ9QgaOrMXfl2r
X-Received: by 2002:a17:90b:4ccb:b0:356:1db4:8fe5 with SMTP id
 98e67ed59e1d1-35bb9f477f0mr1591451a91.29.1773801051076; Tue, 17 Mar 2026
 19:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316034606.11304-1-phucduc.bui@gmail.com> <20260316-refusal-disband-54161c7b96e0@spud>
 <fef8779a-a5e6-45f0-82dd-0cd8a892c0ea@kernel.org> <20260317-another-wrongdoer-5b4c56ab6027@spud>
In-Reply-To: <20260317-another-wrongdoer-5b4c56ab6027@spud>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 18 Mar 2026 09:30:39 +0700
X-Gm-Features: AaiRm53uUzVLsNfk0d_vpvS972DrNGMXHue77LwQ9-whJ0zALN--Uym6f8-JxYI
Message-ID: <CAABR9nHO1L8PokYV8=hpEYwz4-pXfnvPFQ=qOob3w1GRL3U2oA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: input: touchscreen: ti,tsc2005: Add wakeup-source
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, krzk+dt@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, marex@denx.de, 
	mingo@kernel.org, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor, Krzysztof,

Thanks for the review.
I will remove the extra blank line in the next version.
As for the wakeup-source property, I'll keep it as a boolean as per the cur=
rent
patch.

Best Regards,
Phuc

On Tue, Mar 17, 2026 at 7:14=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Mar 16, 2026 at 06:10:23PM +0100, Krzysztof Kozlowski wrote:
> > On 16/03/2026 12:13, Conor Dooley wrote:
> > > On Mon, Mar 16, 2026 at 10:46:06AM +0700, phucduc.bui@gmail.com wrote=
:
> > >> From: bui duc phuc <phucduc.bui@gmail.com>
> > >>
> > >> Document the "wakeup-source" property for the ti,tsc2005 touchscreen
> > >> controllers to allow the device to wake the system from suspend.
> > >>
> > >> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> > >> ---
> > >>  .../devicetree/bindings/input/touchscreen/ti,tsc2005.yaml  | 7 ++++=
+++
> > >>  1 file changed, 7 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,=
tsc2005.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc20=
05.yaml
> > >> index 7187c390b2f5..c0aae044d7d4 100644
> > >> --- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005=
.yaml
> > >> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005=
.yaml
> > >> @@ -55,6 +55,9 @@ properties:
> > >>    touchscreen-size-x: true
> > >>    touchscreen-size-y: true
> > >>
> > >> +  wakeup-source:
> > >> +    type: boolean
> > >
> > > wakeup-source: true
> >
> > I am not so sure.
> >
> > The property is multi-type, so we want to choose one - bool, IMO,
> > because device cannot wakeup the specific system idle states. Or am I
> > misinterpreting the phandles behind wakeup-source and every device can
> > be differently routed in such system?
>
> I checked before my original comment, and there there's a bout a 2:1
> ratio of defined v true. I suppose my comment can be ignored, I am just
> used to this always being true.
