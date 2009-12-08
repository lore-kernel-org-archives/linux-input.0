From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/2] Input: Add device_enable handler to DaVinci Keyscan platform data
Date: Mon, 07 Dec 2009 17:05:03 -0800
Message-ID: <877hsy46o0.fsf@deeprootsystems.com>
References: <1258141434-18351-1-git-send-email-miguel.aguilar@ridgerun.com>
	<87hbs25n38.fsf@deeprootsystems.com>
	<20091208004832.GA9495@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:34814 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935733AbZLHBE7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Dec 2009 20:04:59 -0500
Received: by yxe17 with SMTP id 17so4488407yxe.33
        for <linux-input@vger.kernel.org>; Mon, 07 Dec 2009 17:05:05 -0800 (PST)
In-Reply-To: <20091208004832.GA9495@core.coreip.homeip.net> (Dmitry Torokhov's message of "Mon\, 7 Dec 2009 16\:48\:32 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: miguel.aguilar@ridgerun.com, davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com, clark.becker@ridgerun.com

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Mon, Dec 07, 2009 at 04:24:59PM -0800, Kevin Hilman wrote:
>> <miguel.aguilar@ridgerun.com> writes:
>> 
>> > From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>> >
>> > Add a function pointer in the platform data of the DaVinci Keyscan driver
>> > called device_enabled, in order to perform board specific actions when
>> > the device is initialized, like setup the PINMUX configuration.
>> >
>> > Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>> 
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> 
>> Dmitry,
>> 
>> Will you be queueing this driver (and this patch) for 2.6.34?  I
>> thought you had accepted the original driver, but I don't see it in
>> the master or next branch of your input tree at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
>
> The driver is there, commit bc09dcadc1a3da87d58aa70ebc8e9441205be75c on
> 'next' branch (I don't really use master branch).  It was committed back
> in October, probably that's why you don't see it?
>
> As far as the patch goes - I got an impression from email sent by
> Steve that there are ways to do automatic PINMUX detection and thus
> this patch was not needed.  Is this ture?

The method Steve was referring to was done for MontaVista
internal/product kernels but was rejected for upstream (by me) because
of the way it was implemented (by tying mux settings to clock
settings.)

> If not I am stull unsure what happens if you unload the driver. How
> do you restore the old configuration so that the device you took
> over from can start working again? Maybe pinmux should be controlled
> via sysfs attribute (in board code) so that user can switch on-fly
> between the devices?

The way we currently handle MUXing in davinci, you don't need to do
anything after the driver unloads.  Any other user of these pins will
mux them as needed.

If really necessary, we could do an equivalent 'device_disable' hook
but there would be empty as it wouldn't be needed.

So, speaking as maintainer of the DaVinci support, I'm in favor of this
approach from Miguel.

Thanks,


Kevin
