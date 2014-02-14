From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 03/11] Input: synaptics-rmi4 - do not update configuration
 in rmi_f01_probe()
Date: Fri, 14 Feb 2014 15:00:43 -0800
Message-ID: <52FEA01B.7040604@synaptics.com>
References: <1392269277-16391-1-git-send-email-dmitry.torokhov@gmail.com> <1392269277-16391-3-git-send-email-dmitry.torokhov@gmail.com> <52FD1BC0.1050009@synaptics.com> <20140213215432.GA6225@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:49995 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbaBNXAp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Feb 2014 18:00:45 -0500
In-Reply-To: <20140213215432.GA6225@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Courtney Cavin <courtney.cavin@sonymobile.com>, Linux Input <linux-input@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On 02/13/2014 01:54 PM, Dmitry Torokhov wrote:
> On Thu, Feb 13, 2014 at 11:23:44AM -0800, Christopher Heiny wrote:
>> >On 02/12/2014 09:27 PM, Dmitry Torokhov wrote:
>>> > >Do not write configuration data in probe(), we have config() for that.
>> >
>> >Then we should call config() in rmi_function_probe() to ensure that
>> >any platform data or device tree configuration settings get written
>> >to the device.
 >
> Well, yes, we may elect to update device configuration in probe, but
> then we should not be doing that 2nd time in ->config(). We shoudl pick
> either one or another.

But as the code currently stands, config() is only called when a device 
reset is detected, not during initialization.  So if there's platform 
specific configuration data that needs to be written to a function, it 
won't get written until after a device reset occurs, which might never 
happen.  So either we need to write that data (or call config()) in each 
function's probe(), or in rmi_function_probe().
