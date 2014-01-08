From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH] input: synaptics-rmi4 - cleanup rmi_i2c_probe()
Date: Wed, 8 Jan 2014 15:04:34 -0800
Message-ID: <52CDD982.1010708@synaptics.com>
References: <1389219092-32042-1-git-send-email-cheiny@synaptics.com> <20140108224625.GB27279@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:8053 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbaAHXEi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jan 2014 18:04:38 -0500
In-Reply-To: <20140108224625.GB27279@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 01/08/2014 02:46 PM, Dmitry Torokhov wrote:
> On Wed, Jan 08, 2014 at 02:11:32PM -0800, Christopher Heiny wrote:
>> Moves i2c_check_functionality to occur before the gpio_config() call.  This
>> can catch some issues that would otherwise result in mysterious problems
>> in gpio_config().
>>
>> Reduces debugging output; updates remaining output to be more accurate.
>
> What kind of gpio config is there? Did not we add proper configuration
> of attn_gpio to the core? Do you really need these callbacks? They will
> hurt you when you will try to move to devicetree-based setups.

This is a gpio_config() does the platform specific gpio setup (power 
configuration, voltage levels, hardware reset lines, and so on).  This 
is used on every production platform using the driver that I know of, 
and the setup is different on every platform (sometimes even between 
revs of that platform).  We'd go crazy trying to handle that in 
rmi_i2c.c or rmi_driver.c, so it's pushed to the platform.

And yeah, I figure it'll hurt when we move to devicetree.  Right now 
we're just trying to get the current state of the code in the 
synaptics-rmi4 branch from "horribly broken" to "it lives!".  We're 
willing to put off that devicetree pain in order to get the code on its 
feet.
