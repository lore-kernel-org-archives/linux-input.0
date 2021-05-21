Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733BFC47076
	for <linux-input@archiver.kernel.org>; Fri, 21 May 2021 16:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B725613E3
	for <linux-input@archiver.kernel.org>; Fri, 21 May 2021 16:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhEUQaw (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 21 May 2021 12:30:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3471 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhEUQaw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 May 2021 12:30:52 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FmsSF2sD1zCvW0;
        Sat, 22 May 2021 00:26:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 00:29:25 +0800
Received: from localhost (10.52.125.126) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 21 May
 2021 17:29:23 +0100
Date:   Fri, 21 May 2021 17:27:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <kernel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        David Jander <david@protonic.nl>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 4/8] dt-bindings: touchscreen: validate nodename
Message-ID: <20210521172736.00004061@Huawei.com>
In-Reply-To: <20210521044525.7397-5-o.rempel@pengutronix.de>
References: <20210521044525.7397-1-o.rempel@pengutronix.de>
        <20210521044525.7397-5-o.rempel@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.126]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, 21 May 2021 06:45:21 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Validate touchscreen nodes. Make sure it is named touchscreen*.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Feels like this should be two separate patch sets...
The node name one, and then the stuff for the resistive touch screen. 

> ---
>  .../devicetree/bindings/input/touchscreen/touchscreen.yaml     | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> index 046ace461cc9..057e1063759c 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> @@ -10,6 +10,9 @@ maintainers:
>    - Dmitry Torokhov <dmitry.torokhov@gmail.com>
>  
>  properties:
> +  $nodename:
> +    pattern: "^touchscreen(@.*)?$"
> +
>    touchscreen-min-x:
>      description: minimum x coordinate reported
>      $ref: /schemas/types.yaml#/definitions/uint32

