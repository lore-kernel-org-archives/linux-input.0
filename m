From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add device tree binding for WM8753
Date: Wed, 10 Aug 2011 13:51:19 +0900
Message-ID: <20110810045113.GA23625@opensource.wolfsonmicro.com>
References: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
 <20110809065100.GB8017@core.coreip.homeip.net>
 <20110809142851.GA15861@opensource.wolfsonmicro.com>
 <CAGsJ_4w-YhWQTFovkynKVVr6JkwcHJQn-EmfxUxOSd=C2BwhiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51298 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750850Ab1HJEv3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2011 00:51:29 -0400
Content-Disposition: inline
In-Reply-To: <CAGsJ_4w-YhWQTFovkynKVVr6JkwcHJQn-EmfxUxOSd=C2BwhiA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

On Wed, Aug 10, 2011 at 09:21:16AM +0800, Barry Song wrote:
> 2011/8/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > Oh, if that's the case the driver ought to have device tree binding=
s
> > which replicate the platform data. =A0Unless the platform data is
> > sufficiently obscure for hardly anyone to want to use it I guess.

> I guess what Dmitry said is the big ads7846_platform_data structure.

Yes.

>  struct ads7846_platform_data {
>         u16     model;                  /* 7843, 7845, 7846, 7873. */
>         u16     vref_delay_usecs;       /* 0 for external vref; etc *=
/
>         u16     vref_mv;                /* external vref value, milli=
Volts
>                                          * ads7846: if 0, use interna=
l vref */
>         bool    keep_vref_on;           /* set to keep vref on for di=
fferential
>                                          * measurements as well */
>         bool    swap_xy;                /* swap x and y axes */

=2E..

> The structure even has some callbacks which can't be possible in dts.

There's some callbacks but the bulk of the structure (including the bit=
s
I quoted above for example) looks like it's pure data and could sensibl=
y
be represented in the device tree.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
