From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [RFC PATCH 00/11] input: Synaptics RMI4 Touchscreen Driver
Date: Mon, 27 Aug 2012 16:20:37 -0700
Message-ID: <503C00C5.60602@synaptics.com>
References: <1345241877-16200-1-git-send-email-cheiny@synaptics.com> <CACRpkda6Aq_rmYjMx6fcYvPnEexZ47dhaiA3hsCozLyUT0Mikw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx3.synaptics.com ([12.239.217.85]:30760 "EHLO
	us-mx3.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998Ab2H0XUj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Aug 2012 19:20:39 -0400
In-Reply-To: <CACRpkda6Aq_rmYjMx6fcYvPnEexZ47dhaiA3hsCozLyUT0Mikw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>, Peichen Chang <peichen.chang@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On 08/22/2012 05:50 AM, Linus Walleij wrote:
> On Sat, Aug 18, 2012 at 12:17 AM, Christopher Heiny
> <cheiny@synaptics.com>  wrote:
>
>> >This patch implements a driver supporting Synaptics ClearPad and other
>> >touchscreen sensors that use the RMI4 protocol, as defined here:
> Nice!
>
>> >This patch is against the v2.6.38 tag of Linus' kernel tree, commit
>> >521cb40b0c44418a4fd36dc633f575813d59a43d.  This will be our last patch against
>> >such an old kernel version, future patches will be against 3.x kernels.
> Please use the head of the subsystem tree to do this work.
> In this case, use Dmitry's git.
>
> Currently I just cannot test this because we have no such old codebase
> around.
>
> But I will attempt to review the patch set!

Thanks for all the feedback so far - it has been quite valuable.  I'm 
not going to try to respond to every comment, especially since most of 
it will be of a "Yeah - good idea" nature.

A couple of general things:


The "phys" debugfs interface is intended to tell you about the physical 
interface a particular RMI4 sensor is using (either SPI or I2C or 
whatever), including the name of the interface, the number of 
reads/writes done, number of bytes that have been read/written, number 
of errors, and so on.

We chose to to call name it phys so that the debug tools would be able 
to find this interface no matter what the physical connection was, even 
when new physical layer support (for example, SMbus) is introduced.



EARLY_SUSPEND/LATE_RESUME and other power management stuff.  We're 
caught in a bind here.  Most of our customers are using some flavor of 
Android.  They have the expectation that our driver will (a) support the 
Android power management model, and (b) be contributed into the mainline 
kernel without change.  Yes, I know these are contradictory 
requirements, given that Android specific features are not in the mainline.

With the upcoming rebase of the code to more modern kernels, we'll be 
able to eliminate a bunch of those dependencies.  But the only way to 
eliminate them entirely would be to maintain mainline and Android 
versions of the driver, which would drain resources from developing core 
features and fixing bugs.  So for now we've got a single code base. 
When we finally submit a patch and the only response is "everything is 
fine but that Android stuff", we'll probably change that policy within 
48 hours (to include time needed for celebration and subsequent hangover 
recovery :-) ).

					Cheers,
						Chris
