From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Input: ADP5588 - Support GPI event for ADP5588 devices
Date: Thu, 10 Jun 2010 12:28:03 -0700
Message-ID: <201006101228.03993.dmitry.torokhov@gmail.com>
References: <AANLkTinaguxmGVrx3lWqNT__xE6S2CIjoLc69TrS-yyN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64946 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab0FODPm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jun 2010 23:15:42 -0400
Received: by pwi1 with SMTP id 1so3151703pwi.19
        for <linux-input@vger.kernel.org>; Mon, 14 Jun 2010 20:15:42 -0700 (PDT)
In-Reply-To: <AANLkTinaguxmGVrx3lWqNT__xE6S2CIjoLc69TrS-yyN@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiaolong CHEN <a21785@motorola.com>
Cc: linux-input@vger.kernel.org, Michael Hennerich <hennerich@blackfin.uclinux.org>, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>

Hi Xiaolong,

On Wednesday, June 09, 2010 07:36:14 pm Xiaolong CHEN wrote:
> Hi,
> 
> This patch supports GPI event for ADP5588 devices.
> 
> Kernel Version: 2.6.34
> 
> A column or row configured as a GPI can be programmed to be part of
> the key event table and therefore also capable of generating a key
> event interrupt. A key event interrupt caused by a GPI follows the
> same process flow as a key event interrupt caused by a key press. GPIs
> configured as part of the key event table allow single key switches
> and other GPI interrupts to bemonitored. As part of the event table,
> GPIs are represented by the decimal value 97 (0x61or 1100001) through
> the decimal value 114 (0x72 or 1110010). See Table as below for GPI
> event number assignments for rows and columns.
> 
> GPI Event Number Assignments for Rows
> Row0 Row1 Row2 Row3 Row4 Row5 Row6 Row7
> 97       98       99       100     101     102     103    104
> 
> GPI Event Number Assignments for Cols
> Col0 Col1 Col2 Col3 Col4 Col5 Col6 Col7 Col8 Col9
> 105  106   107   108   109   110   111   112  113  114
> 
> Usage:
> 1. Enable CONFIG_KEYBOARD_ADP5588_GPI_EVENT
> 2. Add gpimap and gpimapsize setting in adp5588_kpad_platform_data
> (The settings should not conflict with rows/cols for keymap)

A couple of questions:

1. Why did you go with a compile option? Is it possible to enable this
   functionality unconditionally and let board setup code specify what
   it wants to use?

2. Why did you decide to make the events switches and not keys?

Thanks.

-- 
Dmitry
