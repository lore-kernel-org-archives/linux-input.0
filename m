From: Tommy Will <tommywill2011@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Recognise "Dolphin V2" touchpads
Date: Wed, 8 Jan 2014 00:24:39 +0800
Message-ID: <CA+F6ckNx8nxjtXLrgzYyNUBnnmb09tFx8zSe=y0JxtMiVrTooQ@mail.gmail.com>
References: <1389039034-14040-1-git-send-email-chris@diamand.org>
	<CAKvfdtK18rQ4TOqwKCj1P3oQs-BQZr2h3db5NH18WdtNjjnH=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:45765 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbaAGQYl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jan 2014 11:24:41 -0500
Received: by mail-la0-f46.google.com with SMTP id eh20so276833lab.5
        for <linux-input@vger.kernel.org>; Tue, 07 Jan 2014 08:24:40 -0800 (PST)
In-Reply-To: <CAKvfdtK18rQ4TOqwKCj1P3oQs-BQZr2h3db5NH18WdtNjjnH=g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Diamand <chris@diamand.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Cernekee <cernekee@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, david turvene <dturvene@dahetral.com>
Cc: linux-input@vger.kernel.org

Hi Chris,

> This is the touchpad used on the Dell Vostro 3360. Without
> this change, the driver reports this as follows:

> psmouse serio1: alps: Unknown ALPS touchpad: E7=73 03 50, EC=73 02 02

> It seems to use the ALPS V5 protocol, so identify it
> as such by allowing ec[1] == 0x02.

> This is based on src/alps.c from the DKMS driver here:
> http://www.dahetral.com/public-download/alps-psmouse-dlkm-for-3-2-and-3-5/

Thanks for your patch!
Umm, however, I had submited a similar patch for supporting dolphin v2
device last month and it was now applied into latest mainline. Detail
please check the source code in below link.

    git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

Thanks
-- 
Best Regards,
Tommy
