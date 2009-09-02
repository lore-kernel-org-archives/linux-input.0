From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH 1/2] add ad714x platform_datadefinition
Date: Wed, 2 Sep 2009 10:09:13 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04A5CA02@chinexm1.ad.analog.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com> <1251777330-16994-2-git-send-email-21cnbao@gmail.com> <8bd0f97a0909011141p144a927cg39e6bf0313165a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:10203 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540AbZIBCKr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Sep 2009 22:10:47 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <8bd0f97a0909011141p144a927cg39e6bf0313165a8@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>, Barry Song <21cnbao@gmail.com>
Cc: dbrownell@users.sourceforge.net, dtor@mail.ru, dmitry.torokhov@gmail.com, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

 

>-----Original Message-----
>From: uclinux-dist-devel-bounces@blackfin.uclinux.org 
>[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On 
>Behalf Of Mike Frysinger
>Sent: Wednesday, September 02, 2009 2:41 AM
>To: Barry Song
>Cc: dbrownell@users.sourceforge.net; dtor@mail.ru; 
>dmitry.torokhov@gmail.com; 
>spi-devel-general@lists.sourceforge.net; 
>linux-input@vger.kernel.org; uclinux-dist-devel@blackfin.uclinux.org
>Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] add ad714x 
>platform_datadefinition
>
>On Mon, Aug 31, 2009 at 23:55, Barry Song<21cnbao@gmail.com> wrote:
>> --- /dev/null
>> +++ b/include/linux/spi/ad714x.h
>> @@ -0,0 +1,60 @@
>> +/*
>> + * include/linux/ad714x.h
>> + *
>> + * AD714x is very flexible, it can be used as buttons, scrollwheel,
>> + * slider, touchpad at the same time. That depends on the boards.
>> + * The platform_data for the device's "struct device" holds this
>> + * information.
>> + */
>
>missing lines:
> * Copyright 2009 Analog Devices Inc.
> *
> * Licensed under the GPL-2 or later.
>
>> +#ifndef AD714X_HW_H
>> +#define AD714X_HW_H
>
>header files should not be using an unprefixed name space (even if
>it's an uncommon define name), and the name really should match the
>header.  i.e. __LINUX_SPI_AD714X_H__
Fixed.
>-mike
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel@blackfin.uclinux.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>
