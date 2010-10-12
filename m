From: William Manson <WManson@synaptics.com>
Subject: RE: input: Synaptics touchscreen driver followup
Date: Tue, 12 Oct 2010 11:35:44 -0700
Message-ID: <7B4B50AC280A5E45A42CD2D364A3CE2F4D10E1F5EB@USW-EX2K7-1.synaptics-inc.local>
References: <27F9C60D11D683428E133F85D2BB4A530468370A42@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx4.synaptics.com ([12.178.49.178]:52284 "EHLO
	us-mx4.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab0JLSfw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 14:35:52 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A530468370A42@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "'Arce, Abraham'" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@mail.ru>
Cc: Allie Xiong <axiong@synaptics.com>, Christopher Heiny <Cheiny@synaptics.com>, Jean Delvare <khali@linux-fr.org>

Hi Abraham -

You mentioned you are using the OMap kernel. Is that the 2.6.29 for the Omap2/3 or the 2.6.32 for the Omap4? The reason I ask is that this code probably won't compile on versions of the kernel earlier than 2.6.31 due to architectural changes that were done to i2c.

Thanks,
William Manson
Synaptics, Inc.


-----Original Message-----
From: Arce, Abraham [mailto:x0066660@ti.com]
Sent: Tuesday, October 12, 2010 12:07 AM
To: linux-input@vger.kernel.org; Dmitry Torokhov
Cc: William Manson; Allie Xiong; Christopher Heiny; Jean Delvare
Subject: input: Synaptics touchscreen driver followup

Hi,

This is a follow up on
 http://www.spinics.net/lists/linux-input/msg11163.html

I have started to work with synaptics-rmi4 branch using sdp4430 board with 2 TM1217 controllers. I am right now using linux-omap-2.6 kernel

After some modifications and board configuration changes I was able to register all rmi layers however I am still facing some issues, will continue debugging

- Compilation error when built as modules
- Interrupts not being generated but registered
- In polling mode, kernel crash when ts_work_func is executed

If anyone has made some other progress I'll be glad to test changes...

Dmitry,

I have 2 questions,

1. Is it ok to send patches for cleanup or do you prefer functional ones? There are some checkpatch warnings still around

2. Could you please explain more about bus implementation? I have read Documentation/driver-model/bus.txt and wrote some initial code to register rmi as a bus, giving

# ls /sys/bus/rmi/drivers/
# ls /sys/bus/rmi/devices/

>From this point, I am confused on where bus will be in the picture shared by Synaptics team, shown below...

- Does it mean RMI4 Driver will be RMI4 bus and we will keep same application on top of it?

- What about i2c and spi layers? They will be drivers for rmi bus?

- What will be a device for rmi bus? The application?

  +----------------------------------------+
  |               Application              |
  +----------------------------------------+
  |                RMI4 Driver             | Data Layer
  |                (this file)             |
  +-----+-----+-------+----------+---------+
  | I2C | SPI | SMBus |         etc.       | Physical Layer
  +-----+-----+-------+----------+---------+

Thanks for the guidance!

Best Regards
Abraham
