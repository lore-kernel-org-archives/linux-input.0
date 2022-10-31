Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF2FA3747
	for <linux-input@archiver.kernel.org>; Mon, 31 Oct 2022 15:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiJaPbu (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 31 Oct 2022 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiJaPbu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Oct 2022 11:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEA2EE0C;
        Mon, 31 Oct 2022 08:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCD23612CE;
        Mon, 31 Oct 2022 15:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5173EC433D6;
        Mon, 31 Oct 2022 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667230308;
        bh=BMMxQzRtp0/nturtlwUebCCckGXZgOIXStC5INUt4Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqHJPzrYFCSFFf/lpPRROOPr4SeOsbXvWbOyJmFGfnDbPDqKNexEufBFRjOlT3/9e
         Fd7Vmku4erJDalY2VikqCNHLCaYc6VYA6AXktbkZ2abZedDThhD8VBU2sAIAdG4jc+
         GplHL7IwYP/R1CUCVr78o15wVngFIsAnwdBIouWojayG4e0MLr0mJmorQZhhr8+6EI
         eNc9Y6aiNWtu9NZ1rAqf4aIlJz7dMUgGceyDNnSvzsrq4V2PE1Csp9J0s/XFskGZvC
         hmCHbvrBFjaOBRsUrejtKZOGL9rJtf9fk3kSMk5MVYXruHXuZkDJhc25ZNAH+6UIOg
         80m1XvZeBDYHw==
Date:   Mon, 31 Oct 2022 15:31:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <agross@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/11] dt-bindings: mfd: qcom-pm8xxx: document
 qcom,pm8921 as fallback of qcom,pm8018
Message-ID: <Y1/qXQxVQce246Ct@google.com>
References: <20220928-mdm9615-dt-schema-fixes-v4-0-dac2dfaac703@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v4-5-dac2dfaac703@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v4-5-dac2dfaac703@linaro.org>
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 21 Oct 2022, Neil Armstrong wrote:

> The PM8018 is used as compatible with PM8921 on the MDM9615, document this situation,
> and an example section to validate this change.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       | 33 ++++++++++++++++++----
>  1 file changed, 28 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
