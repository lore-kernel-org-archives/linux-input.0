From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input
	driverforbutton/scrollwhell/slider/touchpad
Date: Wed, 2 Sep 2009 05:48:21 -0400
Message-ID: <8bd0f97a0909020248w68fdd8dbp254071f72f9fb77f@mail.gmail.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
	<8bd0f97a0909012009k2f5bb41btca6de961c8cfa99@mail.gmail.com>
	<0F1B54C89D5F954D8535DB252AF412FA04A5CB70@chinexm1.ad.analog.com>
	<200909020550.01729.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f181.google.com ([209.85.210.181]:45450 "EHLO
	mail-yx0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbZIBJsj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Sep 2009 05:48:39 -0400
Received: by yxe11 with SMTP id 11so2352045yxe.4
        for <linux-input@vger.kernel.org>; Wed, 02 Sep 2009 02:48:41 -0700 (PDT)
In-Reply-To: <200909020550.01729.rgetz@blackfin.uclinux.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, "Song, Barry" <Barry.Song@analog.com>, dbrownell@users.sourceforge.net, dtor@mail.ru, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, spi-devel-general@lists.sourceforge.net

On Wed, Sep 2, 2009 at 05:50, Robin Getz wrote:
> On Tue 1 Sep 2009 23:17, Song, Barry pondered:
>> No. I can't agree other coding style issues you said. I will keep my
>> original codes for these issues except adding a BUS_SPI.
>
> style is different than performance....
>
> Did you think about Mike's comment - I think it was a performance issue he was
> talking about.

if we do go the proper approach and handle spi/i2c dynamically as
suggested, then this is a moot point as we'll want to keep the
function pointers
-mike
