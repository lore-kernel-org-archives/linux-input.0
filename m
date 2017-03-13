From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 0/3] Bind RMI4 over SMBus from PS/2
Date: Mon, 13 Mar 2017 10:30:40 +0100
Message-ID: <20170313093040.GB4378@mail.corp.redhat.com>
References: <20170308152445.12082-1-benjamin.tissoires@redhat.com>
 <1489244077.1857.2.camel@kepstin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbdCMJaq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 05:30:46 -0400
Content-Disposition: inline
In-Reply-To: <1489244077.1857.2.camel@kepstin.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Calvin Walton <calvin.walton@kepstin.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi,

On Mar 11 2017 or thereabouts, Calvin Walton wrote:
> Hi,
> 
> On Wed, 2017-03-08 at 16:24 +0100, Benjamin Tissoires wrote:
> > Hi Dmitry,
> > 
> > This is mostly a resend of the PS/2-SMBus binding (last 3 patches of
> > now 3 years
> > of trial and errors).
> > I integrated both warnings raised by Coccinelle, and squashed 4/3
> > into 3/3.
> 
> Just want to provide you some quick feedback from the user's
> perspective...
> 
> I tested this patch set on my somewhat hacked together laptop - I have
> a Lenovo T440p with the touchpad replaced with a "top button pad" from
> a T450 or similar.
> 
> With this patch set (and using the psmouse.synaptics_intertouch=1
> option), the touchpad is found and used via RMI4/SMBUS, and the PS2
> passthrough to the trackpoint does work. Passing the buttons presses
> from the top buttons to the trackpoint device doesn't work - my
> understanding is the code for this isn't included here?

You will need a v4.11-rc1 at least for those buttons to be reported.

> 
> The touchpad cursor movement (and scrolling, etc.) is so much smoother
> than with the PS2 interface of this touchpad model... I'm glad these
> patches are getting closer to complete!

Dmitry made a respin of them with a saner approach. Unfortunately, the
touchpad doesn't respond correctly when psmouse is compiled in the
bzImage, so I am still investigating that. So we are hopefully going to
see this merged soon. (Looking at your dmesg let me think that psmouse
is compiled at a separate module in your case, feel free to test the
new series: http://www.spinics.net/lists/linux-input/msg50162.html )

Cheers,
Benjamin

> 
> Calvin.
> 
> [   17.665070] psmouse serio1: synaptics: queried max coordinates: x [..5676], y [..4758]
> [   17.698107] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1096..]
> [   17.760612] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xf003a3/0x943300/0x12e800/0x10000, board id: 3053, fw id: 2560
> [   17.763619] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
> [   17.766577] psmouse serio1: synaptics: device also supported by an other bus.
> [   17.807548] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input9
> [   18.435205] psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
> [   18.630809] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio1/serio2/input/input18
> [   19.064659] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3053-003, fw id: 1741108
> [   19.131839] input: Synaptics TM3053-003 as /devices/rmi4-00/input/input19
> [   19.152671] rmi4_smbus 9-002c: registered rmi smb driver at 0x2c.
> [   20.425233] psmouse serio3: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
> [   20.482937] input: TPPS/2 IBM TrackPoint as /devices/rmi4-00/rmi4-00.fn03/serio3/input/input21
> -- 
> Calvin Walton <calvin.walton@kepstin.ca>
