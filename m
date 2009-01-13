From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Equivalent of /dev/input/mice for keyboards
Date: Mon, 12 Jan 2009 21:53:55 -0800
Message-ID: <20090112215048.ZZRA012@mailhub.coreip.homeip.net>
References: <495EA371.8050304@manoweb.com> <20090111232539.ZZRA012@mailhub.coreip.homeip.net> <496BB2C3.9080307@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:55073 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008AbZAMFye (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 00:54:34 -0500
Received: by an-out-0708.google.com with SMTP id d40so3639252and.1
        for <linux-input@vger.kernel.org>; Mon, 12 Jan 2009 21:54:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <496BB2C3.9080307@manoweb.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessio Sangalli <alesan@manoweb.com>
Cc: linux-input@vger.kernel.org

On Mon, Jan 12, 2009 at 01:14:43PM -0800, Alessio Sangalli wrote:
> Dmitry Torokhov wrote:
> 
> > I am very hesitant adding such multiplexing device to the kernel. While
> > it is pretty easy to write one we had only pain from them. There are all
> > kinds of quirks, grabs, and workarounds because people are using
> > /dev/input/mice and console but at the same time want to use event
> > devices for some of the hardware.
> 
> Yes I appreciate your comments, I get your point.
> 
> What I would personally like to experiment with is:
> - enabling this driver would automatically disable the other event
> devices and the console, so it is the only source of input events for
> the system
> - to me it's also an exercise the helps the understanding of the input
> layer and the kernel in general.
> 
> In my free time, I'd like to do the implementation, having in mind you
> are not interested in merging it into the kernel. Would you spare some
> hints on how you would proceed?
> 

I would take /dev/input/evdev.c as a base but instead of creating a new
character device in connect() method I would route all events into a
single device created upon module load (also see
drivers/input/mousedev.c). That should be really it.

-- 
Dmitry
