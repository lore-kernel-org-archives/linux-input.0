From: Xiaolong CHEN <a21785@motorola.com>
Subject: Re: [RFC] Input: ADP5588 - Support GPI event for ADP5588 devices
Date: Thu, 17 Jun 2010 15:33:23 +0800
Message-ID: <AANLkTilAVOBLQBstGBtjgWVvOJVIQ_pgkcy5-A_Vwe3H@mail.gmail.com>
References: <AANLkTinaguxmGVrx3lWqNT__xE6S2CIjoLc69TrS-yyN@mail.gmail.com>
	<201006101228.03993.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:51882 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755728Ab0FQHd0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jun 2010 03:33:26 -0400
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with SMTP id o5H7Wr6t027523
	for <linux-input@vger.kernel.org>; Thu, 17 Jun 2010 01:32:53 -0600 (MDT)
Received: from mail-iw0-f182.google.com (mail-iw0-f182.google.com [209.85.214.182])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with ESMTP id o5H7WqEi027515
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-input@vger.kernel.org>; Thu, 17 Jun 2010 01:32:53 -0600 (MDT)
Received: by iwn7 with SMTP id 7so9746596iwn.27
        for <linux-input@vger.kernel.org>; Thu, 17 Jun 2010 00:33:23 -0700 (PDT)
In-Reply-To: <201006101228.03993.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Xiaolong CHEN <xiao-long.chen@motorola.com>, linux-input@vger.kernel.org, Michael Hennerich <hennerich@blackfin.uclinux.org>, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>

Hi Dmitry,

Sorry for the late, I'm on vacation these days.

1. Why did you go with a compile option?
It's easy to use on different target board, sometimes the adp5588 will
not used for switch events.

Is it possible to enable this functionality unconditionally and let
board setup code specify what it wants to use?
Yes, I think it should be ok if checking the parameter.

2. Why did you decide to make the events switches and not keys?
Do you mean why use input_report_switch in this patch? Since a target
board might need a switch (for example: slider switch, slience
switch), and it will report to the user space. Also, it's not
economical to report a key event by GPI event, one pin could report
one event, but if use one pin in key matrix, it could report
1xrow/1xcol events.

Thanks,
Xiaolong

On Fri, Jun 11, 2010 at 3:28 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Xiaolong,
>
> On Wednesday, June 09, 2010 07:36:14 pm Xiaolong CHEN wrote:
> > Hi,
> >
> > This patch supports GPI event for ADP5588 devices.
> >
> > Kernel Version: 2.6.34
> >
> > A column or row configured as a GPI can be programmed to be part of
> > the key event table and therefore also capable of generating a key
> > event interrupt. A key event interrupt caused by a GPI follows the
> > same process flow as a key event interrupt caused by a key press. G=
PIs
> > configured as part of the key event table allow single key switches
> > and other GPI interrupts to bemonitored. As part of the event table=
,
> > GPIs are represented by the decimal value 97 (0x61or 1100001) throu=
gh
> > the decimal value 114 (0x72 or 1110010). See Table as below for GPI
> > event number assignments for rows and columns.
> >
> > GPI Event Number Assignments for Rows
> > Row0 Row1 Row2 Row3 Row4 Row5 Row6 Row7
> > 97 =A0 =A0 =A0 98 =A0 =A0 =A0 99 =A0 =A0 =A0 100 =A0 =A0 101 =A0 =A0=
 102 =A0 =A0 103 =A0 =A0104
> >
> > GPI Event Number Assignments for Cols
> > Col0 Col1 Col2 Col3 Col4 Col5 Col6 Col7 Col8 Col9
> > 105 =A0106 =A0 107 =A0 108 =A0 109 =A0 110 =A0 111 =A0 112 =A0113 =A0=
114
> >
> > Usage:
> > 1. Enable CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> > 2. Add gpimap and gpimapsize setting in adp5588_kpad_platform_data
> > (The settings should not conflict with rows/cols for keymap)
>
> A couple of questions:
>
> 1. Why did you go with a compile option? Is it possible to enable thi=
s
> =A0 functionality unconditionally and let board setup code specify wh=
at
> =A0 it wants to use?
>
> 2. Why did you decide to make the events switches and not keys?
>
> Thanks.
>
> --
> Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
