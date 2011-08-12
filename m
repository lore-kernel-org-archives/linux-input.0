From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add device tree binding for WM8753
Date: Thu, 11 Aug 2011 20:53:08 -0700
Message-ID: <20110812035308.GA25184@core.coreip.homeip.net>
References: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
 <20110809065100.GB8017@core.coreip.homeip.net>
 <20110809142851.GA15861@opensource.wolfsonmicro.com>
 <CAGsJ_4w-YhWQTFovkynKVVr6JkwcHJQn-EmfxUxOSd=C2BwhiA@mail.gmail.com>
 <20110810045113.GA23625@opensource.wolfsonmicro.com>
 <CAGsJ_4ykb65aD_a-04NuE-DRoERmB+WKLvaS8+5VYpE6pgOh5w@mail.gmail.com>
 <20110810063025.GA31765@opensource.wolfsonmicro.com>
 <CAGsJ_4zmY7gXyD6EDmYgRVAkmOaQVa79LuVSrK287Q=pHF6_FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:41224 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab1HLDxP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Aug 2011 23:53:15 -0400
Received: by iye16 with SMTP id 16so712451iye.1
        for <linux-input@vger.kernel.org>; Thu, 11 Aug 2011 20:53:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zmY7gXyD6EDmYgRVAkmOaQVa79LuVSrK287Q=pHF6_FA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

On Fri, Aug 12, 2011 at 11:16:49AM +0800, Barry Song wrote:
> 2011/8/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Wed, Aug 10, 2011 at 01:57:11PM +0800, Barry Song wrote:
> >> 2011/8/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> >
> >> >> =A0struct ads7846_platform_data {
> >> >> =A0 =A0 =A0 =A0 u16 =A0 =A0 model; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/* 7843, 7845, 7846, 7873. */
> >> >> =A0 =A0 =A0 =A0 u16 =A0 =A0 vref_mv; =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* external vref value, milliVolts
> >> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0* ads7846: if 0, use internal vref */
> >
> >> > There's some callbacks but the bulk of the structure (including =
the bits
> >> > I quoted above for example) looks like it's pure data and could =
sensibly
> >> > be represented in the device tree.
> >
> >> there have been many discussions about what should be in dts.
> >> basically, hardware information should be in dts, but data require=
d by
> >> driver implementation should be not in dts.
> >> There are a lot of fields in the structure, not all can be a prope=
rty
> >> as hardware information in dts. That means the driver need a lot o=
f
> >> changes then.
> >
> > Things like the fields quoted above seem like they're fixed hardwar=
e
> > properties that oguht to be in the device tree, though.
>=20
> at least wakeup, irq_flags in the structure should be something
> related with driver implementation not hardware. Suppose all others
> are hardware properties, it looks terrible to list and get so many
> properties in dts and drivers.
> so do we have some simpler way to present a large number of propertie=
s in DT?
> BTW, even though we make all hardware information be properties in
> dts, drivers might still need some other platform_data only including
> software-related stuff for implementation. And Callback is also
> another big issue too.
> if we can't avoid software platform data and callbacks, there will
> still be some platform initilization codes in board files.

Maybe should not add DT bindings for devices that can't be adequately
expressed via DT properties [yet]? Because I do not see what benefits w=
e
get since platform code still needs to provide missing data and now we'=
d
have issue of data not being there when device is registered and driver
is being bound to it.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
