From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2] HID: Replace semaphore driver_lock with mutex
Date: Mon, 19 Jun 2017 12:20:12 +0200
Message-ID: <CANq1E4Rb5am=HxR781htV1E+agfPSjoQVZj2BPZ-tnrDr7Ow3Q@mail.gmail.com>
References: <1497345926-3262-1-git-send-email-binoy.jayan@linaro.org>
 <CAK8P3a27bGLpisra1YDT7VntWByk6oS0Fz3e2E0-Nmf-6pVYCA@mail.gmail.com>
 <20170613095618.GB29589@mail.corp.redhat.com> <CANq1E4Two8-Qk5q=OFunE-mfuHvopY1Hm=7CrVZUaHJzBPUPyQ@mail.gmail.com>
 <CAK8P3a3bzOv6T_6mgjrEZupb4t5vi2JDZVze2qbNXmOiY1BDBA@mail.gmail.com>
 <CAHv-k_9Wxt+TkeTssLizjf5WNZAgfMy1bcXGPBfMePsNLRAY1Q@mail.gmail.com>
 <CAK8P3a3+TG_q62HZi-N33xh-t6a-Wc-SRjR+18x6j7957KytqQ@mail.gmail.com>
 <CANq1E4SqnS2fhQjrAsdS+=i+beSNKnqZZv=Y+ctjCsSWXiHBBQ@mail.gmail.com> <CAK8P3a1E-SEZa7cmbdmPHrA7WB2jiJ_z5ofFfroa=KoV5cxhCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35160 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753682AbdFSKUO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 06:20:14 -0400
In-Reply-To: <CAK8P3a1E-SEZa7cmbdmPHrA7WB2jiJ_z5ofFfroa=KoV5cxhCg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Binoy Jayan <binoy.jayan@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra <rnayak@codeaurora.org>, Mark Brown <broonie@kernel.org>, Jiri Kosina <jikos@kernel.org>, David Herrmann <dh.herrmann@googlemail.com>, Andrew de los Reyes <adlr@chromium.org>

Hi

On Wed, Jun 14, 2017 at 1:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Does that mean that we can have a concurrent hid_device_remove()
> and hid_device_probe() on the same device, using different
> drivers and actually still need the driver_lock for that? I would assume
> that the driver core handles that part at least.

Nope. Only one device can be probed per physical device. Driver core
locking is sufficient.

>> Also note that hid_input_report() might be called from interrupt
>> context, hence it can never call into kref_put() or similar (unless we
>> want to guarantee that unbinding can run in interrupt context).
>
> I was thinking that we could do most of the unbinding in
> hid_device_remove() and only do a small part (the final kfree
> at the minimum) in the release() callback that gets called from
> kref_put(), but I guess that also isn't easy to retrofit.

Not a big fan of putting such restrictions on unbinding. Also unlikely
to retrofit now. But I also think it is not needed.

>> If we really want to get rid of the semaphore, a spinlock might do
>> fine as well. Then again, some hid device drivers might expect their
>> transport driver to *not* run in irq context, and thus break under a
>> spinlock. So if you want to fix this, we need to audit the hid device
>> drivers.
>
> Do you mean the hdrv->report or hdrv->raw_event might not work
> in atomic context, or the probe/release callbacks might not work
> there?

Correct. I assume that there are hid-device-drivers that use raw_event
(or other) callbacks, that assume that they're *not* in atomic
context.

For instance, the bluetooth ll-drivers call hid_input_report() from a
workqueue. Hence, any device-driver running on bluetooth might have
put kmalloc(GFP_KERNEL) calls into its callbacks without ever noticing
that this is a bad idea. This is obviously not correct, since the
device driver might very well be probed on USB and then fault. But...
yeah... I wouldn't bet on all drivers to be correct in that regard.

> If it's only the former, we could do something like the (untested,
> needs rebasing etc) patch below, which only holds the spinlock
> during hid_input_report(). We test the io_started flag under the
> lock, which makes the flag sufficiently atomic, and the release
> function will wait for any concurrent hid_input_report() to complete
> before resetting the flag.
>
> For reference only, do not apply.
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I like the patch. It should be sufficient for what we want. If it
breaks things, lets fix those device drivers then.

Thanks
David

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 5f87dbe28336..300c65bd40a1 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1532,8 +1532,11 @@ int hid_input_report(struct hid_device *hid,
> int type, u8 *data, int size, int i
>         if (!hid)
>                 return -ENODEV;
>
> -       if (down_trylock(&hid->driver_input_lock))
> -               return -EBUSY;
> +       spin_lock(&hid->driver_input_lock);
> +       if (!hid->io_started) {
> +               ret = -EBUSY;
> +               goto unlock;
> +       }
>
>         if (!hid->driver) {
>                 ret = -ENODEV;
> @@ -1568,7 +1571,7 @@ int hid_input_report(struct hid_device *hid, int
> type, u8 *data, int size, int i
>         ret = hid_report_raw_event(hid, type, data, size, interrupt);
>
>  unlock:
> -       up(&hid->driver_input_lock);
> +       spin_unlock(&hid->driver_input_lock);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(hid_input_report);
> @@ -2317,11 +2320,6 @@ static int hid_device_probe(struct device *dev)
>
>         if (down_interruptible(&hdev->driver_lock))
>                 return -EINTR;
> -       if (down_interruptible(&hdev->driver_input_lock)) {
> -               ret = -EINTR;
> -               goto unlock_driver_lock;
> -       }
> -       hdev->io_started = false;
>
>         if (!hdev->driver) {
>                 id = hid_match_device(hdev, hdrv);
> @@ -2345,7 +2343,7 @@ static int hid_device_probe(struct device *dev)
>         }
>  unlock:
>         if (!hdev->io_started)
> -               up(&hdev->driver_input_lock);
> +               hid_device_io_start(hdev);
>  unlock_driver_lock:
>         up(&hdev->driver_lock);
>         return ret;
> @@ -2363,7 +2361,7 @@ static int hid_device_remove(struct device *dev)
>                 ret = -EINTR;
>                 goto unlock_driver_lock;
>         }
> -       hdev->io_started = false;
> +       hid_device_io_stop(hdev);
>
>         hdrv = hdev->driver;
>         if (hdrv) {
> @@ -2375,8 +2373,11 @@ static int hid_device_remove(struct device *dev)
>                 hdev->driver = NULL;
>         }
>
> -       if (!hdev->io_started)
> -               up(&hdev->driver_input_lock);
> +       if (!hdev->io_started) {
> +               dev_warn(dev, "hdrv->remove left io active\n");
> +               hid_device_io_stop(hdev);
> +       }
> +
>  unlock_driver_lock:
>         up(&hdev->driver_lock);
>         return ret;
> @@ -2836,7 +2837,8 @@ struct hid_device *hid_allocate_device(void)
>         INIT_LIST_HEAD(&hdev->debug_list);
>         spin_lock_init(&hdev->debug_list_lock);
>         sema_init(&hdev->driver_lock, 1);
> -       sema_init(&hdev->driver_input_lock, 1);
> +       spin_lock_init(&hdev->driver_input_lock, 1);
> +       hdev->io_started = false;
>         mutex_init(&hdev->ll_open_lock);
>
>         return hdev;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 5006f9b5d837..00e9f4042a03 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -527,7 +527,7 @@ struct hid_device {
>                  /* device report descriptor */
>         struct work_struct led_work;
>  /* delayed LED worker */
>
>         struct semaphore driver_lock;
>  /* protects the current driver, except during input */
> -       struct semaphore driver_input_lock;
>  /* protects the current driver */
> +       spinlock_t driver_input_lock;
>  /* protects the current driver */
>         struct device dev;
>  /* device */
>         struct hid_driver *driver;
>
> @@ -854,12 +854,12 @@ __u32 hid_field_extract(const struct hid_device
> *hid, __u8 *report,
>   * incoming packets to be delivered to the driver.
>   */
>  static inline void hid_device_io_start(struct hid_device *hid) {
> +       spin_lock(&hid->driver_input_lock);
>         if (hid->io_started) {
>                 dev_warn(&hid->dev, "io already started\n");
> -               return;
>         }
>         hid->io_started = true;
> -       up(&hid->driver_input_lock);
> +       spin_unlock(&hid->driver_input_lock);
>  }
>
>  /**
> @@ -874,12 +874,12 @@ static inline void hid_device_io_start(struct
> hid_device *hid) {
>   * by the thread calling probe or remove.
>   */
>  static inline void hid_device_io_stop(struct hid_device *hid) {
> +       spin_lock(&hid->driver_input_lock);
>         if (!hid->io_started) {
>                 dev_warn(&hid->dev, "io already stopped\n");
> -               return;
>         }
>         hid->io_started = false;
> -       down(&hid->driver_input_lock);
> +       spin_unlock(&hid->driver_input_lock);
>  }
>
>  /**
