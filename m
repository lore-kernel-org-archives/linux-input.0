From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Can we bypass the timeout when resetting Synaptics device?
Date: Mon, 27 Jun 2016 10:05:44 -0700
Message-ID: <20160627170544.GA22620@dtor-ws>
References: <CADjb_WTNJJpmpNCOGxdUOd1AZ8S7iEf2NnSHC=VC6TzAOTbP_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADjb_WTNJJpmpNCOGxdUOd1AZ8S7iEf2NnSHC=VC6TzAOTbP_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Chen <yu.chen.surf@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.com>, Dmitry Vyukov <dvyukov@google.com>
List-Id: linux-input@vger.kernel.org

Hi Yu,

On Mon, Jun 27, 2016 at 09:04:58PM +0800, Yu Chen wrote:
> Hi All,
> Currently I'm doing some tunings on the speed of suspend/resume,
> it looks like my serio driver tooks a 200ms to finish, which is
> too long:

Well, PS/2 is not fast, that is why we do not actually do any IO in
resume handler, but rather schedule work to execute actions in a
separate thread. You probably need to instrument the call to
serio_queue_event() in serio_resume() and see what took so long.

Also, IIRC, there might be some issue when serio_reconnect_driver()
fails and serio_reconnect_port() forcibly unbinds driver and rescans the
device for new drivers. If this happens in the middle of PM transition
there might be some contention on PM locks.

> 
> [ 1120.255783] calling  serio0+ @ 2764, parent: i8042
> [ 1120.452976] call serio0+ returned 0 after 192472 usecs
> 
> So further investigation shows that the time cost is in
> drivers/input/serio/libps2.c: __ps2_command
> 
>         /*
>          * Some devices (Synaptics) peform the reset before
>          * ACKing the reset command, and so it can take a long
>          * time before the ACK arrives.
>          */
>         if (ps2_sendbyte(ps2dev, command & 0xff,
>                          command == PS2_CMD_RESET_BAT ? 1000 : 200)) {
>                 serio_pause_rx(ps2dev->serio);
>                 goto out_reset_flags;
>         }
> If I understand correctly, if it is a Synaptics device, then we have to wait
> at least 200ms for ATKBD_CMD_RESET_DEF, although this device has already
> been reset.

No, you are misreading the code. If the command is PS2_CMD_RESET_BAT
then we will be waiting for up to 1 sec for the reste to complete,
because Synaptics touchpads may take that long to re-calibrate after
reset. All other commands have timeout of 200 msec, but that does not
mean that we wait that long - we'll continue if device responds faster.

> 
> So my question is, could we add flags to distinguish Synaptics device, and
> if it is a Synaptics device, just do not wait that long time and
> return after the command
> has been sent out?

No, because that's not how protocol works.

Thanks.

-- 
Dmitry
