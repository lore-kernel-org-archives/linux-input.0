Return-Path: <SRS0=Nro0=AU=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EEEC433E1
	for <linux-input@archiver.kernel.org>; Thu,  9 Jul 2020 23:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A813D2078B
	for <linux-input@archiver.kernel.org>; Thu,  9 Jul 2020 23:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594337303;
	bh=ZG1IR8h343r637XLpElRmUXOb3m9bEeKMsZw1WrRRAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nkK2lpkmndTqnVFKR84mchGQeDZlGn3kRwXlKvFPkUHsFVZvYT/9y2qJ0ybd499MW
	 AawISveEaTBxcheFJ0j5RBw95+HsuJCdOA2Pymb5bI/R70saecMVIrelq/celq4Q84
	 eXAqiJO/l08vk1d8KJKMSzv3XyBck1hHvDm/bkiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGIX2X (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:28:23 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33781 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgGIX2W (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2020 19:28:22 -0400
Received: by mail-il1-f193.google.com with SMTP id a11so3551575ilk.0;
        Thu, 09 Jul 2020 16:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8QazFqeXwbShp0j5TTZd1VLt3359jpHp7BwKMxU7ND8=;
        b=mf97oQzQRrL4UO1hkrFXdMGilPs/gCbErH8Rc3hLjKmNXFzUGSCzmG8vq8LopDDtdR
         NaT0JoKPm3Svhqo1iYoOGHGxwMlN5xIoOYQv9M06IlaA5otjUUl38O3gTi+ZLEdvuAm+
         1cU7c/3slGSuT6xkZrApJgkM9HG0/ck190pWNm5OG9aDEjRKwHhNoiVynJdMlHyxP77X
         hUFenmTTPnS/ZR4brQzkEWUJChRsMUh9glUnuQ4K6AmaxnB3BjRvg/NhoerKkILCIRp/
         OujFuhjVpKIVFzzDyoExSw1GTMBQQvfGuQbfa33yWC0zz1MoB5H08TWnn/M6B9Q3wNcQ
         YDag==
X-Gm-Message-State: AOAM5329kTWTSX8yQELWuMqiuL5k2W+pRhnUb/MJEb5Mf7Lz6YhScIln
        tKQWnznqOJgf6sjH1KeR7g==
X-Google-Smtp-Source: ABdhPJzh3iZ42tiy8ywy8Oqq2K2eN14C80a7M72XEsQsuosEbl96zyTI1FYOAHwErnw1HlNafxIDYw==
X-Received: by 2002:a92:5857:: with SMTP id m84mr48739669ilb.144.1594337302121;
        Thu, 09 Jul 2020 16:28:22 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id y8sm2549291ilq.21.2020.07.09.16.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:28:21 -0700 (PDT)
Received: (nullmailer pid 1098629 invoked by uid 1000);
        Thu, 09 Jul 2020 23:28:20 -0000
Date:   Thu, 9 Jul 2020 17:28:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     dmitry.torokhov@gmail.com, kernel@pengutronix.de, olof@lixom.net,
        linux-input@vger.kernel.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gnuiyl@gmail.com, robh+dt@kernel.org, festevam@gmail.com,
        Linux-imx@nxp.com, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Convert matrix-keymap to
 json-schema
Message-ID: <20200709232820.GA1098551@bogus>
References: <1592285467-18371-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592285467-18371-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 16 Jun 2020 13:31:06 +0800, Anson Huang wrote:
> Convert the matrix-keymap binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch.
> ---
>  .../devicetree/bindings/input/matrix-keymap.txt    | 28 +------------
>  .../devicetree/bindings/input/matrix-keymap.yaml   | 46 ++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/matrix-keymap.yaml
> 

Applied, thanks!
