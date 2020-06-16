Return-Path: <SRS0=d/dN=75=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39973C433E0
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 10:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169DC2078E
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 10:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgFPK6k (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:58:40 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54078 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgFPK6j (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jun 2020 06:58:39 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id F365B1C0BD2; Tue, 16 Jun 2020 12:58:38 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:58:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Fengping Yu <fengping.yu@mediatek.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 1/3] dt-bindings:Add vibrator devicetree documentation
Message-ID: <20200616105831.GJ1718@bug>
References: <20200615114203.116656-1-fengping.yu@mediatek.com>
 <20200615114203.116656-2-fengping.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615114203.116656-2-fengping.yu@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon 2020-06-15 19:42:02, Fengping Yu wrote:
> From: "fengping.yu" <fengping.yu@mediatek.com>
> 
> Add Mediatek regulator vibrator dt-bindings doc as yaml schema
> 
> Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
> ---
>  .../bindings/input/regulator-vibrator.yaml    | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/regulator-vibrator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/regulator-vibrator.yaml b/Documentation/devicetree/bindings/input/regulator-vibrator.yaml
> new file mode 100644
> index 000000000000..6511a8a80aff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/regulator-vibrator.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +version: 1
> +
> +$id: http://devicetree.org/schemas/input/regulator-vibrator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek's regulator vibrator device tree bindings
> +
> +maintainer:
> +  - Fengping Yu <fengping.yu@mediatek.com>
> +
> +description: |
> +  Registers a regulator device as vibrator, where the on/off capability is controlled by a regulator.

Line length?

> +properties:
> +  compatible:
> +      const: "regulator-vibrator"
> +
> +	vibr-supply:
> +		description: Power supply to the vibrator.
> +		refs:Documentation/devicetree/bindings/regulator/regulator.txt for details.
> +
> +  max-volt:
> +    description: The maximum voltage value supplied to the vibrator regulator.
> +    						 The unit of the voltage is micro.
> +

should be -microvolt?

> +  min-volt:
> +    description: The minimum voltage value supplied to the vibrator regulator.
> +    						 The unit of the voltage is micro.
> +
> +  min-limit:
> +    description: The minimum duration time in ms for vibrator, default is 15ms.
> +    						 If user request smaller duration, the default value will be used
> +    						 instead. The default value comes from the smallest unit that can
> +    						 be sensored.

English?

Add -usec or something?

											Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
