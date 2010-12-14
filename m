From: Jiri Kosina <jkosina@suse.cz>
Subject: Synaptics touchpad on Dell Vostro V13
Date: Tue, 14 Dec 2010 15:56:56 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012141547570.15140@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

I have a bugreport about Synaptics touchpad not working as proper 
Synaptics, but only being detected as standard PS/2.

Looking at the i8042.debug output, the device is clearly buggy, as it 
doesn't identify itself by 0x47 when queried:

	91 -> i8042 (command) [58]
	e8 -> i8042 (parameter) [58]
	fa <- i8042 (interrupt, 3, 12) [59]
	91 -> i8042 (command) [59]
	00 -> i8042 (parameter) [59]
	fa <- i8042 (interrupt, 3, 12) [59]
	91 -> i8042 (command) [59]
	e8 -> i8042 (parameter) [59]
	fa <- i8042 (interrupt, 3, 12) [60]
	91 -> i8042 (command) [60]
	00 -> i8042 (parameter) [60]
	fa <- i8042 (interrupt, 3, 12) [61]
	91 -> i8042 (command) [61]
	e8 -> i8042 (parameter) [61]
	fa <- i8042 (interrupt, 3, 12) [61]
	91 -> i8042 (command) [61]
	00 -> i8042 (parameter) [61]
	fa <- i8042 (interrupt, 3, 12) [62]
	91 -> i8042 (command) [62]
	e8 -> i8042 (parameter) [62]
	fa <- i8042 (interrupt, 3, 12) [63]
	91 -> i8042 (command) [63]
	00 -> i8042 (parameter) [63]
	fa <- i8042 (interrupt, 3, 12) [64]
	91 -> i8042 (command) [64]
	e9 -> i8042 (parameter) [64]
	fa <- i8042 (interrupt, 3, 12) [64]

... and here we time out after approximately 0.5s. nomux doesn't really 
fix it, we start getting a lot of timeouts on i8042 with that.

Apparently the device works with Synaptics driver in Other OS(TM) though. 
Do you have any idea what they might be doing differently so that they 
make the touchpad identify itself properly?

https://bugzilla.kernel.org/show_bug.cgi?id=15416 seems to be related BTW.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
