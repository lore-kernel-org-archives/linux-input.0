From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH v2] input: synaptics-rmi4 - use snprintf instead of sprintf
 in rmi_i2c.c
Date: Thu, 9 Jan 2014 13:38:00 -0800
Message-ID: <52CF16B8.7000409@synaptics.com>
References: <1389230319-4737-1-git-send-email-cheiny@synaptics.com> <20140109080454.GA27160@core.coreip.homeip.net> <52CF1359.6080207@synaptics.com> <20140109212949.GA31257@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:6318 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbaAIViB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 16:38:01 -0500
In-Reply-To: <20140109212949.GA31257@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 01/09/2014 01:29 PM, Dmitry Torokhov wrote:
> On Thu, Jan 09, 2014 at 01:23:37PM -0800, Christopher Heiny wrote:
>> >On 01/09/2014 12:04 AM, Dmitry Torokhov wrote:
>>> > >On Wed, Jan 08, 2014 at 05:18:39PM -0800, Christopher Heiny wrote:
>>>> > >>This is a trivial change to replace the sprintf loop with snprintf using
>>>> > >>up-to-date format capability.
>>> > >
>>> > >Hmm, how about we do this instead:
>>> > >
>>> > >Input: synaptics-rmi4 - clean up debug handling in rmi_i2c
>>> > >
>>> > >From: Dmitry Torokhov<dmitry.torokhov@gmail.com>
>>> > >
>>> > >Kernel now has standard facility to format and print binary buffers, let's
>>> > >use it. By doing so we no longer need to allocate memory for debug buffers
>>> > >and we can let debugfs code go as well.
>> >
>> >Not sure where to put this comment, so I'll drop it here.
>> >
>> >I agree the buffers can go.  I realized that on the drive home last
>> >night, but was too tired to follow up.
>> >
>> >Talking with some of the folks who use this feature, there's a
>> >desire to keep some sort of finer control on whether the comms
>> >buffers are printed or not - either the existing debugfs setup
>> >(preferred, since it lets them turn on the dmesg clutter only when
>> >needed), or by converting to a config option such as
>> >CONFIG_RMI4_COMMS_DEBUG.  It's very useful in new platform
>> >development, since there's a surprising number of ways in which the
>> >reads and writes can go wonky on new hardware.
 >
> That is why you have CONFIG_DYNAMIC_DEBUG: you can activate these debug
> statements at will using the common kernel mechanisms.

I'll check this out and get back.

>
> Or we could convert them to dev_vdbg() and then it will be just a tiny
> transport module recompile with DEBUG defined.


-- 

Christopher Heiny
Senior Staff Firmware Engineer
Synaptics Incorporated
