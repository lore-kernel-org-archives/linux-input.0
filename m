From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: uinput really needs a custom sleep time?
Date: Thu, 2 Feb 2017 22:56:22 -0200
Message-ID: <20170203005621.GA25571@xfiles>
References: <20170131020039.GA2138@xfiles>
 <20170202221916.GB23446@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34812 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbdBCA5I (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Feb 2017 19:57:08 -0500
Received: by mail-qt0-f193.google.com with SMTP id w20so1206574qtb.1
        for <linux-input@vger.kernel.org>; Thu, 02 Feb 2017 16:57:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170202221916.GB23446@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org

Hi Peter,

On Fri, Feb 03, 2017 at 08:19:16AM +1000, Peter Hutterer wrote:
> On Tue, Jan 31, 2017 at 12:00:40AM -0200, Marcos Paulo de Souza wrote:
> > Hi input guys,
> > 
> > after playing with uinput, it seems an sleep call is necessary before
> > emitting new events. If this really required?
> > 
> > While reading code of cwiid project, another user of uinput interface, it
> > seems this sleep time isn't necessary[1].
> > 
> > In the other hang, when trying to send a simple event in my desktop, an
> > sleep is necessary, take a look in my example[2].
> > 
> > Another interesting fact: kernel documentation lacks of an uinput example.
> > Do you think this would be interesting to have one?
> 
> I'm obviously biased but imo you should really use libevdev for uinput
> devices, it makes things a lot easier. Example is here:
> https://www.freedesktop.org/software/libevdev/doc/latest/group__uinput.html
> 
> it also makes any sleep calls obsolete because it won't return until the
> device node is available.

So, I had some problems to understand the relation to EV_KEY, EV_TYPE,
and other stuff to configure uinput, and reading about evdev[1], I think
I really should take a look on it.

Thanks a lot for pointing evdev as a "competitor" of uinput!

[1]
http://who-t.blogspot.com.br/2016/05/the-difference-between-uinput-and-evdev.html

> 
> Cheers,
>    Peter
> 
> > 
> > Thanks for your time,
> > Marcos
> > 
> > [1] https://github.com/abstrakraft/cwiid/blob/master/wminput/uinput.c#L193
> > [2] https://github.com/marcosps/kernel_experiments/blob/master/userspace/uinput.c#L65
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
