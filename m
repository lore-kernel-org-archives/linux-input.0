From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 13/17] HID: logitech-hidpp: make .probe usbhid capable
Date: Wed, 18 Jan 2017 10:26:12 +0100
Message-ID: <CAN+gG=G30ZROL7R9WRZ7971pmmd46OhLctA-v-zSB+CmFu2SUQ@mail.gmail.com>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com> <20170117143547.30488-14-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117143547.30488-14-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 17, 2017 at 3:35 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> The current custom solution for the G920 is not the best because
> hid_hw_start() is not called at the end of the .probe().
> It means that any configuration retrieved after the initial hid_hw_start
> would not be exposed to user space without races.
>
> We can simply force hid_hw_start to just enable the transport layer by
> not using a connect_mask. This way, we can have a common path between
> USB, Unifying and Bluetooth devices.
>
> Tested with a G502 (plain USB), a T650 and many other unifying devices,
> and the T651 over Bluetooth.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 88 ++++++++++++++++++++++------------------
>  1 file changed, 48 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index a5d37a4..f5889ff 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2813,6 +2813,17 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         if (!hidpp_validate_device(hdev))
>                 return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>
> +       /*
> +        * HID++ needs to read incoming report while in .probe().
> +        * However, this doesn't work for plain USB devices until the hdev
> +        * status is set with HID_STAT_ADDED (device fully registered once
> +        * with HID).
> +        * So we ask for it to be reprobed later.
> +        */
> +       if (id->group != HID_GROUP_LOGITECH_DJ_DEVICE &&
> +           !(hdev->status & HID_STAT_ADDED))

Looks like this test breaks the T651 (bluetooth) after all. I seem to
have better success with:
    if (id->bus == BUS_USB && !(hdev->status & HID_STAT_ADDED))

But that also means that the solution will not work if there is only
one USB interface in the device :/

Cheers,
Benjamin

> +               return -EPROBE_DEFER;
> +
>         hidpp = devm_kzalloc(&hdev->dev, sizeof(struct hidpp_device),
>                         GFP_KERNEL);
>         if (!hidpp)
> @@ -2853,24 +2864,23 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 hid_warn(hdev, "Cannot allocate sysfs group for %s\n",
>                          hdev->name);
>
> -       if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
> -               connect_mask &= ~HID_CONNECT_HIDINPUT;
> -
> -       if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
> -               ret = hid_hw_start(hdev, connect_mask);
> -               if (ret) {
> -                       hid_err(hdev, "hw start failed\n");
> -                       goto hid_hw_start_fail;
> -               }
> -               ret = hid_hw_open(hdev);
> -               if (ret < 0) {
> -                       dev_err(&hdev->dev, "%s:hid_hw_open returned error:%d\n",
> -                               __func__, ret);
> -                       hid_hw_stop(hdev);
> -                       goto hid_hw_start_fail;
> -               }
> +       /*
> +        * Plain USB connections need to actually call start and open
> +        * on the transport driver to allow incoming data.
> +        */
> +       ret = hid_hw_start(hdev, 0);
> +       if (ret) {
> +               hid_err(hdev, "hw start failed\n");
> +               goto hid_hw_start_fail;
>         }
>
> +       ret = hid_hw_open(hdev);
> +       if (ret < 0) {
> +               dev_err(&hdev->dev, "%s:hid_hw_open returned error:%d\n",
> +                       __func__, ret);
> +               hid_hw_stop(hdev);
> +               goto hid_hw_open_fail;
> +       }
>
>         /* Allow incoming packets */
>         hid_device_io_start(hdev);
> @@ -2880,7 +2890,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 if (!connected) {
>                         ret = -ENODEV;
>                         hid_err(hdev, "Device not connected");
> -                       goto hid_hw_open_failed;
> +                       goto hid_hw_init_fail;
>                 }
>
>                 hid_info(hdev, "HID++ %u.%u device connected.\n",
> @@ -2893,37 +2903,36 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
>                 ret = wtp_get_config(hidpp);
>                 if (ret)
> -                       goto hid_hw_open_failed;
> +                       goto hid_hw_init_fail;
>         } else if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)) {
>                 ret = g920_get_config(hidpp);
>                 if (ret)
> -                       goto hid_hw_open_failed;
> +                       goto hid_hw_init_fail;
>         }
>
> -       /* Block incoming packets */
> -       hid_device_io_stop(hdev);
> +       hidpp_connect_event(hidpp);
>
> -       if (!(hidpp->quirks & HIDPP_QUIRK_CLASS_G920)) {
> -               ret = hid_hw_start(hdev, connect_mask);
> -               if (ret) {
> -                       hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
> -                       goto hid_hw_start_fail;
> -               }
> -       }
> +       /* Reset the HID node state */
> +       hid_device_io_stop(hdev);
> +       hid_hw_close(hdev);
> +       hid_hw_stop(hdev);
>
> -       /* Allow incoming packets */
> -       hid_device_io_start(hdev);
> +       if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
> +               connect_mask &= ~HID_CONNECT_HIDINPUT;
>
> -       hidpp_connect_event(hidpp);
> +       /* Now export the actual inputs and hidraw nodes to the world */
> +       ret = hid_hw_start(hdev, connect_mask);
> +       if (ret) {
> +               hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
> +               goto hid_hw_start_fail;
> +       }
>
>         return ret;
>
> -hid_hw_open_failed:
> -       hid_device_io_stop(hdev);
> -       if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
> -               hid_hw_close(hdev);
> -               hid_hw_stop(hdev);
> -       }
> +hid_hw_init_fail:
> +       hid_hw_close(hdev);
> +hid_hw_open_fail:
> +       hid_hw_stop(hdev);
>  hid_hw_start_fail:
>         sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
>         cancel_work_sync(&hidpp->work);
> @@ -2942,10 +2951,9 @@ static void hidpp_remove(struct hid_device *hdev)
>
>         sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
>
> -       if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
> +       if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)
>                 hidpp_ff_deinit(hdev);
> -               hid_hw_close(hdev);
> -       }
> +
>         hid_hw_stop(hdev);
>         cancel_work_sync(&hidpp->work);
>         mutex_destroy(&hidpp->send_mutex);
> --
> 2.9.3
>
