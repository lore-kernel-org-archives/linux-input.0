From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: xps 15 9560 touchpad high interrupts
Date: Sun, 31 Dec 2017 08:25:21 +0200
Message-ID: <20171231062520.qlcijf32eoqhdksf@sapphire.tkos.co.il>
References: <CAEOHGO=GYr4NCnwNXf=it6WFVRQ0d-eYTVKoZSiuhYhumnBK5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:59170 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbdLaGZ0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 31 Dec 2017 01:25:26 -0500
Content-Disposition: inline
In-Reply-To: <CAEOHGO=GYr4NCnwNXf=it6WFVRQ0d-eYTVKoZSiuhYhumnBK5A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javad Karabi <karabijavad@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Javad Karabi,

Added linux-input list to Cc.

On Sat, Dec 30, 2017 at 05:10:06PM -0600, Javad Karabi wrote:
> im trying to figure out why i get like 7000 interrupts a second simply by
> resting my finger on the touchpad (not even moving it)
> this is on a xps 15 9560
> and the touchpad is at
> DLL07BE:01 06CB:7A13 Touchpad as
> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-7/i2c-DLL07BE:01/0018:06CB:7A13.0009/input/input58
> 
> could you provide me with any advice as to where i should look to figure
> this out?
> i have already tried adding code to i2c-designware-platdrv.c
> i added
> dev->clk_freq = 100000;
> in dw_i2c_plat_probe, but it still shoots off thousands of interrupts a
> second (and they are apparently spurious interrupts, atleast accoding
> to /proc/irq/17/spurious
> 
> could you provide any guidance at all? would be much appreciated.. i would
> love to fix this issue and get it upstreamed in the kernel if possible.
> thank you

i2c_designware is a I2C bus master driver. It allows the host to communicate 
with various devices. Your touchpad is apparently one such device. But each 
device on the I2C bus needs its own driver. I have no idea which driver 
handles your touchpad device. Maybe someone on the linux-input list knows.

Specifically, the interrupts handling has nothing to do with the I2C bus. 
Unlike PCIe, I2C provides no in-bus interrupt delivery facility. I2C devices 
usually use a separate dedicated interrupt line. So the spurious interrupts 
that you see must be handled at the touchpad input driver level.

One thing that might help others help you is the version of the kernel you are 
running. Please provide the output of 'uname -rv' on your machine.

Hope this helps,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
