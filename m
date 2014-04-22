From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] evdev: flush ABS_* events during EVIOCGABS
Date: Tue, 22 Apr 2014 08:21:54 +0200
Message-ID: <CANq1E4RQtaNNab9PzoBchmx2qqpJ5_PdrZjf2+ZQkq4YTNzXkA@mail.gmail.com>
References: <1397156944-5991-1-git-send-email-dh.herrmann@gmail.com>
	<20140422041535.GA10735@yabbi.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35488 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbaDVGVz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 02:21:55 -0400
Received: by mail-ig0-f169.google.com with SMTP id h18so2519810igc.4
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2014 23:21:54 -0700 (PDT)
In-Reply-To: <20140422041535.GA10735@yabbi.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi Peter

On Tue, Apr 22, 2014 at 6:15 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> How are you planning to handle the slot-based events? We'd either need to
> add something similar (but more complex) to evdev_handle_mt_request or rely
> on the caller to call the whole EV_ABS range and ditch anything ABS_MT_.
> I'd prefer the former, the latter is yet more behaviour that's easy to get
> wrong.

This is all racy..

We _really_ need an ioctl to receive _all_ ABS information atomically.
I mean, there's no way we can know the user's state from the kernel.
Even if the user resyncs via EVIOCGMTSLOTS, we can never flush the
whole ABS queue. Problem is, the user has to call the ioctl for _each_
available MT code and events might get queued in between. So yeah,
this patch doesn't help much..

I have no better idea than adding a new EVIOCGABS call that retrieves
ABS values for all slots atomically (and for all other axes..). No
idea how to properly fix the old ioctls.

Thanks
David
