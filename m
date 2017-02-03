From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: uinput really needs a custom sleep time?
Date: Fri, 3 Feb 2017 00:20:19 -0200
Message-ID: <20170203022018.GB29638@xfiles>
References: <20170131020039.GA2138@xfiles>
 <20170202221916.GB23446@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35165 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbdBCCUY (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Feb 2017 21:20:24 -0500
Received: by mail-qt0-f196.google.com with SMTP id s58so1597466qtc.2
        for <linux-input@vger.kernel.org>; Thu, 02 Feb 2017 18:20:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170202221916.GB23446@jelly>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org

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

I created another example[1], basically converting my uinput code now using
libevdev, but it doesn't work as it should...

Am I missing something, or forgetting to set some bit?

Thanks.

[1]
https://github.com/marcosps/kernel_experiments/blob/master/userspace/evdev.c

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
