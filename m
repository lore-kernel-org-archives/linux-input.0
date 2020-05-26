Return-Path: <SRS0=UvBs=7I=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8A0C433DF
	for <linux-input@archiver.kernel.org>; Tue, 26 May 2020 22:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC16E2075F
	for <linux-input@archiver.kernel.org>; Tue, 26 May 2020 22:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590533450;
	bh=ozs6kk4QMVleSXTPi07onyUD4b1gzUsm5XeeXg9GX6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zvk6VTO8otvh2svvgey+cPHXcAzVoFS+IqAXRfWCD098IpkswSVD9Zyyzo6v9RXnC
	 83OWJxcFPr5mtYYYesu75fQTYAkjPC8V4g7O9aVUKI1td/dwZyX3jXt6r/9azpMsD/
	 MopBYp82umHAEhUW0BSsIJb8W1y4RNf2RcEmS6b0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391488AbgEZWut (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 26 May 2020 18:50:49 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35062 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391442AbgEZWut (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 May 2020 18:50:49 -0400
Received: by mail-il1-f196.google.com with SMTP id a14so22192421ilk.2;
        Tue, 26 May 2020 15:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OK9x5VtJCjk7ns+n8rJJ2eqoCOZIYQWVhZELo9bv0M0=;
        b=mPZxenhO6+VsldV4M5xifDcn7RMO5dSf6D1+84FOSeWqtWooaMB8UVxzHpdGNGjRaW
         N7pYBIf2pSSE4dyuopVVYMedRaVAA29OTFPZw6nNA4BV3llqgrimLHRN0a3ZZlAp9tzJ
         wmOATmF+i2jbdeHc1g7RtDE28ejzjvQbE7SRhOYRX//JXf5b66dnRx76/WkYBjelnMlc
         ZlfyLnlMvKuNFWfubJv2stXZ+b/7tqHsuzKtlhG93ikAuRkELWefnSiAwoBDtkPJ45At
         6tbgvHwYMSmBWIoIfAFMWvcQOLMWSya9udAXcUV8CDz1jIIqHbMKiEzd3TeUG4ejeMa9
         XliQ==
X-Gm-Message-State: AOAM531PF+smw7TcrZMOdXNF4wY9EWMQMcEmUuPh6V/Ya/DK+m6pz7ve
        kQFsKrOWv2rb8dmgleSzxQ==
X-Google-Smtp-Source: ABdhPJztTmAtLvK+aSkJiWcjWBiMfCXKr7NUWfYDNNlMqP/XiIh8cqEiim/xZKuMj+BxyZrpFjDSLA==
X-Received: by 2002:a92:5ec1:: with SMTP id f62mr3408821ilg.80.1590533448280;
        Tue, 26 May 2020 15:50:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k18sm477196ioj.54.2020.05.26.15.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:50:47 -0700 (PDT)
Received: (nullmailer pid 534722 invoked by uid 1000);
        Tue, 26 May 2020 22:50:46 -0000
Date:   Tue, 26 May 2020 16:50:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-input@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/5] dt-bindings: microchip: atmel, at91rm9200-tcb:
 add sama5d2 compatible
Message-ID: <20200526225046.GA534667@bogus>
References: <20200519083716.938384-1-kamel.bouhara@bootlin.com>
 <20200519083716.938384-4-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519083716.938384-4-kamel.bouhara@bootlin.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 19 May 2020 10:37:14 +0200, Kamel Bouhara wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> The sama5d2 TC block TIMER_CLOCK1 is different from the at91sam9x5 one.
> Instead of being MCK / 2, it is the TCB GCLK.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 36 +++++++++++++++----
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
