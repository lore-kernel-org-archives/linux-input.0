From: Wladimir Mutel <mwg@mwg.dp.ua>
Subject: Re: support for some types of Asus+Elantech touchpads
Date: Fri, 4 Dec 2015 13:32:18 +0200
Message-ID: <20151204113218.GA1982@tag>
References: <565DFC20.7070303@mwg.dp.ua>
 <20151201210852.GA3740@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from volcano.apex.dp.ua ([195.24.128.84]:42908 "EHLO
	volcano.apex.dp.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755431AbbLDLc1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2015 06:32:27 -0500
Received: from [213.110.121.59] (helo=pie)
	by vesuvio.apex.dp.ua with esmtp (Exim 4.69)
	(envelope-from <mwg@mwg.dp.ua>)
	id 1a4obB-0006BE-O2
	for linux-input@vger.kernel.org; Fri, 04 Dec 2015 13:32:25 +0200
Received: from localhost (localhost [127.0.0.1])
	by pie (Postfix) with ESMTP id 3EF851E057
	for <linux-input@vger.kernel.org>; Fri,  4 Dec 2015 13:32:23 +0200 (EET)
Received: from pie ([127.0.0.1])
	by localhost (pie.mwg.dp.ua [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PQ06SnLej_Aq for <linux-input@vger.kernel.org>;
	Fri,  4 Dec 2015 13:32:22 +0200 (EET)
Received: from tag (unknown [192.168.77.1])
	by pie (Postfix) with ESMTPS id D16181E0C3
	for <linux-input@vger.kernel.org>; Fri,  4 Dec 2015 13:32:18 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20151201210852.GA3740@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Dec 01, 2015 at 01:08:52PM -0800, Dmitry Torokhov wrote:

> > Also there is a proposed patch at
> > https://marc.info/?l=linux-input&m=144312209020616

> > For me, these problems look related. I have Asus X302LA on which I
> > am testing Ubuntu Xenial and whose touchpad exhibits this problem.
> > If you need I could provide my assistance in testing psmouse module
> > on this hardware. Thank you in advance for your response.

> Does the noselftest patch help on your box (you'd have to adjust
> i8042_dmi_noselftest_table with the DMI data for your laptop)?

I applied this patch to Ubuntu kernel sources v 4.2.0-19, then put X302LA model code into DMI list,
then rebuilt generic kernel and reinstalled it over Ubuntu packages
After rebooting with this patch, the touchpad now survives pm-suspend well. So it is effective in my case.
It still does not survive reload of psmouse module, coming as .../input5 in initial load, as .../input15 on reload, and then dying off.
But now I don't need this workaround so I can live without that. 
Not sure if any other hardware is supposed to survive psmouse module reload at all.
