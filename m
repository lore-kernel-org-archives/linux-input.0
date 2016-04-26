From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v8 2/7] Input: cros_ec_keyb - Stop handling interrupts directly
Date: Tue, 26 Apr 2016 08:34:48 +0200
Message-ID: <CAAObsKC3+Fw2QBKnur5ZYWw=Ys4yQaoEYdXV+cjNjGYyyO5McQ@mail.gmail.com>
References: <1460464350-30414-1-git-send-email-tomeu.vizoso@collabora.com>
 <1460464350-30414-3-git-send-email-tomeu.vizoso@collabora.com> <20160425211735.GG26059@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36421 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbcDZGfK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Apr 2016 02:35:10 -0400
In-Reply-To: <20160425211735.GG26059@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Vic Yang <victoryang@google.com>, linux-input@vger.kernel.org

On 25 April 2016 at 23:17, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Tue, Apr 12, 2016 at 02:32:25PM +0200, Tomeu Vizoso wrote:
>> From: Vic Yang <victoryang@google.com>
>>
>> Because events other that keyboard ones will be handled by now on by
>> other drivers, stop directly handling interrupts and instead listen to
>> the new notifier in the MFD driver.
>>
>
> Hmm, where did Vic's sign-off go?

Lee Jones asked to remove them in a previous version as he considers
them superfluous. My understanding is that as I'm the first to submit
them to mainline, the chain starts with me (I certify the b section of
http://developercertificate.org/).

>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Please merge through whatever tree takes the rest of the patches.

Thank you,

Tomeu

>> ---
>>
>> Changes in v8: None
>> Changes in v7: None
>> Changes in v6: None
>> Changes in v5: None
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>  drivers/input/keyboard/cros_ec_keyb.c | 135 ++++++++--------------------------
>>  1 file changed, 31 insertions(+), 104 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
>> index b01966dc7eb3..b891503143dc 100644
>> --- a/drivers/input/keyboard/cros_ec_keyb.c
>> +++ b/drivers/input/keyboard/cros_ec_keyb.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/input.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/kernel.h>
>> +#include <linux/notifier.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/slab.h>
>>  #include <linux/input/matrix_keypad.h>
>> @@ -44,6 +45,7 @@
>>   * @dev: Device pointer
>>   * @idev: Input device
>>   * @ec: Top level ChromeOS device to use to talk to EC
>> + * @notifier: interrupt event notifier for transport devices
>>   */
>>  struct cros_ec_keyb {
>>       unsigned int rows;
>> @@ -57,6 +59,7 @@ struct cros_ec_keyb {
>>       struct device *dev;
>>       struct input_dev *idev;
>>       struct cros_ec_device *ec;
>> +     struct notifier_block notifier;
>>  };
>>
>>
>> @@ -146,67 +149,44 @@ static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
>>       input_sync(ckdev->idev);
>>  }
>>
>> -static int cros_ec_keyb_get_state(struct cros_ec_keyb *ckdev, uint8_t *kb_state)
>> -{
>> -     int ret = 0;
>> -     struct cros_ec_command *msg;
>> -
>> -     msg = kmalloc(sizeof(*msg) + ckdev->cols, GFP_KERNEL);
>> -     if (!msg)
>> -             return -ENOMEM;
>> -
>> -     msg->version = 0;
>> -     msg->command = EC_CMD_MKBP_STATE;
>> -     msg->insize = ckdev->cols;
>> -     msg->outsize = 0;
>> -
>> -     ret = cros_ec_cmd_xfer(ckdev->ec, msg);
>> -     if (ret < 0) {
>> -             dev_err(ckdev->dev, "Error transferring EC message %d\n", ret);
>> -             goto exit;
>> -     }
>> -
>> -     memcpy(kb_state, msg->data, ckdev->cols);
>> -exit:
>> -     kfree(msg);
>> -     return ret;
>> -}
>> -
>> -static irqreturn_t cros_ec_keyb_irq(int irq, void *data)
>> +static int cros_ec_keyb_open(struct input_dev *dev)
>>  {
>> -     struct cros_ec_keyb *ckdev = data;
>> -     struct cros_ec_device *ec = ckdev->ec;
>> -     int ret;
>> -     uint8_t kb_state[ckdev->cols];
>> -
>> -     if (device_may_wakeup(ec->dev))
>> -             pm_wakeup_event(ec->dev, 0);
>> -
>> -     ret = cros_ec_keyb_get_state(ckdev, kb_state);
>> -     if (ret >= 0)
>> -             cros_ec_keyb_process(ckdev, kb_state, ret);
>> -     else
>> -             dev_err(ec->dev, "failed to get keyboard state: %d\n", ret);
>> +     struct cros_ec_keyb *ckdev = input_get_drvdata(dev);
>>
>> -     return IRQ_HANDLED;
>> +     return blocking_notifier_chain_register(&ckdev->ec->event_notifier,
>> +                                             &ckdev->notifier);
>>  }
>>
>> -static int cros_ec_keyb_open(struct input_dev *dev)
>> +static void cros_ec_keyb_close(struct input_dev *dev)
>>  {
>>       struct cros_ec_keyb *ckdev = input_get_drvdata(dev);
>> -     struct cros_ec_device *ec = ckdev->ec;
>>
>> -     return request_threaded_irq(ec->irq, NULL, cros_ec_keyb_irq,
>> -                                     IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> -                                     "cros_ec_keyb", ckdev);
>> +     blocking_notifier_chain_unregister(&ckdev->ec->event_notifier,
>> +                                        &ckdev->notifier);
>>  }
>>
>> -static void cros_ec_keyb_close(struct input_dev *dev)
>> +static int cros_ec_keyb_work(struct notifier_block *nb,
>> +                          unsigned long queued_during_suspend, void *_notify)
>>  {
>> -     struct cros_ec_keyb *ckdev = input_get_drvdata(dev);
>> -     struct cros_ec_device *ec = ckdev->ec;
>> +     struct cros_ec_keyb *ckdev = container_of(nb, struct cros_ec_keyb,
>> +                                               notifier);
>>
>> -     free_irq(ec->irq, ckdev);
>> +     if (ckdev->ec->event_data.event_type != EC_MKBP_EVENT_KEY_MATRIX)
>> +             return NOTIFY_DONE;
>> +     /*
>> +      * If EC is not the wake source, discard key state changes during
>> +      * suspend.
>> +      */
>> +     if (queued_during_suspend)
>> +             return NOTIFY_OK;
>> +     if (ckdev->ec->event_size != ckdev->cols) {
>> +             dev_err(ckdev->dev,
>> +                     "Discarded incomplete key matrix event.\n");
>> +             return NOTIFY_OK;
>> +     }
>> +     cros_ec_keyb_process(ckdev, ckdev->ec->event_data.data.key_matrix,
>> +                          ckdev->ec->event_size);
>> +     return NOTIFY_OK;
>>  }
>>
>>  /*
>> @@ -266,12 +246,8 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
>>       if (!idev)
>>               return -ENOMEM;
>>
>> -     if (!ec->irq) {
>> -             dev_err(dev, "no EC IRQ specified\n");
>> -             return -EINVAL;
>> -     }
>> -
>>       ckdev->ec = ec;
>> +     ckdev->notifier.notifier_call = cros_ec_keyb_work;
>>       ckdev->dev = dev;
>>       dev_set_drvdata(&pdev->dev, ckdev);
>>
>> @@ -312,54 +288,6 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
>>       return 0;
>>  }
>>
>> -#ifdef CONFIG_PM_SLEEP
>> -/* Clear any keys in the buffer */
>> -static void cros_ec_keyb_clear_keyboard(struct cros_ec_keyb *ckdev)
>> -{
>> -     uint8_t old_state[ckdev->cols];
>> -     uint8_t new_state[ckdev->cols];
>> -     unsigned long duration;
>> -     int i, ret;
>> -
>> -     /*
>> -      * Keep reading until we see that the scan state does not change.
>> -      * That indicates that we are done.
>> -      *
>> -      * Assume that the EC keyscan buffer is at most 32 deep.
>> -      */
>> -     duration = jiffies;
>> -     ret = cros_ec_keyb_get_state(ckdev, new_state);
>> -     for (i = 1; !ret && i < 32; i++) {
>> -             memcpy(old_state, new_state, sizeof(old_state));
>> -             ret = cros_ec_keyb_get_state(ckdev, new_state);
>> -             if (0 == memcmp(old_state, new_state, sizeof(old_state)))
>> -                     break;
>> -     }
>> -     duration = jiffies - duration;
>> -     dev_info(ckdev->dev, "Discarded %d keyscan(s) in %dus\n", i,
>> -             jiffies_to_usecs(duration));
>> -}
>> -
>> -static int cros_ec_keyb_resume(struct device *dev)
>> -{
>> -     struct cros_ec_keyb *ckdev = dev_get_drvdata(dev);
>> -
>> -     /*
>> -      * When the EC is not a wake source, then it could not have caused the
>> -      * resume, so we clear the EC's key scan buffer. If the EC was a
>> -      * wake source (e.g. the lid is open and the user might press a key to
>> -      * wake) then the key scan buffer should be preserved.
>> -      */
>> -     if (!ckdev->ec->was_wake_device)
>> -             cros_ec_keyb_clear_keyboard(ckdev);
>> -
>> -     return 0;
>> -}
>> -
>> -#endif
>> -
>> -static SIMPLE_DEV_PM_OPS(cros_ec_keyb_pm_ops, NULL, cros_ec_keyb_resume);
>> -
>>  #ifdef CONFIG_OF
>>  static const struct of_device_id cros_ec_keyb_of_match[] = {
>>       { .compatible = "google,cros-ec-keyb" },
>> @@ -373,7 +301,6 @@ static struct platform_driver cros_ec_keyb_driver = {
>>       .driver = {
>>               .name = "cros-ec-keyb",
>>               .of_match_table = of_match_ptr(cros_ec_keyb_of_match),
>> -             .pm     = &cros_ec_keyb_pm_ops,
>>       },
>>  };
>>
>> --
>> 2.5.5
>>
>
> --
> Dmitry
