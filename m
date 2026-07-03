Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39B35677D
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056109; cv=none; b=kwD/xzei4gz4fDDsfrPba7CSgEtaYezKzKt7bnb1kyhip9VyTDaZawM5mh4QzY8quy1Ibv/lHBE2QSJnoqgZXV5hfleHYeSun12t3PBd3qPeS+flm0aRttpzulFLTerVCDgd1spFmBp2AAe5oa3datwv+P9vPB2FgE6KlmvTG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056109; c=relaxed/simple;
	bh=ungXM+pGccTPmY4MYi+TOmQLabp5apMUzorBXrm5qVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq1Pt0kA+cqTaDcZ1JRyx4BTsYIuWIaevwnvE52tBt52WS90tleIqe63SePW5v0lk3neI2awrWkB9YY6qvQoHBI+D+InNp2ruClPVxH0t6vwh42ysLFyEscaSU22bCddIT+cjKAniLFZO3+/enhJFWNZSax8MokQuZaEJL4jvf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+kVEf1z; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+kVEf1z"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a192afad7dso65901eaf.2
        for <linux-input@vger.kernel.org>; Thu, 02 Jul 2026 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783056101; x=1783660901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rbrF5PgluXo296yF8wu1iDrFOX+6QVWi9u8cpBpxPXM=;
        b=h+kVEf1z6+OUrrAyxKRdwJjeEEDGg+rG8cF484EV4vUNX33SgP84/tqzO/tWZcxZZG
         lLqZtJMpLTplvc5dNg09j5raiJ0qFSOMpngjR1Cv6YoO3+WP1vyenhsHoRMwIuZ05Cni
         lC4VzpI+njML3iNw5w0E1aZRA2T5eOaRJU7uJAUCKhYf19vVLw/ZrcnDdS+qUtIZ/QG7
         N/lOKYdlgHJeQ/VntPRGTXyJ0y94ci6Xk0T3JrQKK687yEEQ9s31ZApWcpdii4Y2hIq3
         OLRIe7iHrAQScSLI1sg8oT89oDNPl+JGr4b4NaU7P2mZTofRTSCTvnLQK1JcV7XKomx9
         Pzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783056101; x=1783660901;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbrF5PgluXo296yF8wu1iDrFOX+6QVWi9u8cpBpxPXM=;
        b=hHDWL30JS99hrOkT1vrjFd/yKJtwweVymVTxTz9xgYkxOKHVKIq3nMi+oqLZ7nIweh
         eZp+zkM2p8f+JappOzVgRViyJ57qQcotqiE94F8M6C+TKeWTPylhxffWck65k/gwMu+9
         1Bg+vDvNT0F/OLSWtIN+COSAyHGnbzOBSqG8tmqDaOr1kpjDdcLJxi/ltHwsGiyfhUn/
         nz9kxvby79iN4T07O1s65gzEVS0QNdU3ZvkxD0FaVWYD0WhEozYdRg52ajEh63oNhJL0
         jwTr2gu0z3IBmqAJ80rIPjHvB2vllcgy/U2Uh62NNTBTiZ+RZWEOtfbCDJzznRthyXWV
         Nwng==
X-Forwarded-Encrypted: i=1; AFNElJ9rp5S7gmzeYWuWKD5ynY5+/qvw58vobrEEUMtOGBmclio36c7oBK8iskOpapGzZVQT7PvmUn9rUB/eXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5qZwRzMAlZ+CzlyFqmBbaYSq2j60lSUaj0SaXZr3W4cRh9dk5
	s6B+FrTjKWT0opj8Tg/LOMYb9N5m+bxGtfewUCBFCm81utJ4ykrLZn4b
X-Gm-Gg: AfdE7cmMR3Tr7DJQ1Lki7xcTbQj9QSNgIeWEG5E9OZ8PSozr2qPaYOHVqtiSXnNKrEq
	wjsKlAflUEMBD4FQIHV8enggNC2fouSU/mq+gsDq0tPC5rlAAkvJ18Hqg2bLQFMjmDbMeVvkRRj
	sS/ht9jNSD86nSdgyZuCUg6yzlb7Tq+r6kS4MotI6amIMKSKoFt13KBl/WQOYOJ/qHv+If04z9d
	QlxtwSeRXTwWTktlmcpsM5U4okCUqj38jsWdFJ22DqlruqVtsW48IauXit82KihFtBeJ7POjqRZ
	k0R8bLsUGIGXEwYG1Zs0GLN+VSRJPiAoa3XgdpHenJi++EGcshknRbwea0WgyDUs5p/E5kHcOM4
	KAW+HKshE8idwck1EdodyFlyB3QgwloGOXbLFq75pSCPJ5W1PhMI3mjo8ZY3GHOWUXl+8JI4Jg+
	YOXeYYWr37sdEDJOM/EQqE
X-Received: by 2002:a05:6820:4c01:b0:6a3:9ce:5412 with SMTP id 006d021491bc7-6a30d887c40mr4436494eaf.38.1783056101413;
        Thu, 02 Jul 2026 22:21:41 -0700 (PDT)
Received: from gmail.com ([2600:1702:56e9:4b40:ff21:65e6:6e3:5b43])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb1d011asm894391fac.8.2026.07.02.22.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:21:41 -0700 (PDT)
Date: Fri, 3 Jul 2026 00:21:38 -0500
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-tegra@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: media: remove obsolete rc.txt
Message-ID: <akc_pO_ctTiZmbFw@gmail.com>
References: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
 <20260603-b4-remove-redirect-stubs-v2-2-c8c19876ab64@gmail.com>
 <178052520503.2279647.12293343206224505400.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178052520503.2279647.12293343206224505400.robh@kernel.org>

On Wed, Jun 03, 2026 at 05:20:05PM -0500, Rob Herring (Arm) wrote:
> 
> On Wed, 03 Jun 2026 15:42:19 -0500, Akash Sukhavasi wrote:
> > rc.txt has been a single-line redirect to rc.yaml since
> > commit 7c31b9d67342 ("media: dt-bindings: media: Add YAML schemas for
> > the generic RC bindings"), which introduced the .yaml schema and
> > reduced the .txt to a stub in the same change. The .yaml has the same
> > filename in the same directory, making this redirect unnecessary
> > for discoverability.
> > 
> > One file still references rc.txt, forcing readers through an extra
> > hop to reach the .yaml. The stub has not been touched since August
> > 2019. Update the reference in hix5hd2-ir.txt to point directly to
> > rc.yaml and remove the stub.
> > 
> > Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/media/hix5hd2-ir.txt | 2 +-
> >  Documentation/devicetree/bindings/media/rc.txt         | 1 -
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 

Friendly ping on this one. Rob's Acked-by has been on v2 since June 3
and the patch still applies cleanly.

-- 
Thanks,
Akash
