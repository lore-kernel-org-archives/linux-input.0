From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH 0/2] add ad714x captouch sensorinput driver
Date: Wed, 2 Sep 2009 10:08:49 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04A5CA00@chinexm1.ad.analog.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com> <8bd0f97a0909011146t210cbacbx6b0fa323242ac3d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:50558 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbZIBCIy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Sep 2009 22:08:54 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <8bd0f97a0909011146t210cbacbx6b0fa323242ac3d3@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>, Barry Song <21cnbao@gmail.com>
Cc: dbrownell@users.sourceforge.net, dtor@mail.ru, dmitry.torokhov@gmail.com, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

 

>-----Original Message-----
>From: uclinux-dist-devel-bounces@blackfin.uclinux.org 
>[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On 
>Behalf Of Mike Frysinger
>Sent: Wednesday, September 02, 2009 2:46 AM
>To: Barry Song
>Cc: dbrownell@users.sourceforge.net; dtor@mail.ru; 
>dmitry.torokhov@gmail.com; 
>spi-devel-general@lists.sourceforge.net; 
>linux-input@vger.kernel.org; uclinux-dist-devel@blackfin.uclinux.org
>Subject: Re: [Uclinux-dist-devel] [PATCH 0/2] add ad714x 
>captouch sensorinput driver
>
>On Mon, Aug 31, 2009 at 23:55, Barry Song wrote:
>> David,
>> The patch[1/2] adds a file with platform_data definition for 
>AD714x in include/linux/spi,
>> which describes the components layout on special target 
>boards and need be filled in
>> arch/mach.
>
>i dont think this needs to split merged between David's spi and
>Dmitry's input tree.  would make more sense to me to merge it as one
>patchset via Dmitry's input tree.
I split them because I am not sure whether input tree can accept files
added in include/linux/spi which is not maintained by them directly.
I think maybe only spi men can accept? I have no idea.
> 
>> Dmitry,
>> The patch[2/2] adds a file in drivers/input/misc and changes 
>Kconfig&Makefile, fulfilling
>> the algorithms and state machines for the related 
>buttons/sliders/scrollwheels/touchpads
>> defined in platform_data. So the driver becomes be 
>independent of special target boards.
>
>looks like your patch [2/2] is incomplete as it doesnt include any
>Kconfig or Makefile changes
>-mike
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel@blackfin.uclinux.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>
