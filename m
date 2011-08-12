From: Barry Song <21cnbao@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add device tree binding for WM8753
Date: Fri, 12 Aug 2011 11:16:49 +0800
Message-ID: <CAGsJ_4zmY7gXyD6EDmYgRVAkmOaQVa79LuVSrK287Q=pHF6_FA@mail.gmail.com>
References: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
 <20110809065100.GB8017@core.coreip.homeip.net> <20110809142851.GA15861@opensource.wolfsonmicro.com>
 <CAGsJ_4w-YhWQTFovkynKVVr6JkwcHJQn-EmfxUxOSd=C2BwhiA@mail.gmail.com>
 <20110810045113.GA23625@opensource.wolfsonmicro.com> <CAGsJ_4ykb65aD_a-04NuE-DRoERmB+WKLvaS8+5VYpE6pgOh5w@mail.gmail.com>
 <20110810063025.GA31765@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50559 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab1HLDRL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Aug 2011 23:17:11 -0400
Received: by bke11 with SMTP id 11so1382349bke.19
        for <linux-input@vger.kernel.org>; Thu, 11 Aug 2011 20:17:09 -0700 (PDT)
In-Reply-To: <20110810063025.GA31765@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

2011/8/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Wed, Aug 10, 2011 at 01:57:11PM +0800, Barry Song wrote:
>> 2011/8/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>
>> >> =C2=A0struct ads7846_platform_data {
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 model; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 7843, 7845, 7846, 7=
873. */
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 vref_mv; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* external vref value, mi=
lliVolts
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0* ads7846: if 0, use internal vref */
>
>> > There's some callbacks but the bulk of the structure (including th=
e bits
>> > I quoted above for example) looks like it's pure data and could se=
nsibly
>> > be represented in the device tree.
>
>> there have been many discussions about what should be in dts.
>> basically, hardware information should be in dts, but data required =
by
>> driver implementation should be not in dts.
>> There are a lot of fields in the structure, not all can be a propert=
y
>> as hardware information in dts. That means the driver need a lot of
>> changes then.
>
> Things like the fields quoted above seem like they're fixed hardware
> properties that oguht to be in the device tree, though.

at least wakeup, irq_flags in the structure should be something
related with driver implementation not hardware. Suppose all others
are hardware properties, it looks terrible to list and get so many
properties in dts and drivers.
so do we have some simpler way to present a large number of properties =
in DT?
BTW, even though we make all hardware information be properties in
dts, drivers might still need some other platform_data only including
software-related stuff for implementation. And Callback is also
another big issue too.
if we can't avoid software platform data and callbacks, there will
still be some platform initilization codes in board files.
-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
