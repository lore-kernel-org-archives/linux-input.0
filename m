From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: uinput: ioctls for UI_BEGIN_FF_UPLOAD fails (returns -1). How to debug?
Date: Sun, 3 Apr 2016 12:21:05 +0200
Message-ID: <CAM4jgCqEZi=Hu2bv28nWgPYbXNNT40QeqdaCLqN-ajY5Z2DHVQ@mail.gmail.com>
References: <56F82C42.6020002@m-reimer.de>
	<CAM4jgCp_t_mvayUbBnz_1aznbvZJz8jFLxbD49r=qLZCdOhH7Q@mail.gmail.com>
	<56F8F107.3050906@m-reimer.de>
	<CAM4jgCo9a-6ati0tQWCZqBRyxM6E6NrQK6Cj0uGQAogCRMgrOA@mail.gmail.com>
	<56FAB1D3.5020003@m-reimer.de>
	<56FD628A.6040606@m-reimer.de>
	<5700EA4D.20700@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:32865 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbcDCKVG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Apr 2016 06:21:06 -0400
Received: by mail-ig0-f177.google.com with SMTP id ma7so50932627igc.0
        for <linux-input@vger.kernel.org>; Sun, 03 Apr 2016 03:21:05 -0700 (PDT)
In-Reply-To: <5700EA4D.20700@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>

2016-04-03 12:02 GMT+02:00 Manuel Reimer <mail+linux-input@m-reimer.de>:
> On 03/31/2016 07:46 PM, Manuel Reimer wrote:
>
>
> Sorry for the spam, but my hope is that someone may have some hint that
> helps me to track this down.
>
> To further narrow things down, I commented the following line:
> https://github.com/M-Reimer/pspaddrv/blob/master/device-handler.c#L176
>
> This means, that my code does no longer actually do any sending to uinput!
>
> And.... I still have the same problem... :(
>

At line 159 you are passing the address of a stack variable that is no
longer valid when leaving the "if (1)". So the content of rargs may be
overwritten by future stack variable like msg_out in the next loop.
Fix your memory management and you may find out you don't actually
have any problem with uinput.
