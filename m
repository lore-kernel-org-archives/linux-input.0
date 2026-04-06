Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41742280309
	for <linux-input@vger.kernel.org>; Mon,  6 Apr 2026 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775502130; cv=none; b=RMSaJLIvaeM77x9j0w+ktNUVjxRbR2idbyDhqR92FT1g2LoyCpDhJC3CgoYDH6QzbpEmw0hkM8kyb7WatNfACWnQJLcpAxk2QlcBlXzWBaTn59dK4Vw7HCdOXpzNhVciM5uGcOnE2bzwlmk+PQlMNKTgazhaAqeCym/2yFnRDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775502130; c=relaxed/simple;
	bh=v+9KS65MHbrp/p6HVIZ/3YQz/WeqheDUGbseYa3ndMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwkdegcDxh3HI/NDFzpWQFSk/Y7YGynVjkhPg7GMQs5hMcZMe+5FaPKM9PoMbe9VmnHxaqhy0wUioAGHPtO+KBpK4ObDsP6UaIw9Xosyg1n3xiAiQxUYkcFWhM/bqvwLUq8BwBOAttFla3EGOykzoMww+XnJZsAUjlu5qTcZilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj8QmBOd; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj8QmBOd"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1271195d2a7so9141141c88.0
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775502127; x=1776106927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NSe2oQTkbqvMIVuDSTJwJ6bnD+odJ4jguUD7R1d/gBI=;
        b=Pj8QmBOd4oXbftGbrxR5Pwu1i2RuXm5c1wVeu7hf/Dwxf32NXrIbYukukF07EGEwOa
         TebJp+tHUiqSkTJGjpJmT5Kh1duQKpkQcvV3PctibhK0pUJ2VJtapRrN2WMsdze73VMj
         VUO9FLC/dERatTGuWBppGa3GUEkqF9hUBXJtxTZF6+pxOq07dU8IGengI38FSUXOO4wr
         FozaDC913B2pkbmlaGQCUsuN84W11KvRWW+axULZZSXSPMT/3j9ythUF+7dG+JubFUfd
         6Qg8rfCavKHZb/UALLsZgy92+CrKDhtkLsEN4Pmm1ON5tb3DFZYNMLkzvdG1A2jVKD89
         b6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775502127; x=1776106927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSe2oQTkbqvMIVuDSTJwJ6bnD+odJ4jguUD7R1d/gBI=;
        b=lK8XRSr/9l8+UmL3nc0iJg5mLtz3+GN1oGqEaxpZB2GraY3+Or5sqUserUAxKd4CG6
         s7XyXvjED87Xs1mBIRN+OBNZFo3vNqrnAVKD4cr2HSIm0EYAaEpEbAU+olB+SIrk4NfC
         4T70YfCKLUMJGXVqI1JI+X4w/9SPJXYZF7xOTY2pkAp+D81fzzPzODfmYiBBn0rBbNjP
         +lyi3J2b99663SNqkRyQghgTd3UgvExDEPe8igDEaPz08hrcWDmfLcWzvu4gT3L9yuRT
         4VWIy2CjdL1n/fOirI/uGUgOLEujkAIilE6jY3VakSpVuvz253PWr5NQ1c08ymHQJo43
         FkHA==
X-Forwarded-Encrypted: i=1; AJvYcCXOfn0OmeKwIETOVJYl6G1XVPuuekgGXAEiKe2/Lurqb8epBEd7BqEPYV0PrYb39iH8FlNko78mHjMmLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGdpxM7sbQm2xpfaa3wBZK5PgwvbB53/R3yOpQYbh+bfX8Pwgf
	4Lwf1KH1IaiD2BSiyKBxfGVNm8/cGcdtaPaC2Hfhbh/vQwv0EZoDQqiV
X-Gm-Gg: AeBDieuQTGnGD8htHeISIPS6f8OE2+l8A9RHSdu1VnztlRpt2BXONl3mcjWhjpl/iB1
	TcLzH0Ov7pQK5plmEgXEDPOt4NTBwwqB+sqLGRGCqUfah5gU7d2emyRKI35kYynW3oICeFFQJmY
	CSUwUS9YXYjBuwd8UU0E7mXssKwjgl8oeJWF4Yhc3mxnPRF83kIhQaJcrOOrvPY8Pw6SVSp7WxK
	gxgp6E0JebTWyhCjh15eFYusYrk+pXpyEI8Gmd8TnGGMPvwrSx/rjXO1S+2QhF6KdXmpb1hA6ak
	Bx/FDFrkvMIDF2KBFLQRq0QZlPiLTBz0qaOwc3dNK7jW/oeRPUk7ugOf8qQ/GCdB6qBrLjct5GM
	e8DT7Q7enGThQ1VNvcaTOKbOJJ5NTBdXkK5Bny9+EfzUOAmIyTeS/iBOwAwGQGiawEIwYKKhT7X
	WO48rq/ubzJVyxZwo8cNvOQr5r0iMeMWmd4jRFgsNFM6PnVa+zUiYfSsl6lL8IyrDQ
X-Received: by 2002:a05:701b:270e:b0:12b:fc21:874d with SMTP id a92af1059eb24-12bfc218ac5mr3524770c88.19.1775502127119;
        Mon, 06 Apr 2026 12:02:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:dd71:7176:b4e4:a7a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c05a7beffsm6197436c88.15.2026.04.06.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 12:02:06 -0700 (PDT)
Date: Mon, 6 Apr 2026 12:02:03 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] input: pc110pad: change PCI check to get rid of
 orphaned no_pci_devices
Message-ID: <adQCShxoHCwfcwlm@google.com>
References: <cf519463-775a-4d43-be38-20742fdad407@gmail.com>
 <20260406172324.GA170281@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406172324.GA170281@bhelgaas>

On Mon, Apr 06, 2026 at 12:23:24PM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 03, 2026 at 12:17:35AM +0200, Heiner Kallweit wrote:
> > As a prerequisite for removing no_pci_devices(), replace its usage here
> > with an equivalent check for presence of a PCI bus.
> > 
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> >  drivers/input/mouse/pc110pad.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/mouse/pc110pad.c b/drivers/input/mouse/pc110pad.c
> > index efa58049f..c7a6df210 100644
> > --- a/drivers/input/mouse/pc110pad.c
> > +++ b/drivers/input/mouse/pc110pad.c
> > @@ -91,7 +91,7 @@ static int __init pc110pad_init(void)
> >  {
> >  	int err;
> >  
> > -	if (!no_pci_devices())
> > +	if (pci_find_next_bus(NULL))
> >  		return -ENODEV;
> 
> I'd certainly love to get rid of no_pci_devices(), although using
> pci_find_next_bus() is not really much better.
> 
> I don't have much opinion about pc110pad.c change.  It's essentially
> still the same kludge, which has been there at least since the
> beginning of git history.
> 
> Dmitry, if you want to ack this, I can take both together.

Given "x86/cpu: Remove M486/M486SX/ELAN support" I'd just drop the
driver completely.

I tried it in 2024 but Maciej was insistent that keeping these old
drivers doe snot hurt. Now I think we can get rid of them.

You can grab the patch removing it from
https://lore.kernel.org/all/20240808172733.1194442-4-dmitry.torokhov@gmail.com/
as I think it should still apply.

Thanks.

-- 
Dmitry
