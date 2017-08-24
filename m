From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2 0/3] Input/HID: joydev fixes for motion sensors
Date: Thu, 24 Aug 2017 02:08:25 +0200
Message-ID: <1503533305.23013.8.camel@hadess.net>
References: <20170818020156.23390-1-roderick@gaikai.com>
         <1503479092.24498.18.camel@hadess.net>
         <CANndSK=mBvBekPTGnKBzMcg7xw5X5bLpNioTZSLFgsEeU6+KeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46485 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdHXAI2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Aug 2017 20:08:28 -0400
In-Reply-To: <CANndSK=mBvBekPTGnKBzMcg7xw5X5bLpNioTZSLFgsEeU6+KeA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Wed, 2017-08-23 at 16:57 -0700, Roderick Colenbrander wrote:
> On Wed, Aug 23, 2017 at 2:04 AM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
<snip>
> > I'm not sure I fully understand the problem you're trying to solve.
> > 
> > Is it "old software which relies on joydev is too basic to allow
> > selecting the correct joystick device"? Or "some system components
> > are
> > picking up the joypad's accelerometer like it inferred the screen's
> > positioning"?
> > 
> 
> The problem is more like the first. Joydev is too basic to allow
> applications to determine they are dealing with a motion sensor
> device
> (axes are just numbers from its perspective). Due to recent hid-sony
> restructure, its motion sensors are now picked up by joydev as it
> passes joydev its heuristics.
> 
> We felt that no motion sensors should probably get picked up by the
> legacy joydev interface as it caused issues for legacy applications
> (and users reported issues to me). Originally we proposed filtering
> in
> joydev based on just 'INPUT_PROP_ACCELEROMETER' as it has similar
> filters to filter out touchpad device and others. Discussion on that
> patch led to the composite device discussion as Dmitry felt that the
> ability to use a standalone motion sensor device as a joystick could
> potentially make sense.

In which case a INPUT_PROP_JOYDEV_IGNORE property would be much much
more descriptive of what you want to achieve with this patchset, and
avoids confusion.

I think that INPUT_PROP_COMPOSITE might have its place (and it would be
useful to have supported in toolkits, or wayland compositors), but not
for this purpose.

I'd say repurpose the whole patchset around INPUT_PROP_JOYDEV_IGNORE
and we can look into a more complete INPUT_PROP_COMPOSITE with ioctl()
and co.

Cheers
