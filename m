From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 2/3] Add support for specific device methods.
Date: Tue, 26 Aug 2014 18:27:11 -0400
Message-ID: <CAN+gG=FVduZWSDY5K0A2jxjGNEP8ensQ5_FZbhprSODc+UC1+A@mail.gmail.com>
References: <1408797629-3474-1-git-send-email-kreijack@inwind.it>
	<1408797629-3474-3-git-send-email-kreijack@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:43408 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467AbaHZW1M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Aug 2014 18:27:12 -0400
Received: by mail-qc0-f175.google.com with SMTP id w7so16052514qcr.20
        for <linux-input@vger.kernel.org>; Tue, 26 Aug 2014 15:27:11 -0700 (PDT)
In-Reply-To: <1408797629-3474-3-git-send-email-kreijack@inwind.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Goffredo Baroncelli <kreijack@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Goffredo Baroncelli <kreijack@inwind.it>

Hi Goffredo,

On Sat, Aug 23, 2014 at 8:40 AM, Goffredo Baroncelli <kreijack@gmail.com> wrote:
> This patch adds hook into the code to add support for specific
> device driver. The right driver is select on the basis of the name.
>
> 4 hooks are added:
> - init_device() called during the device initialization
> - parse()       called during the device description generation phase
> - parse_raw_event() which handles the events from the device
> - destroy()     called when the device is destroyed

We already said that, I don't like it. There is no need to re-invent a
sub-driver mechanism when we can simply use the hid subsystem. Instead
of using hid-generic for your mouse, we should use a
hid-logitech-generic-device-or-whatever because really, the DJ part of
the Logitech specification is really only a transport layer on top of
hid for hid devices.

>
> The construction of the device is dived in two phases:
> 1) the device is discovered by the receiver. The struct dj_device
> is allocated BUT the device is not enabled.
> It is asked the device name top the device itself
> 2) when the device name arrived from the device, the
> the right driver is selected, structure dj_device is finalized,
> the hid-device id created.
> If the device name returned doesn't match, the generic driver
> (e.g. the one provided until now) is used.
>
>

I have some general comments, and some specific ones (inlined in the code):
- I don't know if you used the gmail web interface or git send-email,
but I am pretty sure that your patch does not pass the tests found in
./scripts/check_patch.pl at the root of the kernel tree. This way, it
will fix ident issues, and some basic coding style issues
- this patch is just too huge to be included as this. You should
consider splitting it in some small subpatches, each of them should
make sense by itself. You can already start looking into having a
separate patch to retrieve the name, one to introduce
logi_djrcv2djdev(), etc...
- do not try to fix extra blank lines in a patch which have functional
changes. This just had some noise and does not help understanding
where the patch focuses.
- please rebase the changes to latest Jiri's branch for-3.18/logitech
which is still not pushed apparently :) I had one cleanup patch from
last week which will clash with your series.

the rest is inlined

> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  drivers/hid/hid-logitech-dj.c | 422 ++++++++++++++++++++++++++++++++++--------
>  drivers/hid/hid-logitech-dj.h |  41 ++++
>  2 files changed, 388 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index ca0ab51..feddd3d 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -193,7 +193,51 @@ static const u8 hid_reportid_size_map[NUMBER_OF_HID_REPORTS] = {
>
>  static struct hid_ll_driver logi_dj_ll_driver;
>
> +static inline struct dj_device *logi_djrcv2djdev(
> +                                       struct dj_receiver_dev *djrcv_dev,
> +                                       int index);

Hmm, there is no need to forward declare a static function in the
general case. Especially if you are adding it. Just put your function
on top and you are good (I know, this is sometime preferred, but AFAIK
not in the kernel).

>  static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev);
> +static int logi_dj_recv_send_report(struct dj_receiver_dev *djrcv_dev,
> +                                   struct dj_report *dj_report);
> +

I _think_ my previous comment applies here also.

> +static inline int call_init_device(struct dj_device *djdev)
> +{
> +       if (!djdev || !djdev->methods || !djdev->methods->init_device)
> +               return false;
> +       return djdev->methods->init_device(djdev);
> +}

Why do you need to put the inline marker? If the function is static,
the compiler should be smart enough to guess that by itself.

> +
> +static inline int call_parse_raw_event(struct dj_device *djdev,
> +                                       struct dj_report *djrep)
> +{
> +       if (!djdev || !djdev->methods || !djdev->methods->parse_raw_event)
> +               return false;
> +       return djdev->methods->parse_raw_event(djdev, djrep);
> +}
> +
> +static inline void call_destroy(struct dj_device *djdev)
> +{
> +       if (!djdev || !djdev->methods || !djdev->methods->destroy)
> +               return;
> +       djdev->methods->destroy(djdev);
> +}
> +
> +static struct dj_device_method dj_device_method[] = {
> +
> +       /* last element */
> +       { NULL, }
> +};
> +
> +static inline struct dj_device *logi_djrcv2djdev(

I do not like the name. Everywhere else the functions are
logi_dj_rcv_*, so please keep it in the same way.

> +                                       struct dj_receiver_dev *djrcv_dev,
> +                                       int index)
> +{
> +       if ((index < DJ_DEVICE_INDEX_MIN) ||
> +           (index > DJ_DEVICE_INDEX_MAX))
> +               return NULL;

With the latest commits in Jiri's tree, I think we should not have to
care about this test. we should be smart enough to test this once and
then guarantee that it is never changed.

> +
> +       return djrcv_dev->paired_dj_devices[index];
> +}

This whole function and various calls should go into its own patch.

>
>  static void logi_dj_recv_destroy_djhid_device(struct dj_receiver_dev *djrcv_dev,
>                                                 struct dj_report *dj_report)
> @@ -203,7 +247,11 @@ static void logi_dj_recv_destroy_djhid_device(struct dj_receiver_dev *djrcv_dev,
>         unsigned long flags;
>
>         spin_lock_irqsave(&djrcv_dev->lock, flags);
> -       dj_dev = djrcv_dev->paired_dj_devices[dj_report->device_index];
> +       dj_dev = logi_djrcv2djdev(djrcv_dev, dj_report->device_index);
> +       if (!dj_dev)
> +               return;

I am not sure this test should be required. If we guarantee early
enough that the device_index is valid and that the device exists, then
this should not be necessary.

> +       call_destroy(dj_dev);
> +
>         djrcv_dev->paired_dj_devices[dj_report->device_index] = NULL;
>         spin_unlock_irqrestore(&djrcv_dev->lock, flags);
>
> @@ -216,93 +264,270 @@ static void logi_dj_recv_destroy_djhid_device(struct dj_receiver_dev *djrcv_dev,
>         }
>  }
>
> -static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
> +/*
> + * This function send a request of the device name
> + * see "Logitech hidpp 1.0 excerpt for public release" chapter 4.5.3
> + * for further information.
> + *
> + * The results are read in logi_dj_raw_event()
> + */
> +static int logi_send_name_request(struct dj_device *dj_device)
> +{
> +       struct dj_report *dj_report;
> +       int retval;
> +
> +       dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
> +       if (!dj_report)
> +               return -ENOMEM;
> +
> +       dj_report->report_id = REPORT_ID_RECV_SHORT;
> +       dj_report->device_index = REPORT_RECEIVER_INDEX;
> +       dj_report->report_type = REPORT_GET_LONG_REGISTER_REQ;
> +       dj_report->report_params[0] = REPORT_REG_PAIRING_INFORMATION;
> +
> +       /*
> +        * 0x40 device id 1, 0x41 device id 2....
> +        */
> +       dj_report->report_params[1] = 0x40 + dj_device->device_index - 1;
> +
> +       retval = hid_hw_raw_request(dj_device->dj_receiver_dev->hdev,
> +               dj_report->report_id,
> +               (void *)dj_report, REPORT_ID_RECV_SHORT_LENGTH,
> +               HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
> +
> +       kfree(dj_report);
> +       return retval;
> +}
> +
> +static int logi_dj_recv_create_dj_device(struct dj_receiver_dev *djrcv_dev,
>                                           struct dj_report *dj_report)
>  {
>         /* Called in delayed work context */
>         struct hid_device *djrcv_hdev = djrcv_dev->hdev;
> -       struct usb_interface *intf = to_usb_interface(djrcv_hdev->dev.parent);
> -       struct usb_device *usbdev = interface_to_usbdev(intf);
> -       struct hid_device *dj_hiddev;
>         struct dj_device *dj_dev;
>
> -       /* Device index goes from 1 to 6, we need 3 bytes to store the
> -        * semicolon, the index, and a null terminator
> -        */
> -       unsigned char tmpstr[3];
> -
>         if (dj_report->report_params[DEVICE_PAIRED_PARAM_SPFUNCTION] &
>             SPFUNCTION_DEVICE_LIST_EMPTY) {
>                 dbg_hid("%s: device list is empty\n", __func__);
>                 djrcv_dev->querying_devices = false;
> -               return;
> +               return -EINVAL;
>         }
>
>         if ((dj_report->device_index < DJ_DEVICE_INDEX_MIN) ||
>             (dj_report->device_index > DJ_DEVICE_INDEX_MAX)) {
>                 dev_err(&djrcv_hdev->dev, "%s: invalid device index:%d\n",
>                         __func__, dj_report->device_index);
> -               return;
> +               return -EINVAL;
>         }
>
>         if (djrcv_dev->paired_dj_devices[dj_report->device_index]) {
>                 /* The device is already known. No need to reallocate it. */
>                 dbg_hid("%s: device is already known\n", __func__);
> -               return;
> +               return -EEXIST;
> +       }
> +
> +       dj_dev = kzalloc(sizeof(struct dj_device), GFP_KERNEL);
> +
> +       if (!dj_dev) {
> +               dev_err(&djrcv_hdev->dev, "%s: failed allocating dj_device\n",
> +                       __func__);
> +               return -ENOMEM;
>         }
>
> +       dj_dev->reports_supported = get_unaligned_le32(
> +               dj_report->report_params + DEVICE_PAIRED_RF_REPORT_TYPE);
> +       dj_dev->dj_receiver_dev = djrcv_dev;
> +       dj_dev->device_index = dj_report->device_index;
> +       dj_dev->enabled = false;
> +
> +       dj_dev->wpid =
> +               dj_report->report_params[DEVICE_PAIRED_PARAM_EQUAD_ID_MSB]<<8|

seems like some spaces are missing around '<<'

> +               dj_report->report_params[DEVICE_PAIRED_PARAM_EQUAD_ID_LSB];
> +
> +       djrcv_dev->paired_dj_devices[dj_report->device_index] = dj_dev;
> +
> +       return 0;
> +
> +}
> +
> +/*
> + * this function finalize the device
> + */
> +static int logi_dj_recv_add_djhid_device(struct dj_device *dj_device)

If the function finalizes the device, why is it called 'add_djhid_device'?

> +{
> +       struct hid_device *dj_hiddev;
> +       struct dj_receiver_dev *djrcv_dev;
> +
> +       struct hid_device *djrcv_hdev;
> +       struct usb_interface *intf;
> +       struct usb_device *usbdev;
> +
> +       /* Device index goes from 1 to 6, we need 3 bytes to store the
> +        * semicolon, the index, and a null terminator
> +        */
> +       unsigned char tmpstr[3];
> +
> +       BUG_ON(!dj_device);
> +       djrcv_dev = dj_device->dj_receiver_dev;
> +       djrcv_hdev = djrcv_dev->hdev;
> +
> +       /* Called in delayed work context */
> +       intf = to_usb_interface(djrcv_hdev->dev.parent);
> +       usbdev = interface_to_usbdev(intf);
> +
>         dj_hiddev = hid_allocate_device();
>         if (IS_ERR(dj_hiddev)) {
>                 dev_err(&djrcv_hdev->dev, "%s: hid_allocate_device failed\n",
>                         __func__);
> -               return;
> +               return -ENOMEM;
>         }
>
>         dj_hiddev->ll_driver = &logi_dj_ll_driver;
> -

I'd prefer keep this white line to separate the transport description
from the rest

> +       dj_device->hdev = dj_hiddev;
> +       dj_hiddev->driver_data = dj_device;
>         dj_hiddev->dev.parent = &djrcv_hdev->dev;
>         dj_hiddev->bus = BUS_USB;
>         dj_hiddev->vendor = le16_to_cpu(usbdev->descriptor.idVendor);
>         dj_hiddev->product = le16_to_cpu(usbdev->descriptor.idProduct);
>         snprintf(dj_hiddev->name, sizeof(dj_hiddev->name),
> -               "Logitech Unifying Device. Wireless PID:%02x%02x",
> -               dj_report->report_params[DEVICE_PAIRED_PARAM_EQUAD_ID_MSB],
> -               dj_report->report_params[DEVICE_PAIRED_PARAM_EQUAD_ID_LSB]);
> +               "Logitech Unifying Device. Wireless PID:%04x",
> +                       dj_device->wpid);

Why bothering setting a complex name if you are changing it after?

>
>         usb_make_path(usbdev, dj_hiddev->phys, sizeof(dj_hiddev->phys));
> -       snprintf(tmpstr, sizeof(tmpstr), ":%d", dj_report->device_index);
> +       snprintf(tmpstr, sizeof(tmpstr), ":%d", dj_device->device_index);
>         strlcat(dj_hiddev->phys, tmpstr, sizeof(dj_hiddev->phys));
>
> -       dj_dev = kzalloc(sizeof(struct dj_device), GFP_KERNEL);
> -
> -       if (!dj_dev) {
> -               dev_err(&djrcv_hdev->dev, "%s: failed allocating dj_device\n",
> +       if (hid_add_device(dj_hiddev)) {
> +               dev_err(&djrcv_dev->hdev->dev,
> +                               "%s: failed adding dj_device\n",
>                         __func__);
> -               goto dj_device_allocate_fail;
> +               djrcv_dev->paired_dj_devices[dj_device->device_index] = NULL;
> +               kfree(dj_device);
> +               hid_destroy_device(dj_hiddev);
> +               return -ENODEV;
>         }
>
> -       dj_dev->reports_supported = get_unaligned_le32(
> -               dj_report->report_params + DEVICE_PAIRED_RF_REPORT_TYPE);
> -       dj_dev->hdev = dj_hiddev;
> -       dj_dev->dj_receiver_dev = djrcv_dev;
> -       dj_dev->device_index = dj_report->device_index;
> -       dj_hiddev->driver_data = dj_dev;
> +       hid_info(djrcv_dev->hdev, "Device %d: '%s' added\n",
> +               dj_device->device_index, dj_device->device_name);
>
> -       djrcv_dev->paired_dj_devices[dj_report->device_index] = dj_dev;
> +       return 0;
> +}
>
> -       if (hid_add_device(dj_hiddev)) {
> -               dev_err(&djrcv_hdev->dev, "%s: failed adding dj_device\n",
> -                       __func__);
> -               goto hid_add_device_fail;
> +static void logi_set_device_name(struct dj_device *dj_device,
> +                                struct dj_report *dj_report)
> +{
> +
> +       struct dj_device_method *m;
> +       struct dj_receiver_dev *djrcv_dev = dj_device->dj_receiver_dev;
> +
> +       strlcpy(dj_device->device_name, dj_report->report_params+3,
> +               sizeof(dj_device->device_name));

This just feel wrong. I remember problems with some long device names
not null terminated.

> +
> +       hid_info(djrcv_dev->hdev, "Device %d: '%s'\n",
> +               dj_device->device_index,
> +               dj_device->device_name);
> +
> +       for (m = dj_device_method ; m->device_names ; m++) {
> +               char **name;
> +
> +               for (name = m->device_names ; name ; name++) {
> +                       if (!strcmp(*name, dj_device->device_name)) {
> +                               dj_device->methods = m;
> +                               hid_info(djrcv_dev->hdev,
> +                                       "Found methods for device '%s'\n",
> +                                       dj_device->device_name);
> +                               return;
> +                       }
> +               }
>         }

This whole for loop has nothing to do with the set_device_name
advertised by the name of the function. Please put this into its own.

>
> -       return;
> +}
> +
> +/*
> + * finalize the dj_device creation, because now we know the driver name
> + */
> +static inline cvoid __dj_device_init_2(struct dj_receiver_dev *djrcv_dev,
> +                               struct dj_report *dj_report)

Ouch. What is this name? And why cvoid?
Please keep it simple and with the current driver naming style.

> +{
> +       int dev_index = dj_report->report_params[1]-0x40+1;

Instead of ' - 0x40' I think a mask would be better.

> +       struct dj_device *dj_device = logi_djrcv2djdev(djrcv_dev, dev_index);
> +       int retval;
>
> -hid_add_device_fail:
> -       djrcv_dev->paired_dj_devices[dj_report->device_index] = NULL;
> -       kfree(dj_dev);
> -dj_device_allocate_fail:
> -       hid_destroy_device(dj_hiddev);
> +       if (!dj_device) {
> +               dbg_hid("%s: cannot find %d device\n",
> +                       __func__, dev_index);
> +               /* do rescan */
> +               retval = logi_dj_recv_query_paired_devices(djrcv_dev);
> +               if (!retval)
> +                       dev_err(&djrcv_dev->hdev->dev,
> +                         "%s:logi_dj_recv_query_paired_devices error:%d\n",
> +                         __func__, retval);
> +

With the cleanup patch soon-to-be-included-by-Jiri, I think this would
not be needed anymore.

> +               return;
> +       }
> +
> +       if (dj_device->enabled) {
> +               dbg_hid("%s: device %d already initializated\n",
> +                       __func__, dev_index);
> +               return;
> +       }
> +
> +       logi_set_device_name(dj_device, dj_report);
> +
> +       if (logi_dj_recv_add_djhid_device(dj_device) < 0) {
> +               logi_dj_recv_destroy_djhid_device(djrcv_dev, dj_report);
> +               dev_err(&djrcv_dev->hdev->dev,
> +                       "Cannot create the hid device\n");
> +               return;
> +       }
> +       if (call_init_device(dj_device)) {
> +               logi_dj_recv_destroy_djhid_device(djrcv_dev, dj_report);
> +               dev_err(&djrcv_dev->hdev->dev,
> +                       "Cannot init the hid device\n");
> +               return;
> +       }
> +
> +       barrier();
> +       dj_device->enabled = true;
> +}
> +
> +/*
> + * Initialize the dj_device structure, but a) doesn't enable it, and b)
> + * doesn't crete the hid device, because we don't now the driver.
> + */
> +static inline void __dj_device_init_1(struct dj_receiver_dev *djrcv_dev,
> +                               struct dj_report *dj_report)

ditto, the name is awful.

> +{
> +       int dev_index;
> +       struct dj_device *dj_device;
> +       int ret;
> +
> +       dev_index = dj_report->device_index;
> +       dj_device = logi_djrcv2djdev(djrcv_dev, dev_index);
> +       if (dj_device) {
> +               dev_warn(&djrcv_dev->hdev->dev,
> +                       "This device (%d) already exist\n", dev_index);
> +               return;
> +       }
> +
> +       ret = logi_dj_recv_create_dj_device(djrcv_dev, dj_report);
> +       if (ret == -EINVAL) {
> +               /* This report is not valid, ignore it */
> +               return;
> +       }
> +       if (ret < 0) {
> +               dev_err(&djrcv_dev->hdev->dev,
> +                       "Cannot allocate the hid device %d.%d\n",
> +                       dj_report->device_index, dj_report->report_type);
> +               return;
> +       }
> +       /* we have to re-taken it, because before was not created */
> +       dj_device = logi_djrcv2djdev(djrcv_dev, dev_index);
> +       if (logi_send_name_request(dj_device) < 0) {
> +               logi_dj_recv_destroy_djhid_device(djrcv_dev, dj_report);
> +               dev_err(&djrcv_dev->hdev->dev,
> +                       "Cannot query the device name\n");
> +       }
>  }
>
>  static void delayedwork_callback(struct work_struct *work)
> @@ -314,6 +539,8 @@ static void delayedwork_callback(struct work_struct *work)
>         unsigned long flags;
>         int count;
>         int retval;
> +       int     dev_index;
> +       struct dj_device *dj_device;
>
>         dbg_hid("%s\n", __func__);
>
> @@ -339,9 +566,14 @@ static void delayedwork_callback(struct work_struct *work)
>         spin_unlock_irqrestore(&djrcv_dev->lock, flags);
>
>         switch (dj_report.report_type) {
> +       case REPORT_GET_LONG_REGISTER_REQ:
> +               __dj_device_init_2(djrcv_dev, &dj_report);
> +               break;
> +
>         case REPORT_TYPE_NOTIF_DEVICE_PAIRED:
> -               logi_dj_recv_add_djhid_device(djrcv_dev, &dj_report);
> +               __dj_device_init_1(djrcv_dev, &dj_report);
>                 break;
> +
>         case REPORT_TYPE_NOTIF_DEVICE_UNPAIRED:
>                 logi_dj_recv_destroy_djhid_device(djrcv_dev, &dj_report);
>                 break;
> @@ -353,20 +585,23 @@ static void delayedwork_callback(struct work_struct *work)
>          * to this dj_device never arrived to this driver. The reason is that
>          * hid-core discards all packets coming from a device while probe() is
>          * executing. */
> -       if (!djrcv_dev->paired_dj_devices[dj_report.device_index]) {
> -               /* ok, we don't know the device, just re-ask the
> -                * receiver for the list of connected devices. */
> -               retval = logi_dj_recv_query_paired_devices(djrcv_dev);
> -               if (!retval) {
> -                       /* everything went fine, so just leave */
> -                       break;
> -               }
> -               dev_err(&djrcv_dev->hdev->dev,
> -                       "%s:logi_dj_recv_query_paired_devices "
> -                       "error:%d\n", __func__, retval);
> -               }
> -               dbg_hid("%s: unexpected report type\n", __func__);
> +               dev_index = dj_report.device_index;
> +               dj_device = logi_djrcv2djdev(djrcv_dev, dev_index);
> +               if (!dj_device) {
> +                       /* ok, we don't know the device, just re-ask the
> +                        * receiver for the list of connected devices. */
> +                       retval = logi_dj_recv_query_paired_devices(djrcv_dev);
> +                       if (!retval) {
> +                               /* everything went fine, so just leave */
> +                               break;
> +                       }
> +                       dev_err(&djrcv_dev->hdev->dev,
> +                           "%s:logi_dj_recv_query_paired_devices error:%d\n",
> +                           __func__, retval);
> +                       }
> +                       dbg_hid("%s: unexpected report type\n", __func__);

It looks like this whole hunk fixes just an indent problem and should
not be in a functional patch.

>         }
> +
>  }
>
>  static void logi_dj_recv_queue_notification(struct dj_receiver_dev *djrcv_dev,
> @@ -390,7 +625,7 @@ static void logi_dj_recv_forward_null_report(struct dj_receiver_dev *djrcv_dev,
>         u8 reportbuffer[MAX_REPORT_SIZE];
>         struct dj_device *djdev;
>
> -       djdev = djrcv_dev->paired_dj_devices[dj_report->device_index];
> +       djdev = logi_djrcv2djdev(djrcv_dev, dj_report->device_index);
>
>         if (!djdev) {
>                 dbg_hid("djrcv_dev->paired_dj_devices[dj_report->device_index]"
> @@ -404,6 +639,10 @@ static void logi_dj_recv_forward_null_report(struct dj_receiver_dev *djrcv_dev,
>                 return;
>         }
>
> +       /* device not enabled */
> +       if (!djdev->enabled)
> +               return;
> +
>         memset(reportbuffer, 0, sizeof(reportbuffer));
>
>         for (i = 0; i < NUMBER_OF_HID_REPORTS; i++) {
> @@ -440,6 +679,10 @@ static void logi_dj_recv_forward_report(struct dj_receiver_dev *djrcv_dev,
>                 return;
>         }
>
> +       /* device not enabled */
> +       if (!dj_device->enabled)
> +               return;
> +
>         if ((dj_report->report_type > ARRAY_SIZE(hid_reportid_size_map) - 1) ||
>             (hid_reportid_size_map[dj_report->report_type] == 0)) {
>                 dbg_hid("invalid report type:%x\n", dj_report->report_type);
> @@ -451,8 +694,8 @@ static void logi_dj_recv_forward_report(struct dj_receiver_dev *djrcv_dev,
>                         hid_reportid_size_map[dj_report->report_type], 1)) {
>                 dbg_hid("hid_input_report error\n");
>         }
> -}
>
> +}

Hmm... whitespace collateral damage?

>
>  static int logi_dj_recv_send_report(struct dj_receiver_dev *djrcv_dev,
>                                     struct dj_report *dj_report)
> @@ -584,6 +827,10 @@ static int logi_dj_ll_parse(struct hid_device *hid)
>         char *rdesc;
>         int retval;
>
> +       /* try the specific hook */
> +       if (djdev->methods && djdev->methods->parse)
> +               return djdev->methods->parse(djdev);
> +

I think send_report can be called anytime when someone try to send
information to the device. Putting an init function here is doomed to
be bugged.

>         dbg_hid("%s\n", __func__);
>
>         djdev->hdev->version = 0x0111;
> @@ -655,7 +902,6 @@ static struct hid_ll_driver logi_dj_ll_driver = {
>         .raw_request = logi_dj_ll_raw_request,
>  };
>
> -

Please refrain to make such changes in a big patch.

>  static int logi_dj_raw_event(struct hid_device *hdev,
>                              struct hid_report *report, u8 *data,
>                              int size)
> @@ -692,25 +938,51 @@ static int logi_dj_raw_event(struct hid_device *hdev,
>          */
>
>         spin_lock_irqsave(&djrcv_dev->lock, flags);
> -       if (dj_report->report_id == REPORT_ID_DJ_SHORT) {
> -               switch (dj_report->report_type) {
> -               case REPORT_TYPE_NOTIF_DEVICE_PAIRED:
> -               case REPORT_TYPE_NOTIF_DEVICE_UNPAIRED:
> -                       logi_dj_recv_queue_notification(djrcv_dev, dj_report);
> -                       break;
> -               case REPORT_TYPE_NOTIF_CONNECTION_STATUS:
> -                       if (dj_report->report_params[CONNECTION_STATUS_PARAM_STATUS] ==
> -                           STATUS_LINKLOSS) {
> -                               logi_dj_recv_forward_null_report(djrcv_dev, dj_report);
> -                       }
> -                       break;
> -               default:
> -                       logi_dj_recv_forward_report(djrcv_dev, dj_report);
> +
> +       if (dj_report->report_id == REPORT_ID_RECV_LONG &&
> +           dj_report->device_index == REPORT_RECEIVER_INDEX &&
> +           dj_report->report_type == REPORT_GET_LONG_REGISTER_REQ &&
> +           dj_report->report_params[0] == REPORT_REG_PAIRING_INFORMATION &&
> +           dj_report->report_params[1] >= REPORT_REG2_NOTIFY_DEVICE_NAME &&
> +           dj_report->report_params[1] < (REPORT_REG2_NOTIFY_DEVICE_NAME+
> +                                               DJ_DEVICE_INDEX_COUNT)) {

Ouch, very much ouch. There might be a better way to test that.

> +
> +               logi_dj_recv_queue_notification(djrcv_dev, dj_report);
> +               report_processed = true;
> +       } else if (dj_report->report_id == REPORT_ID_DJ_SHORT &&
> +                  (dj_report->report_type ==
> +                       REPORT_TYPE_NOTIF_DEVICE_PAIRED ||
> +                   dj_report->report_type ==
> +                       REPORT_TYPE_NOTIF_DEVICE_UNPAIRED)) {
> +
> +               logi_dj_recv_queue_notification(djrcv_dev, dj_report);
> +               report_processed = true;
> +       } else if (dj_report->report_id == REPORT_ID_DJ_SHORT &&
> +                  dj_report->report_type ==
> +                       REPORT_TYPE_NOTIF_CONNECTION_STATUS) {
> +
> +               if (dj_report->report_params[CONNECTION_STATUS_PARAM_STATUS] ==
> +                               STATUS_LINKLOSS) {
> +
> +                       logi_dj_recv_forward_null_report(djrcv_dev, dj_report);
>                 }
>                 report_processed = true;
> +       } else {

I guess a switch/case on the report_id + some extra functions would
greatly help understanding the code.

> +               bool skip = false;
> +               struct dj_device *djdev;
> +
> +               djdev = logi_djrcv2djdev(djrcv_dev, dj_report->device_index);
> +               if (djdev && djdev->enabled) {
> +                       skip = call_parse_raw_event(djdev, dj_report);
> +                       report_processed = skip;
> +               }
> +               if (!skip && dj_report->report_id == REPORT_ID_DJ_SHORT) {
> +                       logi_dj_recv_forward_report(djrcv_dev, dj_report);
> +                       report_processed = true;
> +               }
>         }
> -       spin_unlock_irqrestore(&djrcv_dev->lock, flags);
>
> +       spin_unlock_irqrestore(&djrcv_dev->lock, flags);

Seems like the withespace hunter stroke again.

>         return report_processed;
>  }
>
> @@ -865,12 +1137,12 @@ static void logi_dj_remove(struct hid_device *hdev)
>         for (i = 0; i < (DJ_MAX_PAIRED_DEVICES + DJ_DEVICE_INDEX_MIN); i++) {
>                 dj_dev = djrcv_dev->paired_dj_devices[i];
>                 if (dj_dev != NULL) {
> -                       hid_destroy_device(dj_dev->hdev);
> +                       if (dj_dev->hdev)
> +                               hid_destroy_device(dj_dev->hdev);
>                         kfree(dj_dev);
>                         djrcv_dev->paired_dj_devices[i] = NULL;
>                 }
>         }
> -

I am not saying anything.... :-)

>         kfifo_free(&djrcv_dev->notif_fifo);
>         kfree(djrcv_dev);
>         hid_set_drvdata(hdev, NULL);
> diff --git a/drivers/hid/hid-logitech-dj.h b/drivers/hid/hid-logitech-dj.h
> index 4a40003..d81ed7d 100644
> --- a/drivers/hid/hid-logitech-dj.h
> +++ b/drivers/hid/hid-logitech-dj.h
> @@ -29,12 +29,17 @@
>  #define DJ_MAX_NUMBER_NOTIFICATIONS            8
>  #define DJ_DEVICE_INDEX_MIN                    1
>  #define DJ_DEVICE_INDEX_MAX                    6
> +#define DJ_DEVICE_INDEX_COUNT                  (DJ_DEVICE_INDEX_MAX - \
> +                                                DJ_DEVICE_INDEX_MIN+1)
>
>  #define DJREPORT_SHORT_LENGTH                  15
>  #define DJREPORT_LONG_LENGTH                   32
> +#define REPORT_ID_RECV_SHORT_LENGTH            7
>
>  #define REPORT_ID_DJ_SHORT                     0x20
>  #define REPORT_ID_DJ_LONG                      0x21
> +#define REPORT_ID_RECV_SHORT                   0x10
> +#define REPORT_ID_RECV_LONG                    0x11
>
>  #define REPORT_TYPE_RFREPORT_FIRST             0x01
>  #define REPORT_TYPE_RFREPORT_LAST              0x1F
> @@ -60,6 +65,10 @@
>  /* Device Un-Paired Notification */
>  #define REPORT_TYPE_NOTIF_DEVICE_UNPAIRED      0x40
>
> +/* Device "Unifying Device name" Notification */
> +#define REPORT_GET_LONG_REGISTER_REQ           0x83
> +#define REPORT_REG_PAIRING_INFORMATION         0xb5
> +#define REPORT_REG2_NOTIFY_DEVICE_NAME         0x40
>
>  /* Connection Status Notification */
>  #define REPORT_TYPE_NOTIF_CONNECTION_STATUS    0x42
> @@ -79,6 +88,9 @@
>  #define REPORT_TYPE_MEDIA_CENTER               0x08
>  #define REPORT_TYPE_LEDS                       0x0E
>
> +/* receiver device index */
> +#define REPORT_RECEIVER_INDEX                  0xff
> +
>  /* RF Report types bitfield */
>  #define STD_KEYBOARD                           0x00000002
>  #define STD_MOUSE                              0x00000004
> @@ -104,11 +116,40 @@ struct dj_receiver_dev {
>         bool querying_devices;
>  };
>
> +struct dj_device;
> +
> +/**
> + * these methods are invoked instead the default ones
> + * @devices_name               array of device name supported by this driver
> + * @init_device                        init method for the device. If the returned
> + *                             value is 0, the device was initiated correctly.
> + *                             Otherwise the device is not created.
> + * @parse_raw_event            this method is called when a raw event arrived
> + *                             it permits to change the event.
> + *                             If the value returned is not zero the standard
> + *                             handler is called after.
> + * @parse                      this method allow to generate and pass a
> + *                             device descriptor to the higher level.
> + * @destroy                    called when the device has to be deleted
> + */
> +struct dj_device_method {
> +       char **device_names;
> +       int (*init_device)(struct dj_device *);
> +       int (*parse_raw_event)(struct dj_device *, struct dj_report *);
> +       int (*parse)(struct dj_device *);
> +       void (*destroy)(struct dj_device *);
> +};
> +
>  struct dj_device {
>         struct hid_device *hdev;
>         struct dj_receiver_dev *dj_receiver_dev;
>         u32 reports_supported;
>         u8 device_index;
> +       int  enabled;
> +       char device_name[16];
> +       u16 wpid;
> +       struct dj_device_method *methods;
> +       void *userdata;
>  };
>
>  /**
> --
> 1.9.3
>

OK, done. So, if possible, I would like you to work first on the
various cleanings and the proper naming element in your patch.
I would like to see this cleaned up before we start investigating the
new 'driver' option. You can of course take some ideas from the github
Nestor pointed, or just keep modifying your own code.

Thanks for the patch submission, and keep pushing!

Cheers,
Benjamin
