Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2A5C433B4
	for <linux-input@archiver.kernel.org>; Tue, 11 May 2021 05:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36A061927
	for <linux-input@archiver.kernel.org>; Tue, 11 May 2021 05:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEKFaq (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 11 May 2021 01:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhEKFaq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 May 2021 01:30:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24396616EA;
        Tue, 11 May 2021 05:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620710980;
        bh=8ETFwSjmDt2Y1j+GkOW9Fsflzw10+NNdF0YzCalfN2M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eHO11uYVnlwsFWdw+jd1OuHjTY/Cy8ovEf32Z9e5fCtEWNOCTuMwPegXjA4/0+TuR
         GgaOlIEKAOaymZ8/jaGDJG+TOJNx9+w5YMp0tuXZltgNDmMIslQwERqkDj1vYrTPgm
         DHXnkbjU7O6aeeTYEc36sZWQuShZ9y90CDQx6dxgHHTPyLCynuO5MMiaHfVTp8SAGY
         UCHerWaHHQy/6LwLfYhHLJN6jlEPM4EBS534USL4AP/MJvZy0PBGQ0TdxSjYjcX0bq
         ZZ0pVbbD8w4Xbr9gtZhs/mmpL0dZ9EfgKn3TB8Dn48R3Fl7S056Y7bwwQnrvXGAOBD
         pJ29ACdd5vXEA==
Subject: Re: [PATCH] dt-bindings: More removals of type references on common
 properties
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Alex Elder <elder@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-clk@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org
References: <20210510204524.617390-1-robh@kernel.org>
From:   Georgi Djakov <djakov@kernel.org>
Message-ID: <be0c7cef-ed94-1178-8b06-ac57175fc638@kernel.org>
Date:   Tue, 11 May 2021 08:29:36 +0300
MIME-Version: 1.0
In-Reply-To: <20210510204524.617390-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On 5/10/21 23:45, Rob Herring wrote:
> Users of common properties shouldn't have a type definition as the
> common schemas already have one. A few new ones slipped in and
> *-names was missed in the last clean-up pass. Drop all the unnecessary
> type references in the tree.
> 
> A meta-schema update to catch these is pending.

Acked-by: Georgi Djakov <djakov@kernel.org>
