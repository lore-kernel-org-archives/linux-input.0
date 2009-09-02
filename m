From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input driver forbutton/scrollwhell/slider/touchpad
Date: Wed, 2 Sep 2009 16:37:52 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04A96D96@chinexm1.ad.analog.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com> <8bd0f97a0909011230r50cb532ep46db64d65cbb49e5@mail.gmail.com> <0F1B54C89D5F954D8535DB252AF412FA04A5CADA@chinexm1.ad.analog.com> <200909012131.27471.david-b@pacbell.net> <3c17e3570909020051lfec50ecr77796655d75e12ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:5666 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbZIBIhx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Sep 2009 04:37:53 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <3c17e3570909020051lfec50ecr77796655d75e12ca@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>, David Brownell <david-b@pacbell.net>
Cc: Mike Frysinger <vapier.adi@gmail.com>, dbrownell@users.sourceforge.net, dtor@mail.ru, dmitry.torokhov@gmail.com, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

 

>-----Original Message-----
>From: Barry Song [mailto:21cnbao@gmail.com] 
>Sent: Wednesday, September 02, 2009 3:52 PM
>To: David Brownell
>Cc: Song, Barry; Mike Frysinger; 
>dbrownell@users.sourceforge.net; dtor@mail.ru; 
>dmitry.torokhov@gmail.com; 
>spi-devel-general@lists.sourceforge.net; 
>linux-input@vger.kernel.org; uclinux-dist-devel@blackfin.uclinux.org
>Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input 
>driver forbutton/scrollwhell/slider/touchpad
>
>David,
>I am really surprised the kmalloc memory can keep DMA-safe. Check the
>code, no matter spi_write_then_read and spi_init, they only get memory
>by a simple
>kmalloc(SPI_BUFSIZ, GFP_KERNEL);
>I can't find map_single or dma coherent operations at all. So did I
>lose something?
>Thanks
>Barry

Get it. SPI driver need to make dma_map_single or other dma coherent
operations by itself. The kmalloc memory you call only makes sure the
DMA-safe but not DMA-consistent.

>
>On 9/2/09, David Brownell <david-b@pacbell.net> wrote:
>> On Tuesday 01 September 2009, Song, Barry wrote:
>>> >> +       spi_message_add_tail(&t, &m);
>>> >> +       ret = spi_sync(spi, &m);
>>> >
>>> >cant you use spi_write_then_read() ?  dont let the u8* 
>prototype scare
>>> >you, it should work with writing 16bits and then reading 16bits.
>>>
>>> I have never been scared by any u8* or something else. I only prefer
>>> to use raw spi API, which can show the bottom level timing and SPI
>>> bus feature better.
>>
>> In this case spi_write_then_read() is required, since
>> your tx and rx buffers are on the stack and hence not
>> DMA-safe.
>>
>
