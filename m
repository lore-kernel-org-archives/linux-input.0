Return-Path: <SRS0=BDWM=BQ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2675C433E0
	for <linux-input@archiver.kernel.org>; Thu,  6 Aug 2020 22:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D61221E3
	for <linux-input@archiver.kernel.org>; Thu,  6 Aug 2020 22:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pid4EmHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHFWgZ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHFWgY (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2020 18:36:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656D6C061574;
        Thu,  6 Aug 2020 15:36:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e4so7610437pjd.0;
        Thu, 06 Aug 2020 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w4IfUAcAutpmT5dJoKcHzIX9fVgapPrm5OqXG0bL93U=;
        b=pid4EmHRv7skHhgScFGDMWe8FlLY2ii3rHjKbprTDDLFyEsWJnNniN3NXcpr2AY+Oc
         j4DmgJ827ZGithgtR5WnXbExi4g4tLA73d6DLBsBj9QqW38Ftg6Er76EKWUCde7nycHi
         KHJfI/Xf+e4Q0O/9sl5B2mh32Pr6cpByk0R6DkfQ8eGZfrFkeUcyb75UJ6K9s7nf222+
         uKKTDqieR8MCnZg9cZse3WvCKFeU7otcmyIOZssOmrcKWyTgzlK9X1lQO9psbT1mBvyG
         VPGuXEd6hNDm025/C8eA8K2TXt7ocux0JKkUswfbrtWgCDsZlMLe6PYiMpzpjlR+v5rb
         50Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w4IfUAcAutpmT5dJoKcHzIX9fVgapPrm5OqXG0bL93U=;
        b=orCIc9dcJlli/XftBXWeRvE0JGWn/J5Y0rKWpecWxxKN/PmCKlPcp9/s8XeWrWd6YJ
         OU62rRpZIfUhIppqJuy8YUin0fG5f3eIIpkqrxZaDTQmyp/ejrNQL13uEWLNk7LehybY
         0GR+eojF0xsb5I7s2tZ7iXgs0EpyWVcrd2a00aoYq6cL031J2h1QBOH9+kO1IqrTdBLp
         bpGQFUUqkAq16myliFv98o0Ns517BFvl34rTETCIgB+sJx4xqk3h12CJruvbKRxfu8S8
         tR9IjtX7BXQlydnscl5COjCM+2T7w3bxpuGQg9R0Mp7l0hjmtBKqgTEFNvX4fV2Co8Vj
         VRrg==
X-Gm-Message-State: AOAM5311KKosje5kg97GSZfH6nkGOT55qGG2+Dl10MdcZtmmII+3NwjV
        TajzjLXgCqj4jdodt7M21Jo=
X-Google-Smtp-Source: ABdhPJwBC8Tn08nTgvrXN3WCkQ1zuXEB5jVrCV24g02LDUW21mitaI+mTyZ0yFPpj4BrowQMhYWIoQ==
X-Received: by 2002:a17:90b:1106:: with SMTP id gi6mr11068384pjb.2.1596753383816;
        Thu, 06 Aug 2020 15:36:23 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id e3sm8515463pgu.40.2020.08.06.15.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 15:36:23 -0700 (PDT)
Date:   Thu, 6 Aug 2020 15:36:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Tai-hwa Liang <avatar@sentelic.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] input: sentelic: fix error return when fsp_reg_write
 fails
Message-ID: <20200806223621.GM1665100@dtor-ws>
References: <20200603141218.131663-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603141218.131663-1-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Jun 03, 2020 at 03:12:18PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the call to fsp_reg_write fails -EIO is not being returned
> because the count is being returned instead of the return value in retval.
> Fix this by returning the value in retval instead of count.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: fc69f4a6af49 ("Input: add new driver for Sentelic Finger Sensing Pad")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

-- 
Dmitry
