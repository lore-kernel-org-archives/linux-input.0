From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: uinput really needs a custom sleep time?
Date: Fri, 3 Feb 2017 08:19:16 +1000
Message-ID: <20170202221916.GB23446@jelly>
References: <20170131020039.GA2138@xfiles>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:57480 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdBBWTW (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Feb 2017 17:19:22 -0500
Content-Disposition: inline
In-Reply-To: <20170131020039.GA2138@xfiles>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Jan 31, 2017 at 12:00:40AM -0200, Marcos Paulo de Souza wrote:
> Hi input guys,
> 
> after playing with uinput, it seems an sleep call is necessary before
> emitting new events. If this really required?
> 
> While reading code of cwiid project, another user of uinput interface, it
> seems this sleep time isn't necessary[1].
> 
> In the other hang, when trying to send a simple event in my desktop, an
> sleep is necessary, take a look in my example[2].
> 
> Another interesting fact: kernel documentation lacks of an uinput example.
> Do you think this would be interesting to have one?

I'm obviously biased but imo you should really use libevdev for uinput
devices, it makes things a lot easier. Example is here:
https://www.freedesktop.org/software/libevdev/doc/latest/group__uinput.html

it also makes any sleep calls obsolete because it won't return until the
device node is available.

Cheers,
   Peter

> 
> Thanks for your time,
> Marcos
> 
> [1] https://github.com/abstrakraft/cwiid/blob/master/wminput/uinput.c#L193
> [2] https://github.com/marcosps/kernel_experiments/blob/master/userspace/uinput.c#L65
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
