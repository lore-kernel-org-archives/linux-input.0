Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFE535CBD7;
	Sun,  4 Oct 2026 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098995; cv=none; b=Lc8vqet4uKENUTuWNamxm7TXRvhD0lCM4lZWAPU6nrnU8tYnVSqvBZ2zganBpp4rtXltaz/zRKO/SrX2dQS+3FDOIRjAWStA5AmcHtT78Pnr1b9RCkXpgiia+7L15Ib25XXTb4bpzzQgY85h6kw8uxR/vm+pQbxUZAFUuKc0vsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098995; c=relaxed/simple;
	bh=ezU5nc91kZRA4PODLxsbvVdARpiGWc0gx5/97ztJ3Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3cIURKW7XEJ95tgtarEPpDJDuqHVoZqdPft7pAFbQxFEapcTOUMG6FCOeolRqGhim/BAzOEYor1GH9cZPlblhhLgnxFAIyc8XTYytg40cOmrUl8mOMlZML1mWjyHxJUq6iFbjN1boA6IzUx/O8g2xgY0IAMPXFAZLIQ9PRpgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xDGfK-000000004Mc-01Gd;
	Sun, 04 Oct 2026 07:29:46 +0000
Date: Sun, 4 Oct 2026 08:29:39 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hendrik Noack <hendrik-noack@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
	Ferass El Hafidi <funderscore@postmarketos.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: input: touchscreen:
 hynitron,cst816x: axes and panel
Message-ID: <asIAQMF57X2-YZKi@makrotopia.org>
References: <cover.1790944534.git.daniel@makrotopia.org>
 <04a70b1cb0969ec4e4b38f7945e0b22a977b038b.1790944534.git.daniel@makrotopia.org>
 <20261004-unbreakable-funny-guan-73da47@quoll>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-unbreakable-funny-guan-73da47@quoll>

On Sun, Oct 04, 2026 at 09:24:26AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Oct 02, 2026 at 01:47:21PM +0100, Daniel Golle wrote:
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
> > index 72d4da636881e..027a2b3dcf2e8 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
> > @@ -36,6 +36,18 @@ properties:
> >        - description: Slide right gesture
> >        - description: Long press gesture
> >  
> > +  panel: true
> > +
> > +  touchscreen-min-x: true
> > +  touchscreen-min-y: true
> > +  touchscreen-size-x: true
> > +  touchscreen-size-y: true
> > +  touchscreen-fuzz-x: true
> > +  touchscreen-fuzz-y: true
> > +  touchscreen-inverted-x: true
> > +  touchscreen-inverted-y: true
> > +  touchscreen-swapped-x-y: true
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -43,6 +55,9 @@ required:
> >  
> >  additionalProperties: false
> 
> So just use unevaluatedProperties instead of listing almost entire
> contents of touchscreen.yaml.
> 

"almost" is the keyword here. If it is acceptable to include properties
the driver doesn't (and will never) parse, I'll do that instead.

