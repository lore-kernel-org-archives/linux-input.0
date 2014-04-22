From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add REP_MAX_COUNT to autorepeat parameters
Date: Mon, 21 Apr 2014 21:59:54 -0700
Message-ID: <20140422045954.GA32749@core.coreip.homeip.net>
References: <20140421200008.CBC0F1007B4@puck.mtv.corp.google.com>
 <20140421201710.GA30454@core.coreip.homeip.net>
 <CAGXr9JFj4v7wSbr+k9kev9818_FeOJO1Dm38ntTMQbw0HFYK_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:43419 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbaDVE75 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 00:59:57 -0400
Received: by mail-pa0-f52.google.com with SMTP id kx10so489033pab.25
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2014 21:59:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGXr9JFj4v7wSbr+k9kev9818_FeOJO1Dm38ntTMQbw0HFYK_g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petri Gynther <pgynther@google.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Mon, Apr 21, 2014 at 03:06:32PM -0700, Petri Gynther wrote:
> Hi Dmitry,
> 
> On Mon, Apr 21, 2014 at 1:17 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Petri,
> >
> > On Mon, Apr 21, 2014 at 01:00:08PM -0700, Petri Gynther wrote:
> >> Add REP_MAX_COUNT to autorepeat parameters. This enables an input device to be
> >> configured for maximum autorepeat count, so that a keypress is not repeated
> >> forever. This is important for Bluetooth keyboards and remote controls that may
> >> lose the Bluetooth link at any time, e.g. right after sending a key-down event
> >> but before sending the corresponding key-up event.
> >
> > I think this should be solved in the drivers - if link is lost then they
> > should tear down the device (or generate keyup events if they want to
> > hand onto the device).
> 
> In my opinion, since the keypress autorepeat code lives in the input
> subsystem, it should provide some kind of mechanism to limit the
> autorepeat if the user wants to configure so. The delay and period are
> already configurable, so this just adds the upper limit, so that the
> autorepeat doesn't go on forever.

No, autorepeat should run until the key is released; that is your upper
bound. What you are trying to do is work around the issue in a given
driver that does not report key releases properly and such workaround is
not acceptable. Not it is sufficient: one can disable kernel-level
autorepeat and you'll end up with userspace autorepeating in the very
same fashion.

> 
> For Bluetooth LE remote controls (HID over GATT), BlueZ daemon uses
> uHID kernel driver (drivers/hid/uhid.c) to create the necessary HID
> device and pass the HID input events. This device is persistent over
> reconnects, so the HID and input devices are not destroyed and
> re-created on every disconnect and reconnect. On BLE device
> disconnect, BlueZ daemon cannot inject the necessary key-up event
> because it would have to know the HID input report details in order to
> do so. And, uHID driver doesn't support disconnect-reconnect unless
> the input pipeline is completely torn down and re-created (which is
> not desirable).

Maybe uhid needs another way to indicate that device was disconnected
and its state is no longer valid, it is still a driver issue as far as I
can see.

Thanks.

-- 
Dmitry
