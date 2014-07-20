From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] Input: evdev - drop redundant list-locking
Date: Sun, 20 Jul 2014 12:53:31 -0700
Message-ID: <20140720195331.GB4446@core.coreip.homeip.net>
References: <1405882092-7005-1-git-send-email-dh.herrmann@gmail.com>
 <20140720185406.GA4446@core.coreip.homeip.net>
 <CANq1E4RRV7A3dAJgeNCV72Q_sUz7mhbSPFLP+f3J+K2YVd4_0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36535 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008AbaGTTxd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2014 15:53:33 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so7906889pdb.19
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2014 12:53:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANq1E4RRV7A3dAJgeNCV72Q_sUz7mhbSPFLP+f3J+K2YVd4_0w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

On Sun, Jul 20, 2014 at 09:00:02PM +0200, David Herrmann wrote:
> Hi
> 
> On Sun, Jul 20, 2014 at 8:54 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Sun, Jul 20, 2014 at 08:48:12PM +0200, David Herrmann wrote:
> >> evdev->client_list is rcu-protected. There is no need to have a
> >> separate spinlock just for the list. Either one is good enough, so lets
> >> drop the spinlock.
> >>
> >> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> >> ---
> >> Hi
> >>
> >> I stumbled across this one when doing some evdev reviews. Maybe I'm missing
> >> something obvious and I should stop coding on Sundays. But the RCU-protection
> >> should be enough here, right?
> >
> > RCU protection is for traversing list only, writes (as is adding and removing
> > elements from client_list) still have to be mutually exclusive.
> 
> Oh, you mean to protect against concurrent writes? Right, but we could
> just use evdev->mutex for that. I mean all paths that call
> attach_client() or detach_client() already lock evdev->mutex at some
> point. It would allow us to get rid of the lock.

Right, we probably could do it by pulling taking/releasing evdev->mutex into
evdev_pen and evdev_release.

Thanks.

-- 
Dmitry
