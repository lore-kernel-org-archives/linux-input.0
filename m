From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] Input: rotary_encoder cleanup
Date: Wed, 8 Jul 2009 17:47:07 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901A689B9@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909019683A5@mi8nycmail19.Mi8.com> <20090623162126.GL29236@buzzloop.caiaq.de> <20090630023211.GC10652@dtor-d630.eng.vmware.com> <BD79186B4FD85F4B8E60E381CAEE190901A1346C@mi8nycmail19.Mi8.com> <20090701183347.GB9464@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901A13867@mi8nycmail19.Mi8.com> <20090708065650.GG3309@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6ob113.obsmtp.com ([64.18.1.30]:52343 "HELO psmtp.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754393AbZGHVrL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2009 17:47:11 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20090708065650.GG3309@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org

On Tuesday, July 07, 2009 11:57 PM, Dmitry Torokhov wrote:
> On Wed, Jul 01, 2009 at 02:45:58PM -0400, H Hartley Sweeten wrote:
>> On Wednesday, July 01, 2009 11:34 AM, Daniel Mack wrote:
>>> On Tue, Jun 30, 2009 at 11:56:36AM -0400, H Hartley Sweeten wrote:
>>>> On Monday, June 29, 2009 7:32 PM, Dmitry Torokhov wrote:
>>>>> Do we know how many encoders we need to have in the system to start
>>>>> seeing the benefits (given that all these conversions increase text
>>>>> size)?
>>>> 
>>>> Hmm.. Didn't think about that. How do you determine the text size?
>>> 
>>> 'objdump -h'?
>> 
>> Thanks.
>> 
>>>> I am trying to work out a clean way to pass an array of encoders
>>>> from the platform init file so that multiple devices can be handled
>>>> by the driver.  That was what prompted the change.
>>> 
>>> Hmm, and then report them all via the very same input device? Or
>>> register one for each encoder? The latter could easily be done by
>>> registering multiple platform_devices with different platform_data,
>>> right?
>> 
>> I suppose each encoder could be registered individually.  Then each
>> would report as a unique input device.  This should work with the
>> driver as it is now.  Then drawback is if there are a number of
>> encoders and a userspace app is opening all of them and doing a
>> EVIOCGRAB it makes the app a bit messy.
>> 
>> I was thinking more or passing an array of encoders to the driver and
>> then having it report all of them as one input device.  That ends up
>> being a lot cleaner.
>>
>
> Hmm, what axis will they be reporting though? Seems like very
> specialized [ab]use if they all share the same input device...

Each encoder reports as a unique axis.  They just all share one input
device.

If two encoders are reporting on the same axis they would have to be
on different input devices.

I was hoping to pass something like this to the rotary_encoder driver
from my platform init:

static struct rotary_encoder_platform_data my_rotary_encoder_info[] = {
	{
		.gpio_a		= GPIO_ROTARY1_A,
		.gpio_b		= GPIO_ROTARY1_B,
		.axis			= REL_X,
		.relative_axis	= true,
	}, {
		.gpio_a		= GPIO_ROTARY2_A,
		.gpio_b		= GPIO_ROTARY2_B,
		.axis			= REL_Y,
		.relative_axis	= true,	
	}, {
		.gpio_a		= GPIO_ROTARY3_A,
		.gpio_b		= GPIO_ROTARY3_B,
		.axis			= REL_Z,
		.relative_axis	= true,	
	}, {
		.gpio_a		= GPIO_ROTARY4_A,
		.gpio_b		= GPIO_ROTARY4_B,
		.axis			= ABS_THROTTLE,
		.steps		= 1024,
		.rollover		= false,
		.relative_axis	= false,
	},
	( 0 }
};

static struct platform_device rotary_encoder_device = {
	.name		= "rotary-encoder",
	.id		= 0,
	.dev		= {
		.platform_data = my_rotary_encoder_info,
	},
};

The rotary_encoder_probe() function would then just loop thru the
plaform_data and OR in either BIT_MASK(EV_REL) or BIT_MASK(EV_ABS)
as appropriate and either set the input->relbit[0] or call
input_set_abs_params() for the axis.

I just need to figure out a way to pass the correct cookie to the
irq function so that the right axis is processed.

Does this sound resonable?

Regards,
Hartley

