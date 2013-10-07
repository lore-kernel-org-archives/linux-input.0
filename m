From: simon@mungewell.org
Subject: Re: [PATCH] HID: logitech - lg2ff: Add IDs for Formula Vibration
 Feedback Wheel
Date: Mon, 7 Oct 2013 16:03:57 -0400
Message-ID: <fa1af5a9ba814114ddf5ee8fe65b8b4b.squirrel@www.mungewell.org>
References: <1381164492-27145-1-git-send-email-anssi.hannula@iki.fi>
    <cec1e0ca61cf17ceb6e52faa4f2baad9.squirrel@mungewell.org>
    <5252F5C7.3060700@iki.fi>
    <CADbOyBSry1eFsCycM-BaDEhaA7_+JUBpYZEqA4s5s-g2vq5whg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CADbOyBSry1eFsCycM-BaDEhaA7_+JUBpYZEqA4s5s-g2vq5whg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, simon@mungewell.org, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org, =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@prifuk.cz>
List-Id: linux-input@vger.kernel.org

> I don't really know what you need for the HID descriptors, but I thought
> maybe I should post usbmon output when plugging in the wheel:

I'm not sure I can do anything with that file. It would be great if you
could dump/attach the report descriptor file. This can be found in the
/sys folder structure under the USB ID for your device.

ie. for my Sony Dual Shock controller
--
simon@simon-virtual-machine:/sys/bus/usb/devices/1-1:1.0/0003:054C:0268.0001$
hexdump -C report_descriptor
00000000  05 01 09 04 a1 01 a1 02  85 01 75 08 95 01 15 00 
|..........u.....|
00000010  26 ff 00 81 03 75 01 95  13 15 00 25 01 35 00 45 
|&....u.....%.5.E|
00000020  01 05 09 19 01 29 13 81  02 75 01 95 0d 06 00 ff 
|.....)...u......|
00000030  81 03 15 00 26 ff 00 05  01 09 01 a1 00 75 08 95 
|....&........u..|
00000040  04 35 00 46 ff 00 09 30  09 31 09 32 09 35 81 02 
|.5.F...0.1.2.5..|
00000050  c0 05 01 95 13 09 01 81  02 95 0c 81 01 75 10 95 
|.............u..|
00000060  04 26 ff 03 46 ff 03 09  01 81 02 c0 a1 02 85 02 
|.&..F...........|
00000070  75 08 95 30 09 01 b1 02  c0 a1 02 85 ee 75 08 95 
|u..0.........u..|
00000080  30 09 01 b1 02 c0 a1 02  85 ef 75 08 95 30 09 01 
|0.........u..0..|
00000090  b1 02 c0 c0                                       |....|
00000094
--

To confirm which bits of the HID stream actually change when the pedals
are pushed you could run the command as root.
--
$ hexdump -v -e '17/1 "%02x " "\n"' < /dev/hidraw0
--

You'll have to change the '17' to match the actual number of bytes your
wheel sends, when you get it right the columns of values will change
'nicely' as you steer/depress the pedals/etc.

I'm expecting to see one column (or two adjacent if the bits don't align)
change as you press the brake/etc. If you can send a small capture showing
values changing for each of brake and accel that should be enough
information.

When we know where the data is, we can tell Linux's HID system which bits
to interpret as Y and Z axis.

Cheers,
Simon
