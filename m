From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: support for some types of Asus+Elantech touchpads
Date: Tue, 1 Dec 2015 13:08:52 -0800
Message-ID: <20151201210852.GA3740@dtor-ws>
References: <565DFC20.7070303@mwg.dp.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32770 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbbLAVIz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2015 16:08:55 -0500
Received: by pabfh17 with SMTP id fh17so17242934pab.0
        for <linux-input@vger.kernel.org>; Tue, 01 Dec 2015 13:08:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <565DFC20.7070303@mwg.dp.ua>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wladimir Mutel <mwg@mwg.dp.ua>
Cc: linux-input@vger.kernel.org

Hi Wladimir,

On Tue, Dec 01, 2015 at 09:59:28PM +0200, Wladimir Mutel wrote:
> Dear Dmitry & linux-input members,
> 
> some new Asus (and probably non-Asus) laptops are shipped with a new
> kind of Elantech (not sure if only Elantech) touchpads which are not
> adequately handled by Linux kernel module (psmouse). First problem
> is that these touchpads are dying off (losing their sensitivity and
> response) when the system is put into pm-suspend and then waken up.
> Another problem is that on reload (modprobe -r ... && modprobe ...)
> of psmouse module they are dying off too, in 'dmesg' coming with
> some weird-numbered indexes (like, input5 on initial load and
> input292 on reload of psmouse).
> 
> There are some bugs reported in Ubuntu Launchpad on this topic
> (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1519034 is my
> own, also
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1490130 ,
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1506363 ,
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1504445 and
> some others).
> Also there is a proposed patch at
> https://marc.info/?l=linux-input&m=144312209020616
> and one more report at
> http://www.spinics.net/lists/linux-input/msg41634.html
> 
> For me, these problems look related. I have Asus X302LA on which I
> am testing Ubuntu Xenial and whose touchpad exhibits this problem.
> If you need I could provide my assistance in testing psmouse module
> on this hardware. Thank you in advance for your response.

Does the noselftest patch help on your box (you'd have to adjust
i8042_dmi_noselftest_table with the DMI data for your laptop)?

Thanks.

-- 
Dmitry
