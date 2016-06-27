From: Yu Chen <yu.chen.surf@gmail.com>
Subject: [RFC] Can we bypass the timeout when resetting Synaptics device?
Date: Mon, 27 Jun 2016 21:04:58 +0800
Message-ID: <CADjb_WTNJJpmpNCOGxdUOd1AZ8S7iEf2NnSHC=VC6TzAOTbP_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.com>, Dmitry Vyukov <dvyukov@google.com>
List-Id: linux-input@vger.kernel.org

Hi All,
Currently I'm doing some tunings on the speed of suspend/resume,
it looks like my serio driver tooks a 200ms to finish, which is
too long:

[ 1120.255783] calling  serio0+ @ 2764, parent: i8042
[ 1120.452976] call serio0+ returned 0 after 192472 usecs

So further investigation shows that the time cost is in
drivers/input/serio/libps2.c: __ps2_command

        /*
         * Some devices (Synaptics) peform the reset before
         * ACKing the reset command, and so it can take a long
         * time before the ACK arrives.
         */
        if (ps2_sendbyte(ps2dev, command & 0xff,
                         command == PS2_CMD_RESET_BAT ? 1000 : 200)) {
                serio_pause_rx(ps2dev->serio);
                goto out_reset_flags;
        }
If I understand correctly, if it is a Synaptics device, then we have to wait
at least 200ms for ATKBD_CMD_RESET_DEF, although this device has already
been reset.

So my question is, could we add flags to distinguish Synaptics device, and
if it is a Synaptics device, just do not wait that long time and
return after the command
has been sent out?


thanks,
Yu
