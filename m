From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [RESEND PATCH v7 1/6] mfd: cros_ec: Add MKBP event support
Date: Mon, 11 Apr 2016 13:45:47 +0200
Message-ID: <CAAObsKDc3pS32QWB47AhawmE7i2MiMXR_xzE7i+jjaQNBWP+BA@mail.gmail.com>
References: <1459842789-13852-1-git-send-email-tomeu.vizoso@collabora.com>
 <1459842789-13852-2-git-send-email-tomeu.vizoso@collabora.com> <20160407152947.GD3323@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33559 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbcDKLqJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Apr 2016 07:46:09 -0400
In-Reply-To: <20160407152947.GD3323@x1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Vic Yang <victoryang@google.com>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 7 April 2016 at 17:29, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 05 Apr 2016, Tomeu Vizoso wrote:
>
>> From: Vic Yang <victoryang@google.com>
>>
>> Newer revisions of the ChromeOS EC add more events besides the keyboard
>> ones. So handle interrupts in the MFD driver and let consumers register
>> for notifications for the events they might care.
>>
>> To keep backward compatibility, if the EC doesn't support MKBP event, we
>> fall back to the old MKBP key matrix host command.
>>
>> Signed-off-by: Vic Yang <victoryang@chromium.org>
>> [bleung: fixup some context changes going from v3.14 to v3.18]
>> Signed-off-by: Benson Leung <bleung@chromium.org>
>> [tomeu: adapted to changes in mainline (in power-supply and platform/chrome)]
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> I'm not interested in your BSP submission path.  As far as I'm
> concerned *this* is the first submission.  If these guys are happy
> with the patch, they can either choose to Ack or Review it.  Drop the
> blurb in the middle.

Ok.

>> Cc: Randall Spangler <rspangler@chromium.org>
>> Cc: Vincent Palatin <vpalatin@chromium.org>
>> ---
>>
>> Changes in v7: None
>> Changes in v6: None
>> Changes in v5: None
>> Changes in v4:
>> - Calculate correctly the size of the payloads in
>>   cros_ec_get_host_command_version_mask.
>>
>> Changes in v3:
>> - Remove duplicated prototype of cros_ec_get_host_event.
>>
>> Changes in v2:
>> - Allocate enough for the structs in cros_ec_get_host_command_version_mask,
>>   not their pointers.
>> - Allocate msg in the stack in get_next_event and
>>   get_keyboard_state_event, as suggested by Gwendal.
>>
>>  drivers/input/keyboard/cros_ec_keyb.c   | 135 ++++++++------------------------
>>  drivers/mfd/cros_ec.c                   |  57 +++++++++++++-
>>  drivers/platform/chrome/cros_ec_proto.c |  92 ++++++++++++++++++++++
>>  include/linux/mfd/cros_ec.h             |  34 ++++++++
>>  include/linux/mfd/cros_ec_commands.h    |  34 ++++++++
>
> What are the *build time* dependencies that warrant all of these
> changes happening in one patch?

We can split further the changes without breaking the builds, but
cros-ec functionality will be broken in between if both the mfd driver
and the input driver handle the same interrupt, which will hurt
bisectability.

>>  5 files changed, 245 insertions(+), 107 deletions(-)
>
> [...]
>
>> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
>> index 0eee63542038..fbe78b819fdd 100644
>> --- a/drivers/mfd/cros_ec.c
>> +++ b/drivers/mfd/cros_ec.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/module.h>
>>  #include <linux/mfd/core.h>
>>  #include <linux/mfd/cros_ec.h>
>> +#include <asm/unaligned.h>
>>
>>  #define CROS_EC_DEV_EC_INDEX 0
>>  #define CROS_EC_DEV_PD_INDEX 1
>> @@ -49,11 +50,28 @@ static const struct mfd_cell ec_pd_cell = {
>>       .pdata_size = sizeof(pd_p),
>>  };
>>
>> +static irqreturn_t ec_irq_thread(int irq, void *data)
>> +{
>> +     struct cros_ec_device *ec_dev = data;
>> +     int ret;
>> +
>> +     if (device_may_wakeup(ec_dev->dev))
>> +             pm_wakeup_event(ec_dev->dev, 0);
>> +
>> +     ret = cros_ec_get_next_event(ec_dev);
>> +     if (ret > 0)
>> +             blocking_notifier_call_chain(&ec_dev->event_notifier,
>> +                                          0, ec_dev);
>> +     return IRQ_HANDLED;
>> +}
>> +
>>  int cros_ec_register(struct cros_ec_device *ec_dev)
>>  {
>>       struct device *dev = ec_dev->dev;
>>       int err = 0;
>>
>> +     BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->event_notifier);
>> +
>>       ec_dev->max_request = sizeof(struct ec_params_hello);
>>       ec_dev->max_response = sizeof(struct ec_response_get_protocol_info);
>>       ec_dev->max_passthru = 0;
>> @@ -70,13 +88,24 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>
>>       cros_ec_query_all(ec_dev);
>>
>> +     if (ec_dev->irq) {
>> +             err = request_threaded_irq(ec_dev->irq, NULL, ec_irq_thread,
>> +                                        IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> +                                        "chromeos-ec", ec_dev);
>> +             if (err) {
>> +                     dev_err(dev, "request irq %d: error %d\n",
>
> This is an ugly error message.  Write them like you (as I user) would
> like to see.  I suggest using proper English and grammar.
>
> "Failed to request IRQ %d: %d", irq, err ?

Sounds good.

>> +                             ec_dev->irq, err);
>> +                     return err;
>> +             }
>> +     }
>> +
>>       err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, &ec_cell, 1,
>>                             NULL, ec_dev->irq, NULL);
>>       if (err) {
>>               dev_err(dev,
>>                       "Failed to register Embedded Controller subdevice %d\n",
>>                       err);
>> -             return err;
>> +             goto fail_mfd;
>>       }
>>
>>       if (ec_dev->max_passthru) {
>> @@ -94,7 +123,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>                       dev_err(dev,
>>                               "Failed to register Power Delivery subdevice %d\n",
>>                               err);
>> -                     return err;
>> +                     goto fail_mfd;
>>               }
>>       }
>>
>> @@ -103,13 +132,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>               if (err) {
>>                       mfd_remove_devices(dev);
>>                       dev_err(dev, "Failed to register sub-devices\n");
>> -                     return err;
>> +                     goto fail_mfd;
>>               }
>>       }
>>
>>       dev_info(dev, "Chrome EC device registered\n");
>>
>>       return 0;
>> +
>> +fail_mfd:
>> +     if (ec_dev->irq)
>> +             free_irq(ec_dev->irq, ec_dev);
>> +     return err;
>>  }
>>  EXPORT_SYMBOL(cros_ec_register);
>>
>> @@ -136,13 +170,30 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
>>  }
>>  EXPORT_SYMBOL(cros_ec_suspend);
>>
>> +static void cros_ec_drain_events(struct cros_ec_device *ec_dev)
>> +{
>> +     while (cros_ec_get_next_event(ec_dev) > 0)
>> +             blocking_notifier_call_chain(&ec_dev->event_notifier,
>> +                                          1, ec_dev);
>> +}
>> +
>>  int cros_ec_resume(struct cros_ec_device *ec_dev)
>>  {
>>       enable_irq(ec_dev->irq);
>>
>> +     /*
>> +      * In some case, we need to distinguish events that occur during
>
> s/case/cases/
>
> s/distinguish/distinguish between/

Cool.

>> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
>> index a677c2bd485c..ddc935ef1911 100644
>> --- a/include/linux/mfd/cros_ec.h
>> +++ b/include/linux/mfd/cros_ec.h
>> @@ -72,6 +72,24 @@ struct cros_ec_command {
>>       uint8_t data[0];
>>  };
>>
>> +/*
>> + * event_data is used by keyboard or event notifier:
>> + * event_data format:
>> + * If MKBP protocol is supported:
>> + * 0           1
>> + * +-----------+--------------------------------
>> + * | type      | payload
>> + * +-----------+--------------------------------
>> + * |HOST_EVENT | EVENT (32 bit)
>> + * |KEY_MATRIX | Keyboard keys pressed.
>> + * |SENSOR_FIFO| Sensors FIFO information.
>> + *
>> + * Otherwise:
>> + * 0           1
>> + * +-----------+--------------------------------
>> + * |Unused     | Keyboard keys pressed.
>> + */
>
> Personally, I don't think this documentation is required.  But if you
> insist on supplying it, I think it'll be better placed near the
> 'struct ec_response_get_next_event' definition.

I'm personally fine with leaving it out.

>>  /**
>>   * struct cros_ec_device - Information about a ChromeOS EC device
>>   *
>> @@ -107,6 +125,9 @@ struct cros_ec_command {
>>   *     should check msg.result for the EC's result code.
>>   * @pkt_xfer: send packet to EC and get response
>>   * @lock: one transaction at a time
>> + * @event_notifier: interrupt event notifier for transport devices.
>> + * @event_data: raw payload transferred with the MKBP event.
>> + * @event_size: size in bytes of the event data.
>>   */
>>  struct cros_ec_device {
>>
>> @@ -135,6 +156,11 @@ struct cros_ec_device {
>>       int (*pkt_xfer)(struct cros_ec_device *ec,
>>                       struct cros_ec_command *msg);
>>       struct mutex lock;
>> +     bool mkbp_event_supported;
>
> Did you document this?

Oops.

>> +     struct blocking_notifier_head event_notifier;
>> +
>> +     struct ec_response_get_next_event event_data;
>> +     int event_size;
>>  };
>>
>>  /* struct cros_ec_platform - ChromeOS EC platform information
>> @@ -252,6 +278,14 @@ int cros_ec_register(struct cros_ec_device *ec_dev);
>>   */
>>  int cros_ec_query_all(struct cros_ec_device *ec_dev);
>>
>> +/**
>> + * cros_ec_get_next_event -  Fetch next event from the ChromeOS EC
>> + *
>> + * @ec_dev: Device to fetch event from
>> + * @return 0 if ok, -ve on error
>
> I'd prefer easy to read/descriptive over trying to be smart.
>
> The 'return' value doesn' require a @.  Instead, the return section
> should look like "Return: <blah>".
>
> I suggest: "Return: 0 on success, Linux error number on failure"

Sounds good to me.

>> + */
>> +int cros_ec_get_next_event(struct cros_ec_device *ec_dev);
>> +
>>  /* sysfs stuff */
>>  extern struct attribute_group cros_ec_attr_group;
>>  extern struct attribute_group cros_ec_lightbar_attr_group;
>> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
>> index 13b630c10d4c..d86526f0bd8e 100644
>> --- a/include/linux/mfd/cros_ec_commands.h
>> +++ b/include/linux/mfd/cros_ec_commands.h
>> @@ -1762,6 +1762,40 @@ struct ec_result_keyscan_seq_ctrl {
>>       };
>>  } __packed;
>>
>> +/*
>> + * Get the next pending MKBP event.
>> + *
>> + * Returns EC_RES_UNAVAILABLE if there is no event pending.
>> + */
>
> You're documenting this command as if it's a function.  This command
> does nothing by it's self, rather it is supplied to a function call,
> which does the work.  Similarly this command returns nothing, the
> device will provide the UNAVAILABLE return value.  Please update the
> comment.

I see. This was following the style of the existing command docs, so
it may end up being a bit surprising.

Thanks a lot,

Tomeu
