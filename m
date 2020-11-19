Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB95C56201
	for <linux-input@archiver.kernel.org>; Thu, 19 Nov 2020 07:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0612246DE
	for <linux-input@archiver.kernel.org>; Thu, 19 Nov 2020 07:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf1JER74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgKSHGK (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 19 Nov 2020 02:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgKSHGK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Nov 2020 02:06:10 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEC0C0613CF;
        Wed, 18 Nov 2020 23:06:10 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id q28so3403631pgk.1;
        Wed, 18 Nov 2020 23:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ayYk+CLpbPqFDGheTWGLWJByA3PKUlBGP2wbtuMSk5g=;
        b=Gf1JER74hE92j718zjtQKRHqVHA/1x3kIk17/RAV22kRIdO747d0KNAOu1XZ7tubtj
         sbwSf+og8FnBF7EzFbMIBVFjjLgNgAFKxOqJziIqgtcsfJZRyfzhd3E7WhnuL9fQKLzX
         XWykZG5LFOWe0iM7MKlgymyKGr4c2IdCLM/YxoVHA/PNqlV1SjjlzwxOjQjlOwXajhg6
         SfETbrSvhAaISjDHWbZijM5mlCHi53k6pexHckPq+YzOCtyjTo6CI8h7nLhkC1NowMVR
         LJ6xFfvqv1/qE7jztBFjSJZ6S2qRslaMumIfLWM/YEsixBfKAAj86Q6rckFS+xP0Vwo+
         oAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ayYk+CLpbPqFDGheTWGLWJByA3PKUlBGP2wbtuMSk5g=;
        b=Ep0Ha/pCNyZY+fAnWUhvtxIijp0gdlIO3tHjeF4Kz+LWk+ChdlpjqqucFgLoK4lxoG
         V1QCxE1hzL9xyHe+YOY62KQOqaqNCrN6y3SGINt5BENeQ6JEr+P4aZUbCF24NVSvJ4bq
         5Ef1suZ23CkzW9ZVere+wEvytDMrisEFau3DkPIZM/jvzgRN4792triv3zuAf8HbLS+b
         0Gm23x7FNuNOqw2xpkl0OVdlAPsJTd5cbrfga6OKg80JMM7bU1WOrOsADHS2cRhtVFeK
         CZejOojKJm3PEVm4MtAVpLLNWhMIhDRdGx2t7jxJ7t/mO/uuftkSi99m+Fv27A3dTCcR
         I8gA==
X-Gm-Message-State: AOAM530wwp15Bjf5t1oySKOIn0PMKF3FnXD8lcBAORkxur7f+dn8MIre
        wIp39qTGNTl0tCOlar+zbSJ5gR8U4Is=
X-Google-Smtp-Source: ABdhPJw+wHRwabNGFldhWGrNpfK4GQPCNmTs/OEfzg4Y2bFxtsuNYze9g7TY9kSJlpIqBDrLGx8DBw==
X-Received: by 2002:a63:f318:: with SMTP id l24mr11659522pgh.193.1605769569645;
        Wed, 18 Nov 2020 23:06:09 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id w63sm28085063pfc.120.2020.11.18.23.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 23:06:08 -0800 (PST)
Date:   Wed, 18 Nov 2020 23:06:06 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Input: adp5589: use devm_kzalloc() to allocate
 the kpad object
Message-ID: <20201119070606.GC2034289@dtor-ws>
References: <20201112074308.71351-1-alexandru.ardelean@analog.com>
 <20201112074308.71351-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112074308.71351-2-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Thu, Nov 12, 2020 at 09:43:04AM +0200, Alexandru Ardelean wrote:
> This removes the need to manually free the kpad object and cleans up some
> exit/error paths.
> The error path cleanup should reduce the risk of any memory leaks with this
> object.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied, thank you.

-- 
Dmitry
