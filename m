From: Barry Song <21cnbao@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add device tree binding for WM8753
Date: Wed, 10 Aug 2011 13:57:11 +0800
Message-ID: <CAGsJ_4ykb65aD_a-04NuE-DRoERmB+WKLvaS8+5VYpE6pgOh5w@mail.gmail.com>
References: <1312778255-29755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAGsJ_4y2tDb3ZBPo8bCtrjFt0OWzR8WeG+kL_RKJPRP7-pZopw@mail.gmail.com>
 <20110809065100.GB8017@core.coreip.homeip.net> <20110809142851.GA15861@opensource.wolfsonmicro.com>
 <CAGsJ_4w-YhWQTFovkynKVVr6JkwcHJQn-EmfxUxOSd=C2BwhiA@mail.gmail.com> <20110810045113.GA23625@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39916 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab1HJF5c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2011 01:57:32 -0400
Received: by bke11 with SMTP id 11so160299bke.19
        for <linux-input@vger.kernel.org>; Tue, 09 Aug 2011 22:57:31 -0700 (PDT)
In-Reply-To: <20110810045113.GA23625@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org

2011/8/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Wed, Aug 10, 2011 at 09:21:16AM +0800, Barry Song wrote:
>> 2011/8/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>
>> > Oh, if that's the case the driver ought to have device tree bindin=
gs
>> > which replicate the platform data. =C2=A0Unless the platform data =
is
>> > sufficiently obscure for hardly anyone to want to use it I guess.
>
>> I guess what Dmitry said is the big ads7846_platform_data structure.
>
> Yes.
>
>> =C2=A0struct ads7846_platform_data {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 model; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 7843, 7845, 7846, 7873.=
 */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 vref_delay_usecs; =C2=A0=
 =C2=A0 =C2=A0 /* 0 for external vref; etc */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 =C2=A0 =C2=A0 vref_mv; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* external vref value, milli=
Volts
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* ads7846: if 0, use internal vref */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool =C2=A0 =C2=A0keep_vref_on; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* set to keep vref on for differential
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* measurements as well */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool =C2=A0 =C2=A0swap_xy; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* swap x and y axes */
>
> ...
>
>> The structure even has some callbacks which can't be possible in dts=
=2E
>
> There's some callbacks but the bulk of the structure (including the b=
its
> I quoted above for example) looks like it's pure data and could sensi=
bly
> be represented in the device tree.

there have been many discussions about what should be in dts.
basically, hardware information should be in dts, but data required by
driver implementation should be not in dts.
There are a lot of fields in the structure, not all can be a property
as hardware information in dts. That means the driver need a lot of
changes then.

>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
