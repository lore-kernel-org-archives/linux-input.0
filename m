From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for v4.12-rc4
Date: Mon, 19 Jun 2017 19:55:50 -0700
Message-ID: <20170620025550.GE21379@dtor-ws>
References: <20170610003346.GA35678@dtor-ws>
 <CAEk1YH6SNmCGxBh8i-1PhU=g_fekQ4K=6fnj326b+zTfWC7aWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35221 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdFTCzy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 22:55:54 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so20442126pfs.2
        for <linux-input@vger.kernel.org>; Mon, 19 Jun 2017 19:55:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAEk1YH6SNmCGxBh8i-1PhU=g_fekQ4K=6fnj326b+zTfWC7aWg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Damjan Georgievski <gdamjan@gmail.com>
Cc: linux-input@vger.kernel.org

On Sat, Jun 10, 2017 at 12:42:13PM +0200, Damjan Georgievski wrote:
> >
> > - mark "guest" RMI device as pass-through port to avoid "phantom" ALPS
> >   toouchpad on newer Lenovo Carbons
> 
> What's the end game for supporting these devices?
> 
> With the latest HEAD of Linus, first I get:
> » Jun 10 12:19:17 cambrian kernel: psmouse serio1: synaptics: Your
> touchpad (PNP: LEN0072 PNP0f13) says it can support a different bus.
> If i2c-hid and hid-rmi are not used, you might want to try setting
> psmouse.synaptics_intertouch to 1 and report this to
> linux-input@vger.kernel.org.
> 
> Then if I patch drivers/input/mouse/synaptics.c and add "LEN0072" to
> smbus_pnp_ids, this strange thing happens:
> 
> [    8.526635] psmouse serio1: synaptics: queried max coordinates: x
> [..5676], y [..4760]
> [    8.555746] psmouse serio1: synaptics: queried min coordinates: x
> [1266..], y [1094..]
> [    8.555750] psmouse serio1: synaptics: Trying to set up SMBus access
> [    8.615774] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
> Synaptics, product: TM3289-002, fw id: 2492434
> [    8.679863] input: Synaptics TM3289-002 as /devices/rmi4-00/input/input18
> [    8.682660] mousedev: PS/2 mouse device common for all mice
> … snipped …
> [  107.225549] input: ImPS/2 Generic Wheel Mouse as
> /devices/rmi4-00/rmi4-00.fn03/serio2/input/input20
> 
> Notice how the trackpoint only appeared 100 seconds after boot (X was
> already started and initially the trackpoint was not listed in xinput)

100 seconds is quire ridiculous. Could you please post your entire boot
log so we can understand what happened there.

Thanks.

-- 
Dmitry
