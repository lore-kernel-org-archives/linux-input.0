Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3772CCB9
	for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 04:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777177706; cv=none; b=LgyD9x/+rXWXTcHK9k5+uKRMupfyneSeCyXedQpQ4TeVlS/vKQxFz8ubjw9bofCvU3ZJQO8qc54QwImGusPSuVlGVOV6XbtuFTcXdhiq+JqljlYgI2mS/4z4P90kAsBox6qvjk0n9uKN/RyVzKN0acSwvxOzklfwWZECMz3AiOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777177706; c=relaxed/simple;
	bh=xfsZPFOGlUAzwf6fVdJkq3KKTEcKYX3z+4B7g9iLlg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJr895xaqlpVIHqBm1YAS7rFeNqdNED0bddQqmQ1WSgGZnIgxP5SyVtp3odu6jXLujRy4M3dQqNP50IAcAQ2GTUr1bcT8sOKgsFzhoYllZA0ErMUOidor35oO9ESiSuiamHFQ2Mmi4Cm+EP8SHMoQt1DQGA2GJ9QxvxUe7QZ/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXO8iZFh; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXO8iZFh"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c19d23b19so11799978c88.0
        for <linux-input@vger.kernel.org>; Sat, 25 Apr 2026 21:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777177704; x=1777782504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QiNFy+Pe1YgCLRW9GTmW/74h6LPgkfDMo8eqshh65go=;
        b=SXO8iZFhFi1r/kJsdK5V9uWeO4e5mjKh31DUnYKRXyTk6K4SOPZeBGTKTvBwLtCw2x
         WhdS4aI4IF3BumeSNeupmPMRKTxSFTdXjVlYLH7gsV3/X+XR744w6M1AFfjLIVhcx2VM
         Sez89YAw0ylalI9gBzccKIDeC8jPucbFS87AoegssrB1lKvPbhFAT4P5viNVzCYrnvTM
         tVV4haq5o59yVFYwekBL0d1ZXlyLgYRK1mx/hQrA6rN/wcr+/r2PKZWChOFr3TovmNes
         1dlA9fQtmAt6TA0tPEjc8+FOFPfSS/bOejh4NeVisAbgt2llYl4rUeZ1K8aCcjJAKzlQ
         B02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777177704; x=1777782504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiNFy+Pe1YgCLRW9GTmW/74h6LPgkfDMo8eqshh65go=;
        b=G6XRTsOawVKhJjQW0lrpzK99K3zLOyL2YI4g+C2KL4wIY5BKZor/8z4W8L8SrKpMZB
         MFIkBD8J137HYyIaE1dsUOd7OsmmdXJy8BiJrjoHtz5GHkrdMP/A+Z0Aj/j9ISAm5uxg
         hBbMgYIKyPt9bLM1FnywQEglEZICePjRf2AXT6sx8ZCaT/csaq24tjlSLrPKxL3WCjLC
         TX64bRW19ohWn+KC51A+BaDzPKHeoi/L9kcp063QYV5TrM0AOQhUhTJ9cyagVN9smOfh
         ff8OfYsNOKyposhugZMhVD0w5GhgRaLkP2SgXxIaqS+pj4LunLNkC2uAj4GlYoP1EhwS
         bMZQ==
X-Forwarded-Encrypted: i=1; AFNElJ82vwTG6D0bQ3UQOFl04fp0CvatipPLFbBYwZrQ3PG6d/+bPbDIzXY5wy0umqDMDST48cy1cNIHRd/JqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbrzHMQxBUesx4m86Rflk9NGkrP02V3JLFwFGxHXjvcIgEymf
	oe0z6JSjw2ldSdP5X8LQ7pL8wa4oopWL/ykq6G8aaeRBEWELrZicnh5X
X-Gm-Gg: AeBDies1CFAloxIJ9wYcUW7qik/K1ZI3J6r+ILw12OTEhFmrmFxol2bQdIpD8rNpxtz
	1SxveDAKQp0ZvV2WJTELOsZrPH0KW+TqFXU6jSTE+VIl86s0lRxTuotUm2pI7HgnSyCOa9L4byo
	JX7YszPY5htdLdR1YPl+ta2hylfWQTVjmJ6p5Psgz9zD4LjsFRbueD5L7ORFmILE1H8ufMuTE+v
	AcioV/y5f1kGV//mmWzL1mIWhczLYUJnJbi9d9drD8MZTAYoH4bhFRtTuJbzabfxCe5ZEl4dl7w
	6XVLBqCCd5UQCScZAgcyt28j9batKxu2B9+RFqU2gRH91xql9ILWZa+tOV/UQFP5v7P1Lk/I5Qm
	rFeX8fYzwFlPWkNKEvb3U45cs4zYuLEbgEJAOV7m0rL6Kidi03+5wDiAjbxej1igtrZf9IYkJ8k
	MjLJIP/AAiOUCDZR5aGNuEgm2qLFbnfBJYHHNQ038FgAA7iuXG3Ag2gZ7VAPMsK+Gpovwik0S6a
	8Y=
X-Received: by 2002:a05:7022:fe08:b0:12b:f881:d8d0 with SMTP id a92af1059eb24-12c73f9987dmr19784551c88.18.1777177704040;
        Sat, 25 Apr 2026 21:28:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f359:aa0c:530d:9dfd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c837f7feasm46022289c88.0.2026.04.25.21.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 21:28:23 -0700 (PDT)
Date: Sat, 25 Apr 2026 21:28:20 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] Input: isa1200 - new driver for Imagis ISA1200
Message-ID: <ae2TswfLCEACzPcg@google.com>
References: <20260424071305.89503-1-clamor95@gmail.com>
 <20260424071305.89503-3-clamor95@gmail.com>
 <aeuMn2w3kSUl-wxF@google.com>
 <CAPVz0n1POe_YuA+RyvLLUdO2D526hb_YQUXJb72Y1h6mW8M6kQ@mail.gmail.com>
 <CAPVz0n2-JE6E10O_rFZYPSET62HfAz3Zw8vyNa8xoALQQJR7Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPVz0n2-JE6E10O_rFZYPSET62HfAz3Zw8vyNa8xoALQQJR7Xw@mail.gmail.com>

Hi Svyatoslav,

On Sat, Apr 25, 2026 at 08:26:00PM +0300, Svyatoslav Ryhel wrote:
> Hello Dmitry!
> 
> I have a question regarding this sashiko comment
> 
> > +static void isa1200_play_work(struct work_struct *work)
> > +{
> > + struct isa1200 *isa =
> > + container_of(work, struct isa1200, play_work);
> > +
> > + if (isa->level)
> > + isa1200_start(isa);
> > + else
> > + isa1200_stop(isa);
> > +}
> Because the driver tracks isa->level locklessly, if an effect starts
> and quickly stops, the workqueue might only execute once. When it
> executes, it sees isa->level == 0 and calls isa1200_stop(). Since
> isa1200_start() was never called for this effect,
> clk_disable_unprepare(isa->clk) will be invoked on an un-enabled
> clock. Does this unbalance the clock reference count?
> 
> This is a valid comment, but I cannot find how this should be handled
> among all available haptic drivers. Maybe you can point me in the
> right direction?

Maybe have a flag reflecting the true (committed) state of the
controller that is both checked and updated in the work entity?

Thanks.

-- 
Dmitry
