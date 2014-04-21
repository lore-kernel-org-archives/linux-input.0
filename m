From: Petri Gynther <pgynther@google.com>
Subject: Re: [PATCH] Input: Add REP_MAX_COUNT to autorepeat parameters
Date: Mon, 21 Apr 2014 15:06:32 -0700
Message-ID: <CAGXr9JFj4v7wSbr+k9kev9818_FeOJO1Dm38ntTMQbw0HFYK_g@mail.gmail.com>
References: <20140421200008.CBC0F1007B4@puck.mtv.corp.google.com>
	<20140421201710.GA30454@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:48301 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbaDUWGd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2014 18:06:33 -0400
Received: by mail-vc0-f171.google.com with SMTP id lg15so1658206vcb.30
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2014 15:06:33 -0700 (PDT)
In-Reply-To: <20140421201710.GA30454@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi Dmitry,

On Mon, Apr 21, 2014 at 1:17 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Petri,
>
> On Mon, Apr 21, 2014 at 01:00:08PM -0700, Petri Gynther wrote:
>> Add REP_MAX_COUNT to autorepeat parameters. This enables an input device to be
>> configured for maximum autorepeat count, so that a keypress is not repeated
>> forever. This is important for Bluetooth keyboards and remote controls that may
>> lose the Bluetooth link at any time, e.g. right after sending a key-down event
>> but before sending the corresponding key-up event.
>
> I think this should be solved in the drivers - if link is lost then they
> should tear down the device (or generate keyup events if they want to
> hand onto the device).

In my opinion, since the keypress autorepeat code lives in the input
subsystem, it should provide some kind of mechanism to limit the
autorepeat if the user wants to configure so. The delay and period are
already configurable, so this just adds the upper limit, so that the
autorepeat doesn't go on forever.

For Bluetooth LE remote controls (HID over GATT), BlueZ daemon uses
uHID kernel driver (drivers/hid/uhid.c) to create the necessary HID
device and pass the HID input events. This device is persistent over
reconnects, so the HID and input devices are not destroyed and
re-created on every disconnect and reconnect. On BLE device
disconnect, BlueZ daemon cannot inject the necessary key-up event
because it would have to know the HID input report details in order to
do so. And, uHID driver doesn't support disconnect-reconnect unless
the input pipeline is completely torn down and re-created (which is
not desirable).

-- Petri

>
> Thanks.
>
> --
> Dmitry
