From: Jamie Lentin <jamie@lentin.co.uk>
Subject: Re: [REPOST] [PATCH] Add support for OQO 01+ multimedia keys (fwd)
Date: Tue, 20 Oct 2009 21:12:38 +0100 (BST)
Message-ID: <alpine.DEB.2.00.0910202110360.11516@bunsen.wrottesley.wormnet.eu>
References: <alpine.DEB.1.10.0906302300290.9420@woodchuck.wormnet.eu> <20091020013859.GD24370@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from chipmunk.wormnet.eu ([195.195.131.226]:36534 "EHLO
	chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZJTUWB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Oct 2009 16:22:01 -0400
In-Reply-To: <20091020013859.GD24370@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 19 Oct 2009, Dmitry Torokhov wrote:

> On Tue, Jun 30, 2009 at 11:06:49PM +0100, Jamie Lentin wrote:
>> Apologies for reposting, but it'd be nice to get something along these
>> lines merged.  If there's suggestions of other things I could try, or
>> you'd prefer a patch to make the "up" and "down" keycodes auto-release,
>> please let me know.
>>
>
> I am sorry, I completely missed your patch and just now was going
> through my inbox and saw it...

Not to worry---so long as the patch wasn't so offensive you couldn't bring
yourself to reply :)

> Could you please tell me if OQO has external PS/2 port?

No, it has a PS/2 trackpoint and gravity mouse (easter-egg mode where the
firmware turns accelerometer input into mouse) built-in, but I doubt
they'll provide much useful info.

> And also if you could give me the raw data stream from these keys
> (reported with i8042.debug) that would be grand.

Using a vanilla linux-2.6.31.1, this is the output from both i8042.debug
and evtest when holding keys momentarily.  NB: I've applied a map to
change the "multimedia" keycodes to be something useful, but that's
probably not relevant.  Every other key works as you'd expect.

# Video -- down/up separate keys
drivers/input/serio/i8042.c: 66 <- i8042 (interrupt, 0, 1) [85408]
drivers/input/serio/i8042.c: 66 <- i8042 (interrupt, 0, 1) [85478]
drivers/input/serio/i8042.c: 66 <- i8042 (interrupt, 0, 1) [85487]
drivers/input/serio/i8042.c: 66 <- i8042 (interrupt, 0, 1) [85496]
drivers/input/serio/i8042.c: 66 <- i8042 (interrupt, 0, 1) [85505]
drivers/input/serio/i8042.c: 66 <- i8042 (interrupt, 0, 1) [85513]
drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, 0, 1) [85518]
drivers/input/serio/i8042.c: 66 <- i8042 (interrupt, 0, 1) [85518]
Event: time 1256067968.926933, type 4 (Misc), code 4 (ScanCode), value 66
Event: time 1256067968.927715, type 1 (Key), code 227 (?), value 2
Event: time 1256067968.927848, -------------- Report Sync ------------
Event: time 1256067969.110362, type 4 (Misc), code 4 (ScanCode), value e6
Event: time 1256067969.110613, type 1 (Key), code 360 (Vendor), value 2
Event: time 1256067969.110704, -------------- Report Sync ------------

# Mute -- down/up separate keys
drivers/input/serio/i8042.c: 65 <- i8042 (interrupt, 0, 1) [94782]
drivers/input/serio/i8042.c: 65 <- i8042 (interrupt, 0, 1) [94852]
drivers/input/serio/i8042.c: 65 <- i8042 (interrupt, 0, 1) [94861]
drivers/input/serio/i8042.c: 65 <- i8042 (interrupt, 0, 1) [94870]
drivers/input/serio/i8042.c: 65 <- i8042 (interrupt, 0, 1) [94878]
drivers/input/serio/i8042.c: 65 <- i8042 (interrupt, 0, 1) [94887]
drivers/input/serio/i8042.c: 65 <- i8042 (interrupt, 0, 1) [94896]
drivers/input/serio/i8042.c: 65 <- i8042 (interrupt, 0, 1) [94907]
drivers/input/serio/i8042.c: 65 <- i8042 (interrupt, 0, 1) [94916]
drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, 0, 1) [94920]
drivers/input/serio/i8042.c: 65 <- i8042 (interrupt, 0, 1) [94920]
Event: time 1256068003.897484, type 4 (Misc), code 4 (ScanCode), value 65
Event: time 1256068003.897784, type 1 (Key), code 113 (Mute), value 2
Event: time 1256068003.897877, -------------- Report Sync ------------
Event: time 1256068003.906448, type 4 (Misc), code 4 (ScanCode), value e5
Event: time 1256068003.906745, type 1 (Key), code 360 (Vendor), value 2
Event: time 1256068003.906860, -------------- Report Sync ------------

# WiFi -- down/up separate keys
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 0, 1) [100145]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 0, 1) [100215]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 0, 1) [100223]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 0, 1) [100232]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 0, 1) [100241]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 0, 1) [100250]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 0, 1) [100258]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 0, 1) [100269]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 0, 1) [100278]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 0, 1) [100287]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 0, 1) [100296]
drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, 0, 1) [100304]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, 0, 1) [100304]
Event: time 1256068069.298454, type 4 (Misc), code 4 (ScanCode), value 64
Event: time 1256068069.298664, type 1 (Key), code 226 (Media), value 2
Event: time 1256068069.298756, -------------- Report Sync ------------
Event: time 1256068069.509059, type 4 (Misc), code 4 (ScanCode), value e4
Event: time 1256068069.509274, type 1 (Key), code 360 (Vendor), value 2
Event: time 1256068069.509370, -------------- Report Sync ------------

> Plus, who is the keyboard identified
> in dmesg? Is it "AT Translated Set 2" or 'AT Raw set 2"?

PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /devices/platform/pcspkr/input/input0
input: AT Translated Set 2 keyboard as 
/devices/platform/i8042/serio0/input/input1

[ An entire (albeit old) log here:
http://jamie.lentin.co.uk/hardware/oqo_01plus/dmesg.txt ]

I did try forcing the keyboard into raw set 2 and set 3, however it seemed
to ignore the command---keypresses were still sent as translated set 2,
and Linux couldn't interpret the keypresses anymore since it was
expecting raw.  I've lost the notes on how I did this and the resulting 
dumps, but can try again if it's interesting.

>
> Thanks!
>
