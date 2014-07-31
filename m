From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH v2 05/06] input synaptics-rmi4: Add firmware update support
Date: Thu, 31 Jul 2014 14:00:14 -0700
Message-ID: <53DAAE5E.7030708@synaptics.com>
References: <1394675637-23853-1-git-send-email-cheiny@synaptics.com> <1394675637-23853-5-git-send-email-cheiny@synaptics.com> <20140731175323.GB5631@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:18837 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750836AbaGaVAQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2014 17:00:16 -0400
In-Reply-To: <20140731175323.GB5631@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On 07/31/2014 10:53 AM, Dmitry Torokhov wrote:
> Hi Christopher,
>
> On Wed, Mar 12, 2014 at 06:53:56PM -0700, Christopher Heiny wrote:
>> Add support for updating firmware on RMI4 devices with V5 bootloader.
>
> I am wondering why F34 is not following the staindard RMI function
> implementation. By that I mean that it does not declare itself as struct
> rmi_function_handler and does not rely on RMI core to bind itself to the device
> if device supports it.

Hi Dmitry,

We originally had an F34 implementation that followed the RMI4 function 
standard and exposed most of the basic F34 operations via sysfs. 
However, we got feedback (both on LKML and offline) (a) recommending to 
use request_firmware, and (b) improve reflash times while (c) reducing 
impact on boot time, and (d) "get rid of all that sysfs crap" 
(paraphrased, but close to it).

So after looking at how some other drivers use request_firmware, we came 
up with the current approach.  Switching to request_firmware definitely 
sped up the reflash times!  Including a check to see if firmware update 
is required before setting up the RMI4 sensor/function structures also 
significantly reduced boot times.

> By the way, isn't rmi_extract_u32() is the same as le32_to_cpup()?

Hmmm.  Looks like that one escaped the sweep of roll-your-own endian 
fixes.  I'll update it.

					Chris


