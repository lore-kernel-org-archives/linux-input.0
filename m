Return-Path: <SRS0=3AEP=62=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1195C2D0F8
	for <linux-input@archiver.kernel.org>; Tue, 12 May 2020 22:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E9F20740
	for <linux-input@archiver.kernel.org>; Tue, 12 May 2020 22:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589321732;
	bh=4LpcboMH6y2V3AbxkMV7f+NZyl6dpLNLOLJRqcq3oH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=caq0m8R6RC4UIlx6iv3pQpQUWegZtEbjmVBhtS9cuiH0yfUaZ8H5XphiTmDSa0Xt9
	 onSBpPFGjTeFsI1Ft5/Pd49U1ja4mXlvgxHWzjaUi4WXO2gxM+ybgFBzIERL9JQFBE
	 J7X/osuTtbxk1N42kfRVWprem8o8VomTv0nuNq5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbgELWP0 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 12 May 2020 18:15:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34088 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgELWPZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 May 2020 18:15:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id 72so11894445otu.1;
        Tue, 12 May 2020 15:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uVK89xhRe2dqqDXZV23LSGBYPhwnN3G4S7xp2PFGVdI=;
        b=XtTwkDrabtjrovPji6l0Lr7lNlKHOfU2fpXXge07wiM+usxTmJdiIspZV3izgkUGsp
         sYzo/dzCj4Xb5uK7T0RlZGFakmrbuS6pU/5Ko9R/6jQr1wdvDgLPs4y/00fJa57BnNGF
         rw4nMjb2Jzygo0tSlGYXb7l519kAcLEdYqzEtMB5FJXT3WU+6KEr8+ZBevdPHLBMQr6m
         NId0Ejp1MI3KkLQ34QMowgZVJoIwlnV3zaQ2qk/Hxug1v/pSpliEejoqj/aPOGnIONXB
         izO8hBKt0jM9hUUukRcqfBMSJ/mu4G0yvAY5JIfr+/h2CcL0/VmsInm/XFIsqPeJMKnR
         i7yg==
X-Gm-Message-State: AOAM5316oqF/OtKpulJAK1ES+3/jaBCQsyAnbP+RwH+WLZwk8chHJGKO
        kbT0Ka9NzVFS6YmeyY6X7Q==
X-Google-Smtp-Source: ABdhPJyfKrzJI16lw/o2fIOXkY8zYYu+QkLPs46lpYKMfjC19TZCtZS9F0AGfDdkuJj4YopFYnat8g==
X-Received: by 2002:a9d:75d0:: with SMTP id c16mr1286689otl.314.1589321724576;
        Tue, 12 May 2020 15:15:24 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a93sm3775301otc.12.2020.05.12.15.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:15:24 -0700 (PDT)
Received: (nullmailer pid 31615 invoked by uid 1000);
        Tue, 12 May 2020 22:15:23 -0000
Date:   Tue, 12 May 2020 17:15:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     knaack.h@gmx.de, tglx@linutronix.de, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
        robh+dt@kernel.org, kstewart@linuxfoundation.org,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: iio: accel: Add required regulators to
 bma180
Message-ID: <20200512221522.GA31552@bogus>
References: <20200503172206.13782-1-xc-racer2@live.ca>
 <BN6PR04MB06609033B2E0AB157A228989A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR04MB06609033B2E0AB157A228989A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun,  3 May 2020 10:22:05 -0700, Jonathan Bakker wrote:
> The bma180 and related chips should have two registers attached to
> them.  The IIO driver currently uses them, document them here as
> well.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  Documentation/devicetree/bindings/iio/accel/bma180.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
