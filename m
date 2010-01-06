From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/2] Input: Add device_enable handler to DaVinci Keyscan platform data
Date: Wed, 06 Jan 2010 09:04:23 -0800
Message-ID: <87ocl7jhbc.fsf@deeprootsystems.com>
References: <1258141434-18351-1-git-send-email-miguel.aguilar@ridgerun.com>
	<87hbs25n38.fsf@deeprootsystems.com>
	<20091208004832.GA9495@core.coreip.homeip.net>
	<877hsy46o0.fsf@deeprootsystems.com>
	<87aawsozgo.fsf@deeprootsystems.com>
	<20100106082638.GA2176@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:52624 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755966Ab0AFRE2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jan 2010 12:04:28 -0500
Received: by ywh6 with SMTP id 6so17596298ywh.4
        for <linux-input@vger.kernel.org>; Wed, 06 Jan 2010 09:04:27 -0800 (PST)
In-Reply-To: <20100106082638.GA2176@core.coreip.homeip.net> (Dmitry Torokhov's message of "Wed\, 6 Jan 2010 00\:26\:38 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: miguel.aguilar@ridgerun.com, davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com, clark.becker@ridgerun.com

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Tue, Jan 05, 2010 at 04:21:11PM -0800, Kevin Hilman wrote:
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>> 
>> > Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>> >
>> >> On Mon, Dec 07, 2009 at 04:24:59PM -0800, Kevin Hilman wrote:
>> >>> <miguel.aguilar@ridgerun.com> writes:
>> >>> 
>> >>> > From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>> >>> >
>> >>> > Add a function pointer in the platform data of the DaVinci Keyscan driver
>> >>> > called device_enabled, in order to perform board specific actions when
>> >>> > the device is initialized, like setup the PINMUX configuration.
>> >>> >
>> >>> > Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>> >>> 
>> >>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> >>> 
>> >>> Dmitry,
>> >>> 
>> >>> Will you be queueing this driver (and this patch) for 2.6.34?  I
>> >>> thought you had accepted the original driver, but I don't see it in
>> >>> the master or next branch of your input tree at:
>> >>> 
>> >>>   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
>> >>
>> >> The driver is there, commit bc09dcadc1a3da87d58aa70ebc8e9441205be75c on
>> >> 'next' branch (I don't really use master branch).  It was committed back
>> >> in October, probably that's why you don't see it?
>> >>
>> >> As far as the patch goes - I got an impression from email sent by
>> >> Steve that there are ways to do automatic PINMUX detection and thus
>> >> this patch was not needed.  Is this ture?
>> >
>> > The method Steve was referring to was done for MontaVista
>> > internal/product kernels but was rejected for upstream (by me) because
>> > of the way it was implemented (by tying mux settings to clock
>> > settings.)
>> >
>> >> If not I am stull unsure what happens if you unload the driver. How
>> >> do you restore the old configuration so that the device you took
>> >> over from can start working again? Maybe pinmux should be controlled
>> >> via sysfs attribute (in board code) so that user can switch on-fly
>> >> between the devices?
>> >
>> > The way we currently handle MUXing in davinci, you don't need to do
>> > anything after the driver unloads.  Any other user of these pins will
>> > mux them as needed.
>> >
>> > If really necessary, we could do an equivalent 'device_disable' hook
>> > but there would be empty as it wouldn't be needed.
>> >
>> > So, speaking as maintainer of the DaVinci support, I'm in favor of this
>> > approach from Miguel.
>> 
>> Dmitry,
>> 
>> Unless there are further objectsions, could you please queue this
>> patch for 2.6.34 with my signoff?
>> 
>
> Applied to for-linus, I do not see any reason in holding this patch
> till .34. Sorry for the delay.
>

Excellent.  Thanks.

I'll submit the platform specific code for -rc4 as well.

Kevin
