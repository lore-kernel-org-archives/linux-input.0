From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: uinput: ioctls for UI_BEGIN_FF_UPLOAD fails (returns -1). How to
 debug?
Date: Tue, 5 Apr 2016 21:10:15 +0200
Message-ID: <57040D97.4070904@m-reimer.de>
References: <56F82C42.6020002@m-reimer.de>
 <CAM4jgCp_t_mvayUbBnz_1aznbvZJz8jFLxbD49r=qLZCdOhH7Q@mail.gmail.com>
 <56F8F107.3050906@m-reimer.de>
 <CAM4jgCo9a-6ati0tQWCZqBRyxM6E6NrQK6Cj0uGQAogCRMgrOA@mail.gmail.com>
 <56FAB1D3.5020003@m-reimer.de> <56FD628A.6040606@m-reimer.de>
 <5700EA4D.20700@m-reimer.de>
 <CAM4jgCqEZi=Hu2bv28nWgPYbXNNT40QeqdaCLqN-ajY5Z2DHVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:45146 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbcDETKU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Apr 2016 15:10:20 -0400
In-Reply-To: <CAM4jgCqEZi=Hu2bv28nWgPYbXNNT40QeqdaCLqN-ajY5Z2DHVQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Cl=c3=a9ment_VUCHENER?= <clement.vuchener@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On 04/03/2016 12:21 PM, Cl=C3=A9ment VUCHENER wrote:
> At line 159 you are passing the address of a stack variable that is n=
o
> longer valid when leaving the "if (1)". So the content of rargs may b=
e
> overwritten by future stack variable like msg_out in the next loop.
> Fix your memory management and you may find out you don't actually
> have any problem with uinput.

Exactly! This seems to have resolved my problem. I did several tries an=
d=20
so far no more crashes.

https://github.com/M-Reimer/pspaddrv/commit/effbaae8

Thank you very much for finding this one! I don't think I would have=20
ever found that one and maybe had given up at last...

Now I can continue with some code cleanup, adding the rumble code for=20
PS4 and finally I'll have to find a way to get the common "emulated=20
events" for memoryless devices. One solution would be to try to get=20
ff_memless connected with uinput via kernel patch. I'll give that a try=
=20
first.

Manuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
