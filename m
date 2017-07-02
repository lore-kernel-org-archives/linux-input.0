From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: PROBLEM: atkbd: Incorrect (?) handling of BAT from laptop PS/2
 keyboard
Date: Sun, 2 Jul 2017 13:25:35 -0700
Message-ID: <20170702202535.GA3935@dtor-ws>
References: <CAB92dJZtxT2+CqKyNjW5NuE8wWvXVmKknt5muHZdbucXXRMT5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34494 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbdGBUZj (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 2 Jul 2017 16:25:39 -0400
Received: by mail-pf0-f179.google.com with SMTP id s66so90081706pfs.1
        for <linux-input@vger.kernel.org>; Sun, 02 Jul 2017 13:25:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAB92dJZtxT2+CqKyNjW5NuE8wWvXVmKknt5muHZdbucXXRMT5A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Babayants <babayants.alexander@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Alexander,

On Sun, Jul 02, 2017 at 04:32:18AM +0300, Alexander Babayants wrote:
> Hi,
> 
> HP Pavilion 15 keyboard controller sometimes (as far as I've found, at
> least after keyboard (re-)connection and LED status change) emits 0xAA
> scancode (BAT passed) and key-up events for LCtrl, LAlt, RCtrl, RAlt,
> RShift. This, in turn, causes the keyboard to reconnect
> (drivers/input/keyboard/atkbd.c, line 424) and to emit 0xAA scancode again,
> which results in keyboard being stuck in endless loop of reconnecting.
> While in this loop, keyboard is usable, but some keystrokes are being
> occasionally dropped.
> Is it necessary to handle BAT scancode in such particular way? Couldn't it
> just be ignored?

We should not ignore BAT, as it normally indicates that the keyboard
lost its state and we need to re-initialize it (update LED state to be
in sync with the keyboard state, set up repeat rate, select proper set -
2 or 3, etc).

I would be interesting to see the command stream there. Can you try
booting with i8042.debug and reproducing the issue?

Thanks.

-- 
Dmitry
