From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH 2/3] Input: synaptics-rmi4 - ability disable abs or rel
 reporting
Date: Fri, 21 Mar 2014 15:32:50 -0700
Message-ID: <532CBE12.80702@synaptics.com>
References: <1395191031-3144-1-git-send-email-cheiny@synaptics.com> <1395191031-3144-2-git-send-email-cheiny@synaptics.com> <5329B17C.8080202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [192.147.44.131] ([192.147.44.131]:33574 "EHLO
	us-mx2.synaptics.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaCUWd0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Mar 2014 18:33:26 -0400
In-Reply-To: <5329B17C.8080202@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On 03/19/2014 08:02 AM, Benjamin Tissoires wrote:
>
>
> On 03/18/2014 09:03 PM, Christopher Heiny wrote:
>> Even if the RMI4 touchscreen/touchpad provides reporting both
>> relative and absolute coordinates, reporting both to userspace
>> could be confusing. Allow the platform data to disable either
>> absolute or relative coordinates.
>
> General comments on the patch:
> Is there really a need to export the rel axis when there is already an
> abs collection?
> I mean, with the RMI4 over HID over I2C found on the XPS Haswell series,
> RMI4 will be bound automatically, and the sensor may (will) pretend that
> it can do both abs and rel. However, we are not using a platform_data
> for them (I think we should not), and we will get the two collections.
>
> I would personally be in favor of having a priority mechanism: if abs is
> here, skip rel, otherwise use rel. But I have no clue if you will ship
> devices which will require both. So you make the call.
>

Hi Benjamin,

That's a great idea.  I'm a tad embarrassed we didn't think of that 
approach.

We do ship products with both abs and rel enabled.  We'll implement the 
abs-priority approach, but also keep the platform data (or device tree, 
once that's implemented) top optionally disable abs reporting, because 
it's very handy to have during new system bring up and certain 
prototyping use cases.

As before, I'll let Andrew handle the code specific comments.

					Cheers,
						Chris

[snip]
