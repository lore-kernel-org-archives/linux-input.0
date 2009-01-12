From: Alessio Sangalli <alesan@manoweb.com>
Subject: Re: Equivalent of /dev/input/mice for keyboards
Date: Mon, 12 Jan 2009 13:14:43 -0800
Message-ID: <496BB2C3.9080307@manoweb.com>
References: <495EA371.8050304@manoweb.com> <20090111232539.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61158 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbZALVOt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 16:14:49 -0500
In-Reply-To: <20090111232539.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:

> I am very hesitant adding such multiplexing device to the kernel. While
> it is pretty easy to write one we had only pain from them. There are all
> kinds of quirks, grabs, and workarounds because people are using
> /dev/input/mice and console but at the same time want to use event
> devices for some of the hardware.

Yes I appreciate your comments, I get your point.

What I would personally like to experiment with is:
- enabling this driver would automatically disable the other event
devices and the console, so it is the only source of input events for
the system
- to me it's also an exercise the helps the understanding of the input
layer and the kernel in general.

In my free time, I'd like to do the implementation, having in mind you
are not interested in merging it into the kernel. Would you spare some
hints on how you would proceed?

bye
as

