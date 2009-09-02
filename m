From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH 1/2] add ad714x platform_datadefinition
Date: Wed, 2 Sep 2009 12:47:23 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04A96A41@chinexm1.ad.analog.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com><1251777330-16994-2-git-send-email-21cnbao@gmail.com> <200909011857.37755.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:14686 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbZIBEr2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Sep 2009 00:47:28 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <200909011857.37755.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Barry Song <21cnbao@gmail.com>
Cc: dbrownell@users.sourceforge.net, dtor@mail.ru, dmitry.torokhov@gmail.com, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

 

>-----Original Message-----
>From: uclinux-dist-devel-bounces@blackfin.uclinux.org 
>[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On 
>Behalf Of David Brownell
>Sent: Wednesday, September 02, 2009 9:58 AM
>To: Barry Song
>Cc: dbrownell@users.sourceforge.net; dtor@mail.ru; 
>dmitry.torokhov@gmail.com; 
>spi-devel-general@lists.sourceforge.net; 
>linux-input@vger.kernel.org; uclinux-dist-devel@blackfin.uclinux.org
>Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] add ad714x 
>platform_datadefinition
>
>On Monday 31 August 2009, Barry Song wrote:
>> --- /dev/null
>> +++ b/include/linux/spi/ad714x.h
>
>Doesn't belong under SPI since this is also used by the
>I2C version of the chip.  Likely include/linux/input/*h
>is best.

I really wanted to place it to include/linux/input, but the
include/linux/input doesn't exist and current input header files are
placed in the parent dir "include/linux".

>
>
>> @@ -0,0 +1,60 @@
>> +/*
>> + * include/linux/ad714x.h
>
>Never include the directories.  And the coding style says
>this should have a twitter-sized description of the driver
>in that line, like
>
>   * ad714x.h -- platform data for capacitance sensor driver
>
>It's good policy to include a brief GPL statement at the top
>of every source file too, including a Copyright (C) you.
>
>
>> + *
>> + * AD714x is very flexible, it can be used as buttons, scrollwheel,
>> + * slider, touchpad at the same time. That depends on the boards.
>> + * The platform_data for the device's "struct device" holds this
>> + * information.
>> + */
>> +
>> +
>> +#ifndef AD714X_HW_H
>> +#define AD714X_HW_H
>
>As noted:  __LINUX_INPUT_AD714X_H is the style to use here.
>
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel@blackfin.uclinux.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>
