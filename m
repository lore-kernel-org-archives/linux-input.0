From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND 0/5] Evdev Extensions
Date: Sun, 20 Jul 2014 17:37:40 -0700
Message-ID: <20140721003739.GC22552@core.coreip.homeip.net>
References: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63768 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbaGUAho (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 20:37:44 -0400
Received: by mail-pa0-f46.google.com with SMTP id lj1so8621166pab.19
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2014 17:37:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405775445-4454-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>

Hi David,

On Sat, Jul 19, 2014 at 03:10:40PM +0200, David Herrmann wrote:
> Hi Dmitry
> 
> I posted all these ~2 months ago, but haven't seen any comments from you. Seeing
> that you switched jobs (congratulations, btw!),

Thanks :)

>I guess you were quite busy the
> last few weeks. Hence, here's a resend of all the evdev changes squashed into a
> single series. They're also available in my fdo repo [1] in case you wanna fetch
> them directly.
> 
> No big changes except for a single "udev->state == UIST_CREATED" fix spotted by
> Peter.
> 
> The last patch is still RFC, so please omit it in case you apply the patches!
> 
> All patches but the last are tested via libevdev and run fine here since several
> months.

OK, I am looking at/applying them.

BTW, please continue using my @gmail.com address for upstream input
stuff and @google if it is something corporate related.

Thanks!

-- 
Dmitry
