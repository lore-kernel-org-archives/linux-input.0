Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5367FC433EF
	for <linux-input@archiver.kernel.org>; Wed, 16 Feb 2022 03:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbiBPD57 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 15 Feb 2022 22:57:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiBPD57 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Feb 2022 22:57:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F462DFC0;
        Tue, 15 Feb 2022 19:57:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id l19so1104822pfu.2;
        Tue, 15 Feb 2022 19:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w6KOZoDlwMifKxRMHfggIjwg2UUmcgc8bE6p/Jt0JzQ=;
        b=gW9KrANRHLlN/atlXBMhoiwIpbaea6ACEYT3T6RpIHzmxHX4xM3DpfI9QyUUwN3Og/
         6nX5pEPEajLQbgNVv1z6eu6p1HS6fi0LO+mVnP+5FQRRA9L6UVKmmmOm28ONW05/YRkL
         T9PvTMt5U5uv+EFH0Cpm5qIieABWcUfoSGDarSRtzChXtxNiVXcp83GrItR7lYYizhY+
         DR6uiZEr0w/pWyxmWHYZI5kyKHu/27FpuhWHytCeE97GsqEJU7xVgEx/BGsskdiO4RvN
         +tSso77z5zihmqkLHvg/nOCQqhRNLj/FJZ7erPEQrUqwjfHrmZUivI9q9Dnde0qaUMSj
         JNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w6KOZoDlwMifKxRMHfggIjwg2UUmcgc8bE6p/Jt0JzQ=;
        b=v1Eh3p8VwA3WsRsrXSBtDFDh0EEOPm4OlNaRIS+xgZhYm/FLme5AXATAY7bcCa/47G
         0kRKD7huPthV5ZuNrjO1p4veiKDtRsAnErpRom6r44HTP2kbEBgzVVMD0Wbayy4kPR3N
         XsslzVvrNrAkygxG3gNUA2Gx3DSlIqxBIpfymNxoJvFUdFYd2q5C9GsRLR4q25VKolWl
         qURkTyS7CQdV/7h36cXJx1fo7c2cEWqOzMNfuHLwxqGw/bvKI5u8Ivv/57Te0br46wcM
         RwG8nHfxBC2geDkFFt9VeV6pJJ65WEIlVbBl9pUqIywAclaAG8Xb77vnD1g1TeCTyA8O
         gT0g==
X-Gm-Message-State: AOAM530bjsKSjvIrJRST1Zoqar58d9t3g9/he/sst7px3H5O9wdACMLd
        TO57wMyET2Lp7umVrbvEdys=
X-Google-Smtp-Source: ABdhPJwlmkOqp94/8R+lSypB5WcI5/Z4E8gWLatS+QFGxAiPykZVBS6q9OL+b7f1LOV+MN4bKeMRGg==
X-Received: by 2002:a63:451e:0:b0:373:6a1d:2ad9 with SMTP id s30-20020a63451e000000b003736a1d2ad9mr772194pga.114.1644983867739;
        Tue, 15 Feb 2022 19:57:47 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4e4a:b0ff:e926:40e2])
        by smtp.gmail.com with ESMTPSA id g5sm41730941pfv.22.2022.02.15.19.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 19:57:46 -0800 (PST)
Date:   Tue, 15 Feb 2022 19:57:44 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcos Alano <marcoshalano@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [RESEND PATCH] Correct the name for Xbox Series S|X controller
Message-ID: <Ygx2OJ1Yi4kPRWjz@google.com>
References: <20220212191014.1754721-1-marcoshalano@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212191014.1754721-1-marcoshalano@gmail.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, Feb 12, 2022 at 04:10:15PM -0300, Marcos Alano wrote:
> Change the name of controller to a more meaningful one.
> 
> Signed-off-by: Marcos Alano <marcoshalano@gmail.com>

Applied, thank you.

-- 
Dmitry
