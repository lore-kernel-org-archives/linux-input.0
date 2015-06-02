From: Bogdan George Stefan <bogdan.george.stefan@gmail.com>
Subject: Re: [PATCH v2] Input: Add generic driver for Zeitec touchscreens
Date: Tue, 2 Jun 2015 10:43:01 +0300
Message-ID: <CAEm+DGVPNqWQOP_Tu4ae=pua6N5nC0Q+TkUCDB8tKzaX43iYNw@mail.gmail.com>
References: <1432815722-31120-1-git-send-email-bogdan.g.stefan@intel.com>
	<20150530001414.GD7429@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150530001414.GD7429@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bogdan George Stefan <bogdan.g.stefan@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Purdila Octavian <octavian.purdila@intel.com>
List-Id: linux-input@vger.kernel.org

Dimitry,

I know 0xB2 should provide that information according to the
datasheet, however here is what Zeitec guys had to say when I asked
them why it does not work:

"0xB2 is deprecated.
It only supports in Zet6221/31 serious but zet9172/zet6273."

If you like, I can attach my conversation with them.

Thank you,
Bogdan

On Sat, May 30, 2015 at 3:14 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Bogdan,
>
> On Thu, May 28, 2015 at 03:22:02PM +0300, Bogdan George Stefan wrote:
>> This driver adds support for Zeitec touchscreens. It has
>> been tested with ZET6273 and ZET9172.
>>
>> It supports ACPI and device tree enumeration. For ACPI you need ACPI
>> 5.1+ in order to be able to use named GPIOs.
>>
>> Screen resolution, the maximum number of fingers supported,
>> if the touchscreen has hardware keys are configurable
>> using ACPI/DT properties.
>>
>> Signed-off-by: Bogdan George Stefan <bogdan.g.stefan@intel.com>
>> ---
>> Changes since v1:
>>
>> Implemented most changes following Dmitry Torokhov's recommendations
>> from https://lkml.org/lkml/2015/5/15/319
>> The only things I kept are described below in the Notes section.
>> - fixed style issues
>> - reset is activated when gpio is set to high
>> - switched from i2c_transfer to i2c_master_recv/i2c_master_send
>> - removed redundant evbit initialization. However EV_ABS still needs
>> to be reported and it is set through input_set_capability
>> - replaced usleep_range with msleep where neede. Checking the patch
>> with -strict will report an issue on this. Hope this is not a problem
>> - fixed casts in zet_process_events
>> - removed  client->irq = gpiod_to_irq(ts->irq); from probe
>> - moved firmware loading from probe to open
>> - used proper casts in zet_suspend
>> - dropped zet_ts_remove as it was doing unnecesary things
>> Notes:
>> - I've kept the flags IRQF_TRIGGER_FALLING | IRQF_ONESHOT when calling
>> devm_request_threaded_irq. No the irq handler is not called whn only IRQF_ONESHOT
>> is used. Looking at other drivers, I saw that they use the same aproach. I am not
>> sure how to setup things in ACPI/DT so that the driver could work only with IRQF_ONESHOT
>
> Hmm, Rafael, do ACPI systems automatically set up IRQ triggers,
> similarly to what OF systems do (based on device tree data)?
>
>> - The number of thingers that can simultaneously touch the device and if it has
>> HW keys or not, cannot be read from the device. I've asked Zeitec on this.
>
> According to a random Zeitec datasheet I found on the web you send 0xB2
> command to the device to retrieve buch of information, including number
> of fingers and whether keys are supported.
>
> Thanks.
>
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
