From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add device tree binding for WM8753
Date: Wed, 10 Aug 2011 07:30:25 +0100
Message-ID: <20110810063025.GA31765@opensource.wolfsonmicro.com>
References: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com> <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com> <20110809065100.GB8017@core.coreip.homeip.net> <20110809142851.GA15861@opensource.wolfsonmicro.com> <CAGsJ_4w-YhWQTFovkynKVVr6JkwcHJQn-EmfxUxOSd=C2BwhiA@mail.gmail.com> <20110810045113.GA23625@opensource.wolfsonmicro.com> <CAGsJ_4ykb65aD_a-04NuE-DRoERmB+WKLvaS8+5VYpE6pgOh5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44664 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751121Ab1HJGa1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2011 02:30:27 -0400
Content-Disposition: inline
In-Reply-To: <CAGsJ_4ykb65aD_a-04NuE-DRoERmB+WKLvaS8+5VYpE6pgOh5w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

On Wed, Aug 10, 2011 at 01:57:11PM +0800, Barry Song wrote:
> 2011/8/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> >> =A0struct ads7846_platform_data {
> >> =A0 =A0 =A0 =A0 u16 =A0 =A0 model; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* 7843, 7845, 7846, 7873. */
> >> =A0 =A0 =A0 =A0 u16 =A0 =A0 vref_mv; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
/* external vref value, milliVolts
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0* ads7846: if 0, use internal vref */

> > There's some callbacks but the bulk of the structure (including the=
 bits
> > I quoted above for example) looks like it's pure data and could sen=
sibly
> > be represented in the device tree.

> there have been many discussions about what should be in dts.
> basically, hardware information should be in dts, but data required b=
y
> driver implementation should be not in dts.
> There are a lot of fields in the structure, not all can be a property
> as hardware information in dts. That means the driver need a lot of
> changes then.

Things like the fields quoted above seem like they're fixed hardware
properties that oguht to be in the device tree, though.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
