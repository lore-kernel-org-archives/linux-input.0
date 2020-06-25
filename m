Return-Path: <SRS0=o5X5=AG=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE08C433E0
	for <linux-input@archiver.kernel.org>; Thu, 25 Jun 2020 13:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D1D20823
	for <linux-input@archiver.kernel.org>; Thu, 25 Jun 2020 13:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lXRq50wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405188AbgFYNqZ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404937AbgFYNqY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Jun 2020 09:46:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C3EC08C5C1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2020 06:46:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so5911072wrw.5
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2020 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YSDkyeiSDPLPSRAXrfvq4hAW6FiEkGgtYpOfXK2AXGA=;
        b=lXRq50woUMyAOo+aBe/Y+d4mKY0BVZx4Vh4nKd7h9ENUtC7ULyMbIvzGfXwmSVqAzA
         vRzhl8S6bPXsfCl8oh6GmZ8c7JuGMCDLSegnevL70hOezgJai+knT/0cmNeAJpW5keef
         PZljUUp/zfFUfQi2U8npVjRJUosqFaqVUoWiHARx297f6Cbu/52xnnw4hwXk+rqxFFGI
         VP/oD6um0vZZyy3YLQVbTOG1HYNmrs5fDZSjrrfD2rEflKKh1ue5hemcFJOG095yusiw
         ealSwjBzSWxG00ntStbFMDDU3aKfbZ6IL8KGQnminkmhlvhG1kT9n+V6kCM/thU3z3Hv
         rTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YSDkyeiSDPLPSRAXrfvq4hAW6FiEkGgtYpOfXK2AXGA=;
        b=LKMcmO/ulQjg7WNEDvSqgOU2XJP0RFfk+y+HEZ4hvw5TMBR8fU0lnKbbUObmy61Q8O
         TVihHK0z92TbEMF13CiClkgaaBV3vJR37O6b5giu/SnJHHHbXkZWefsqLoptjrCTq4AM
         XjuYB9D71A1RZaXIURz6GRg6nKXOxBCFRpw23EyvFBq4SicJ2/gdxGvWuH/umK8JB5kh
         yEuYfYMUT6twsMKX6ePKNotFiKEyjQU/L6Pms5feuw6oohOhw7XZHZC5YfRGgLEFZNeH
         DsbKRT5PmzGYa7OUlwaBBpeAcUB04tXNRZGoIK9rmG2G/UEwL1gB8HJi1JPH2c8e2uGZ
         WR9Q==
X-Gm-Message-State: AOAM533TGBAMsyfI+EaPGl+2Etn4kZ00cQJPEw+nc/alsyUNVQr60NtH
        4CKGFf96QOJOP8sVSowW3z7WCw==
X-Google-Smtp-Source: ABdhPJxV1aPJE7TkDoKw11SuB6u5jTx8/+gh7CQnd2DMnvzldy5dviAH/ORaQptndhcG/wuagh6rbw==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr39739354wrs.229.1593092782457;
        Thu, 25 Jun 2020 06:46:22 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id d10sm9155362wrx.66.2020.06.25.06.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 06:46:21 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:46:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Ikjoon Jang <ikjn@chromium.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nicolas Boitchat <drinkcat@chromium.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v7] dt-bindings: mfd: Convert ChromeOS EC bindings to
 json-schema
Message-ID: <20200625134620.GS954398@dell>
References: <20200306085513.76024-1-ikjn@chromium.org>
 <20200417101333.GA3737@dell>
 <ab5adcd1-18f2-9b1c-8c5d-744f7a0e5579@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab5adcd1-18f2-9b1c-8c5d-744f7a0e5579@collabora.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, 25 Jun 2020, Enric Balletbo i Serra wrote:

> Hi Lee,
> 
> On 17/4/20 12:13, Lee Jones wrote:
> > On Fri, 06 Mar 2020, Ikjoon Jang wrote:
> > 
> >> Convert the ChromeOS EC bindings to json-schema.
> >>
> >> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> >> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>  .../devicetree/bindings/mfd/cros-ec.txt       |  76 -----------
> >>  .../bindings/mfd/google,cros-ec.yaml          | 129 ++++++++++++++++++
> >>  2 files changed, 129 insertions(+), 76 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/mfd/cros-ec.txt
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > 
> > Applied, thanks.
> 
> I don't see this patch applied, I am missing something?

It should be there.  Not sure when the MFD repo was last pushed.

I'll try pushing it again (there are a couple of new patches from
today).  Maybe that will spur a fetch from -next.  If it's still not
there tomorrow, let me know and I'll investigate further.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
