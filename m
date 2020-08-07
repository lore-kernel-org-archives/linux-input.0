Return-Path: <SRS0=egkw=BR=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A68C433DF
	for <linux-input@archiver.kernel.org>; Fri,  7 Aug 2020 00:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84AD206B5
	for <linux-input@archiver.kernel.org>; Fri,  7 Aug 2020 00:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7tu28UU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgHGAg4 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHGAgz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2020 20:36:55 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B603C061574;
        Thu,  6 Aug 2020 17:36:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t11so239292plr.5;
        Thu, 06 Aug 2020 17:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=alp2G6ff2wO0MqehzwXx5LsJyIv92ql/KYHKrtPRdXk=;
        b=R7tu28UUZocD5B4bGEXu8f51JjvdG9rwUbAWKIvlyHu9NgqGfrO91/lntX9/+hUqSB
         biLhqBSiKJvjHvzvZ6CxrFTWQqF2A7dix2JS8n7gvxqUMGcUv9McdAbyw+NCmCVACuVX
         mCfV8uCGN669iCxOzr7H5MwW/Rdfu22l6TOD+J9XJ1O7VR5uqM0Ct+YJhFd/MPpsDYVj
         Nx8k4ANU9uG35xiIQ3VKrxghxxlBM8IO8pykI1/5qzhZ23oQhyBuh9j77o2cOv4be2Ma
         EGXjPHWiZVCd46KODTmFOQWR2LnqfM4v9duGa07ZvSMGW1wGLjIWFR5NM7R8O9xPn/EK
         aqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=alp2G6ff2wO0MqehzwXx5LsJyIv92ql/KYHKrtPRdXk=;
        b=W2j8YeeWhT1FPSaXsA1UPJEtIEm6RtOfWBgdXreZxaLiU8hEPVG48bdYVlaucTXzdl
         qfJxfrP5ycdxy8HYAVfNwctabdsdRnb/3LiiDvTO57EviNLAp1iwoMFOsLixqififZsT
         +3dS8C3qZK0dYsfbKe6JM+ajxR5aeX87R3DqQig5edSKImV7ZiKPkuviFSmFz7DPwcGH
         VKQkl5wmAM4Ekn/wok8MiFq7bJVe2+DP9wJGEL84ycXR4gcHpL23mCetfv7zfvnJFa6D
         /ZZTfDyhonjQuL6T7N1GbCxPyOCt7CcygKKr9qVsOJ6vnndxdyq3twZaQhZhnZAmPuP3
         NhIw==
X-Gm-Message-State: AOAM53227PcoKALUcVVMpsy8R8E0mnGiOJ3GeE/sbtiMxfPVNJPItk3U
        RtthTX2s1HTWV4N3Qkbyxz4=
X-Google-Smtp-Source: ABdhPJwZxaOw2BWIKVtszCmcgQdOVYNHdsj8BrhT2AFof7Nqjf0CRnw2g3YdVIq2o2P6WYjAnH6LrA==
X-Received: by 2002:a17:90b:4c0c:: with SMTP id na12mr6593998pjb.24.1596760614704;
        Thu, 06 Aug 2020 17:36:54 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id m62sm9036352pje.18.2020.08.06.17.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 17:36:54 -0700 (PDT)
Date:   Thu, 6 Aug 2020 17:36:52 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Ahmet Inan <inan@distec.de>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv4 1/4] dt-bindings: touchscreen: Convert EETI EXC3000
 touchscreen to json-schema
Message-ID: <20200807003652.GN1665100@dtor-ws>
References: <20200805160520.456570-1-sebastian.reichel@collabora.com>
 <20200805160520.456570-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805160520.456570-2-sebastian.reichel@collabora.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Aug 05, 2020 at 06:05:17PM +0200, Sebastian Reichel wrote:
> Convert the EETI EXC3000 binding to DT schema format using json-schema
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied, thank you.

-- 
Dmitry
