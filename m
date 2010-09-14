From: William Manson <WManson@synaptics.com>
Subject: RE: Synaptics i2c touchscreen driver
Date: Mon, 13 Sep 2010 18:06:40 -0700
Message-ID: <7B4B50AC280A5E45A42CD2D364A3CE2F3A6BE70F9C@USW-EX2K7-1.synaptics-inc.local>
References: <20100914005046.GA27540@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx4.synaptics.com ([12.178.49.178]:55366 "EHLO
	us-mx4.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab0INBHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 21:07:05 -0400
In-Reply-To: <20100914005046.GA27540@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: "'Arce, Abraham'" <x0066660@ti.com>, Greg KH <gregkh@suse.de>, Christopher Heiny <Cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dmitry -

Thanks - yes this will help very much.

Thanks,
William Manson


-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
Sent: Monday, September 13, 2010 5:51 PM
To: William Manson
Cc: 'Arce, Abraham'; Greg KH; Christopher Heiny; Allie Xiong; devel@driverdev.osuosl.org; linux-input@vger.kernel.org
Subject: Re: Synaptics i2c touchscreen driver

Hi William,

On Mon, Sep 13, 2010 at 05:26:15PM -0700, William Manson wrote:
> Hi Abraham -
>
> Yes - the TM1217 is an RMI4 based module [I just got an email from a
> f/w engineer confirming it is indeed RMI4].
>
> We are currently working on submitting a new patch for our RMI4 based
> driver to add some functionality based on Dmitry Torokhov's request
> that we implement an RMI bus architecture. This is kind of a large
> change and we had hoped our current submission for our RMI4 driver
> would be added to the Kernel.org under a branch where every developer
> could access it and then we could add in the RMI bus architecture in a
> later patch. So it will take a while till we can make a new patch but
> I have no problem if you want to try the existing patch out.

I have committed the latest version of the patch Christopher sent (sans
defconfig and gta01 platform changes that do not really belong there) to
synaptics-rmi4 branch of my tree on kernel.org. I branched it off 2.6.35
release so it should be reasonably usable.

I shall be accepting patches applicable to that branch and if other
community players (Arce and others) will have time to work on the driver
- that would be great.

Hope this helps.

--
Dmitry
