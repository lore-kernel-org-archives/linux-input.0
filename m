Return-Path: <SRS0=Ma1V=4W=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D26C3F2D2
	for <linux-input@archiver.kernel.org>; Thu,  5 Mar 2020 16:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1419D20637
	for <linux-input@archiver.kernel.org>; Thu,  5 Mar 2020 16:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583426934;
	bh=uTJIAf0Zk1trNzHdjBfKoDR9e5pAGkCgd5UWUupWf5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iVgcXRuPp/0YBVtDy4yJ6/H4oYCBvCb7Es28DomOJkXf/6TQMvMgyEEWFFby//2HN
	 XhxQytJZImhNT1SRCEyzwD0iM+j99F4gudC0s81zuRCgdAYPU/7sWsRb4AwuvCvInI
	 DmiQOl1B/MgZfYcq2JDJ4xPA3L/YUAV9bbIA0HmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgCEQsx (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:48:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39972 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgCEQsx (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Mar 2020 11:48:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id x19so6360403otp.7;
        Thu, 05 Mar 2020 08:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BtQukosipCDTJRpxM8+GlvjNBpGQ+/37Y87CzXVM5fI=;
        b=K0Qe8v3gnX2QOrWMM4TSV9hZ9UUYU59KMCxryY+vZSympuCrbEcgh1pMPAcW1w/MM7
         AmqMtLv/lN9x6HwRyETeGc38cL7L7y+KIKLL2zk+eI5NQgX1EPReeDnrIvszAbo91ViJ
         vI8lHm0VYacKRwJ5TdOmK2S6fPyMXsVZsrRrUKIUVojYM3+fWniduP3hRgXQ8M1lmBgr
         sVU69WFYIgmDSlqle1pPj5az+ccX4lfLsyXO/zwo3cr9TIrUa8wNmoJHLeDrMwjOb/C3
         2FmK1pmoI7mDu/VsuQIXOgAePk3EIheR0GhpGaY+SIRau48gjI4GoqfkoybHqTfA0q0w
         K+gg==
X-Gm-Message-State: ANhLgQ3NWBbrm5oBi0Cq7dTRfELzF4GeNjD5Z9h6W3s2iMYMaGQwaTab
        lv3rYHB9i8qlYyN3YKZuVQ==
X-Google-Smtp-Source: ADFU+vtd3fQT1+nzrSFrLjVe44wc6SUOPiqtdKD4EpcpFIzGHq+NsraOJqFcRaWgHNQr7Z3TBxWM3A==
X-Received: by 2002:a9d:73d1:: with SMTP id m17mr7441548otk.19.1583426932494;
        Thu, 05 Mar 2020 08:48:52 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 16sm9528186otc.33.2020.03.05.08.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 08:48:51 -0800 (PST)
Received: (nullmailer pid 26752 invoked by uid 1000);
        Thu, 05 Mar 2020 16:48:50 -0000
Date:   Thu, 5 Mar 2020 10:48:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nicolas Boitchat <drinkcat@chromium.org>,
        linux-input@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: Re: [PATCH v6] dt-bindings: mfd: Convert ChromeOS EC bindings to
 json-schema
Message-ID: <20200305164850.GA21459@bogus>
References: <20200305075302.200959-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305075302.200959-1-ikjn@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu,  5 Mar 2020 15:53:02 +0800, Ikjoon Jang wrote:
> Convert the ChromeOS EC bindings to json-schema.
> 
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
> v6: adjust property dependencies, drop duplicated definitions,
>     and set additionalProperties
> v5: unset additionalProperties
> v4: text reflows, add type references, and fix examples
> v3: node name changed in rpmsg example
> v2: cleanup description, fix typos, remove LPC, and add RPMSG example
> ---
>  .../devicetree/bindings/mfd/cros-ec.txt       |  76 -----------
>  .../devicetree/bindings/mfd/cros-ec.yaml      | 125 ++++++++++++++++++
>  2 files changed, 125 insertions(+), 76 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/cros-ec.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/cros-ec.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/cros-ec.example.dt.yaml: cros-ec@0: 'spi-max-frequency' does not match any of the regexes: 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1249450
Please check and re-submit.
