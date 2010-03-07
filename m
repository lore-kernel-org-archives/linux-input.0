From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] Input: Add tsc2046 touchscreen driver
Date: Sun, 7 Mar 2010 09:54:21 -0800
Message-ID: <6cb013311003070954x36ae650fk40fcb4e21184166@mail.gmail.com>
References: <1260736754-374-1-git-send-email-darkstar6262@gmail.com>
	<6cb013311001101507s42f21679l87ccbea6fd06d8b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61871 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521Ab0CGRyl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Mar 2010 12:54:41 -0500
Received: by pvb32 with SMTP id 32so1218680pvb.19
        for <linux-input@vger.kernel.org>; Sun, 07 Mar 2010 09:54:41 -0800 (PST)
In-Reply-To: <6cb013311001101507s42f21679l87ccbea6fd06d8b8@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, spi-devel-general@lists.sourceforge.net, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Cory Maccarrone <darkstar6262@gmail.com>

On Sun, Jan 10, 2010 at 3:07 PM, Cory Maccarrone <darkstar6262@gmail.co=
m> wrote:
> On Sun, Dec 13, 2009 at 12:39 PM, Cory Maccarrone
> <darkstar6262@gmail.com> wrote:
>> This change implements a new driver for the TSC2046-series
>> touchscreen found on many HTC OMAP850-based smartphones.
>> This driver differs from the ADS7846 in that it uses 16-bit
>> commands instead of 8-bit, and does not include temerature
>> or voltage sensing capabilities.
>>
>> This driver was submitted in May of 2007 to the linux-omap
>> list at:
>>
>> http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/0097=
45.html
>>
>> This is a resubmit of this driver, with additions that allows
>> the injection of pointercal parameters from tslib through
>> /sys. =C2=A0This was done for the Wing Linux project primarily to
>> allow this touchscreen to work with Android, but it's useful for
>> any userspace that doesn't support tslib calibration. =C2=A0Pointerc=
al
>> use is optional -- it produces raw parameters unless the use_pointer=
cal
>> /sys file is set to 1.
>>
>> Though this driver was previously submitted to linux-omap, there
>> is nothing omap-specific in this driver.
>>
>> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>
> I haven't heard anything on this yet, so I want to give a gentle poke=
=2E
> =C2=A0Any chance of this making it in for .33, or has this patch alre=
ady
> missed that window?
>
> Thanks
> Cory
>

I've still heard nothing on this for several months.  Can someone
please take a look at it and provide feedback?  Can this patch be
included soon?

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
