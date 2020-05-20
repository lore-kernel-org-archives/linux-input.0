Return-Path: <SRS0=5/zS=7C=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E03BC433E0
	for <linux-input@archiver.kernel.org>; Wed, 20 May 2020 18:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69B342072C
	for <linux-input@archiver.kernel.org>; Wed, 20 May 2020 18:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgETSmG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 20 May 2020 14:42:06 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43262 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbgETSmG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 May 2020 14:42:06 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jbTfE-00040R-0g; Wed, 20 May 2020 20:42:00 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Johan Jonker <jbx6244@gmail.com>, robh+dt@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: touchscreen: edt-ft5x06: change reg property
Date:   Wed, 20 May 2020 20:41:59 +0200
Message-ID: <4727344.YYj2SkWT1V@diego>
In-Reply-To: <20200520171324.GS89269@dtor-ws>
References: <20200520073327.6016-1-jbx6244@gmail.com> <20200520171324.GS89269@dtor-ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Dmitry,

Am Mittwoch, 20. Mai 2020, 19:13:24 CEST schrieb Dmitry Torokhov:
> Hi Johan,
> 
> On Wed, May 20, 2020 at 09:33:27AM +0200, Johan Jonker wrote:
> > A test with the command below gives this error:
> > 
> > arch/arm/boot/dts/rk3188-bqedison2qc.dt.yaml:
> > touchscreen@3e: reg:0:0: 56 was expected
> > 
> > The touchscreen chip on 'rk3188-bqedison2qc' and other BQ models
> > was shipped with different addresses then the binding currently allows.
> > Change the reg property that any address will pass.
> > 
> > make ARCH=arm dtbs_check
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/input/touchscreen/
> > edt-ft5x06.yaml
> > 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> > index 383d64a91..baa8e8f7e 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> > @@ -42,7 +42,7 @@ properties:
> >        - focaltech,ft6236
> >  
> >    reg:
> > -    const: 0x38
> > +    maxItems: 1
> 
> Should we have a list of valid addresses instead of allowing any
> address? Controllers usually have only a couple of addresses that they
> support.

from what I've read, the fdt touchscreen controllers are just a generic
cpu with device-specific (or better panel-specific) firmware, which seems
to include the address as well - so it looks to be variable.

But of course that is only 2nd hand knowledge for me ;-)


But also, the i2c address is something you cannot really mess up,
either it is correct and your touchscreen works, or it isn't and and
adding entries to this list every time a new address variant pops up
feels clumsy.


Heiko


