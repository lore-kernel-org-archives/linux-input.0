Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8AFEB64DA
	for <linux-input@archiver.kernel.org>; Wed, 12 Jul 2023 18:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGLSxv (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 12 Jul 2023 14:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLSxu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Jul 2023 14:53:50 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208811993;
        Wed, 12 Jul 2023 11:53:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51452556acdso5092881a12.2;
        Wed, 12 Jul 2023 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689188027; x=1691780027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LLqzrNbP1vGUJ3OFTl9cGZWimtLx1fVpXRCMSqCEbU4=;
        b=XA3Vl02j1f2uF3B1CdoVQFPL4RysVR28DRd+2vH7sNUPUxLbMXAeJZITMlSMUT7SxB
         3bPK2zPxQqSSuiH45o2fRp4L8v/8fwS8TiZs2WOwg2C2dH3Va8iBoxsEsrhm+5QlBetZ
         Nh0LoETIXcy/FDyovB3cJUK4NMILYflp4j7/7he5QwY+l3RcdPYxnq8vnG2n7XyDbeMv
         6wHHLDeDfZalZRBBmVivhLeWf5oYhRUIRKD/BD8Zm3SO7+dwwzFFmKvZO8A7JzeDciN0
         JSyFICkrZuyIGhpVH01BqprI/2qzYEzneOLCPyw5rgxqX3mL2NmAFDWOi5jE9PdkQVjV
         jybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689188027; x=1691780027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLqzrNbP1vGUJ3OFTl9cGZWimtLx1fVpXRCMSqCEbU4=;
        b=KZrPugSbiLiwBOz6oHtgMJYu/Pmr74/B7UM7pVeC9Al97yMVZEymUWMHRF+P5AG8Wp
         jk1AcWMMNke4S077SpfUC4Kn2Z5nQvsmLyN+Mzx+czXUXa+Dxg2CUhu13lGRJHxcZANL
         vRqW9vC39yzk4SzOR2OSA75K0OcjVjAovC1MNXm2yVm9CQ2VZde54Ww81TiklUMoz5gH
         xfePKvQnV1Ik4mxhxE5PW4Csc9OlmVeHYy7vn9pjisCUBipo5mH00Wcq1cdN/dE8qLcI
         zYI9jltBO9f7AhBY3nAAy3xNTMhul4BM2rcbwHo7/Wv2YkJYANongXWrkf8ERoDVqQud
         oYuQ==
X-Gm-Message-State: ABy/qLYcevDi5qhYe+qEln0KpvaLuY+WPOmDNrmK+K4z8Fzb5TtcGNHt
        CtFF4tJxAv3ZyJmzvx4jFY0=
X-Google-Smtp-Source: APBJJlGIkjpzhylvj82gBarRk2ZFBgxt8s1WVJGnekOFZMFvTh1pJi8sPb1j+dLb3cb6kYfOD8SF1Q==
X-Received: by 2002:a17:90b:3b41:b0:263:43c6:69ac with SMTP id ot1-20020a17090b3b4100b0026343c669acmr14503536pjb.44.1689188027373;
        Wed, 12 Jul 2023 11:53:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a606:1b1e:7f66:3ee0])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a191e00b002640b7073cfsm11079277pjg.14.2023.07.12.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 11:53:46 -0700 (PDT)
Date:   Wed, 12 Jul 2023 11:53:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2] Input: bcm-keypad - Correct dev_err_probe() error
Message-ID: <ZK72t3wtm8BhYCL0@google.com>
References: <20230711072449.43569-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711072449.43569-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, Jul 11, 2023 at 09:24:49AM +0200, Krzysztof Kozlowski wrote:
> Pass proper PTR_ERR as dev_err_probe() argument.
> 
> Fixes: a2c795b696b2 ("Input: bcm-keypad - simplify with dev_err_probe()")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202306261505.wTjCXRIO-lkp@intel.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thank you.

-- 
Dmitry
