From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 3/3] HID: sony: Prevent duplicate controller connections.
Date: Wed, 19 Feb 2014 12:04:55 +0100
Message-ID: <CANq1E4QrFnaqbY8yT3UM5wmr-YuE7k6ZHBEmZ8trkaphvwFFXQ@mail.gmail.com>
References: <1392762123-17725-1-git-send-email-frank.praznik@oh.rr.com>
	<1392762123-17725-4-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62489 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbaBSLE4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Feb 2014 06:04:56 -0500
Received: by mail-ie0-f174.google.com with SMTP id as1so121168iec.33
        for <linux-input@vger.kernel.org>; Wed, 19 Feb 2014 03:04:55 -0800 (PST)
In-Reply-To: <1392762123-17725-4-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Tue, Feb 18, 2014 at 11:22 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> If a Sixaxis or Dualshock 4 controller is connected via USB while already
> connected via Bluetooth it will cause duplicate devices to be added to the
> input device list.
>
> To prevent this a global list of controllers and their MAC addresses is
> maintained and new controllers are checked against this list.  If a duplicate
> is found, the probe function with exit with -EEXIST.
>
> On USB the MAC is retrieved via a feature report.  On Bluetooth neither
> controller reports the MAC address in a feature report so the MAC is parsed from
> the uniq string.  As uniq cannot be guaranteed to be a MAC address in every case
> (uHID or the behavior of HIDP changing) a parsing failure will not prevent the
> connection.
>
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  drivers/hid/hid-sony.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 159 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index ad1cebd..c25f0d7 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -713,8 +713,12 @@ static enum power_supply_property sony_battery_props[] = {
>         POWER_SUPPLY_PROP_STATUS,
>  };
>
> +static spinlock_t sony_dev_list_lock;
> +static LIST_HEAD(sony_device_list);

Please include <linux/list.h>

> +
>  struct sony_sc {
>         spinlock_t lock;
> +       struct list_head list_node;
>         struct hid_device *hdev;
>         struct led_classdev *leds[MAX_LEDS];
>         unsigned long quirks;
> @@ -726,6 +730,7 @@ struct sony_sc {
>         __u8 right;
>  #endif
>
> +       __u8 mac_address[6];
>         __u8 cable_state;
>         __u8 battery_charging;
>         __u8 battery_capacity;
> @@ -1473,6 +1478,137 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
>         return 0;
>  }
>
> +/* If a controller is plugged in via USB while already connected via Bluetooth
> + * it will show up as two devices. A global list of connected controllers and
> + * their MAC addresses is maintained to ensure that a device is only connected
> + * once.
> + */

We usually use one of those comment-styles:

/*
 * some
 * comment
 */

/* some
 * comment */

..but I use my own style all the time, so who am I to judge.. You
might get screamed at in other subsystems, though.

> +static int sony_check_add_dev_list(struct sony_sc *sc)
> +{
> +       struct sony_sc *entry;
> +       struct list_head *pos;
> +       unsigned long flags;
> +       int ret;
> +
> +       spin_lock_irqsave(&sony_dev_list_lock, flags);
> +
> +       list_for_each(pos, &sony_device_list) {
> +               entry = list_entry(pos, struct sony_sc, list_node);

You can use "list_for_each_entry()" here.

> +               ret = memcmp(sc->mac_address, entry->mac_address,
> +                               sizeof(sc->mac_address));
> +               if (!ret) {
> +                       if (sc->hdev->bus != entry->hdev->bus) {
> +                               ret = -EEXIST;
> +                               hid_info(sc->hdev, "controller with MAC address %pMR already connected\n",
> +                                       sc->mac_address);
> +                       } else {
> +                               /* Duplicate found, but on the same bus as the
> +                                * original. Allow the connection in this case.
> +                                */
> +                               ret = 0;

Please drop that. Imagine some device uses BT-LE at some point and
thus is managed via uHID. If the device is connected via BT *and*
BT-LE, both will have BUS_BLUETOOTH set but are the same device. I
think the mac-comparison is enough. I don't know why a single device
would be connected twice and be managed by hid-sony..

> +                       }
> +
> +                       spin_unlock_irqrestore(&sony_dev_list_lock, flags);
> +                       return ret;

Usually we use:

                r = -ESOMETHING;
                goto unlock;
...
        r = 0;

unlock:
        spin_unlock_irqrestore(&sony_dev_list_lock, flags);
        return r;

This way the locking is symmetric and easier to review.

> +               }
> +       }
> +
> +       list_add(&(sc->list_node), &sony_device_list);
> +       spin_unlock_irqrestore(&sony_dev_list_lock, flags);
> +
> +       return 0;
> +}
> +
> +static void sony_remove_dev_list(struct sony_sc *sc)
> +{
> +       unsigned long flags;
> +
> +       if (sc->list_node.next) {
> +               spin_lock_irqsave(&sony_dev_list_lock, flags);
> +               list_del(&(sc->list_node));
> +               spin_unlock_irqrestore(&sony_dev_list_lock, flags);
> +       }
> +}
> +
> +static int sony_get_bt_devaddr(struct sony_sc *sc)
> +{
> +       int ret, n;
> +       unsigned int mac_addr[6];
> +
> +       /* HIDP stores the device MAC address as a string in the uniq field. */
> +       ret = strlen(sc->hdev->uniq);

Are you sure "uniq" cannot be NULL?

> +       if (ret != 17)
> +               return -EINVAL;
> +
> +       ret = sscanf(sc->hdev->uniq, "%02x:%02x:%02x:%02x:%02x:%02x",
> +               &mac_addr[5], &mac_addr[4], &mac_addr[3], &mac_addr[2],
> +               &mac_addr[1], &mac_addr[0]);

%02hhx so you can avoid the temporary copy?

> +
> +       if (ret != 6)
> +               return -EINVAL;
> +
> +       for (n = 0; n < 6; n++)
> +               sc->mac_address[n] = (__u8)mac_addr[n];
> +
> +       return 0;
> +}
> +
> +static int sony_check_add(struct sony_sc *sc)
> +{
> +       int n, ret;
> +
> +       if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) ||
> +           (sc->quirks & SIXAXIS_CONTROLLER_BT)) {
> +               /* sony_get_bt_devaddr() attempts to parse the Bluetooth MAC
> +                * address from the uniq string where HIDP stores it.
> +                * As uniq cannot be guaranteed to be a MAC address in all cases
> +                * a failure of this function should not prevent the connection.
> +                */
> +               if (sony_get_bt_devaddr(sc) < 0) {
> +                       hid_warn(sc->hdev, "UNIQ does not contain a MAC address; duplicate check skipped\n");
> +                       return 0;
> +               }
> +       } else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
> +               __u8 buf[7];
> +
> +               /* The MAC address of a DS4 controller connected via USB can be
> +                * retrieved with feature report 0x81. The address begins at
> +                * offset 1.
> +                */
> +               ret = hid_hw_raw_request(sc->hdev, 0x81, buf, sizeof(buf),
> +                               HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +
> +               if (ret != 7) {
> +                       hid_err(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
> +                       return ret < 0 ? ret : -EINVAL;
> +               }
> +
> +               memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
> +       } else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
> +               __u8 buf[18];
> +
> +               /* The MAC address of a Sixaxis controller connected via USB can
> +                * be retrieved with feature report 0xf2. The address begins at
> +                * offset 4.
> +                */
> +               ret = hid_hw_raw_request(sc->hdev, 0xf2, buf, sizeof(buf),
> +                               HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +
> +               if (ret != 18) {
> +                       hid_err(sc->hdev, "failed to retrieve feature report 0xf2 with the Sixaxis MAC address\n");
> +                       return ret < 0 ? ret : -EINVAL;
> +               }
> +
> +               /* The Sixaxis device MAC in the report is in reverse order */

"reverse" sounds weird here.. addresses are usually stored in
network-byte-order (BigEndian), so lets be clear here and say the
input is little-endian so you have to swap it. Or am I wrong?

> +               for (n = 0; n < 6; n++)
> +                       sc->mac_address[5-n] = buf[4+n];
> +       } else {
> +               return 0;
> +       }
> +
> +       return sony_check_add_dev_list(sc);
> +}
> +
>  static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  {
>         int ret;
> @@ -1509,12 +1645,22 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 return ret;
>         }
>
> -       if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
> -               hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
> -               ret = sixaxis_set_operational_usb(hdev);
> -               INIT_WORK(&sc->state_worker, sixaxis_state_worker);
> -       } else if (sc->quirks & SIXAXIS_CONTROLLER_BT) {
> -               ret = sixaxis_set_operational_bt(hdev);
> +       if (sc->quirks & SIXAXIS_CONTROLLER) {
> +               if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
> +                       hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
> +                       ret = sixaxis_set_operational_usb(hdev);
> +               } else
> +                       ret = sixaxis_set_operational_bt(hdev);
> +
> +               if (ret < 0) {
> +                       hid_err(hdev, "failed to set the Sixaxis operational mode\n");
> +                       goto err_stop;
> +               }
> +
> +               ret = sony_check_add(sc);
> +               if (ret < 0)
> +                       goto err_stop;
> +

You check the quirks in sony_check_add() again, so why not leave all
this code as is and call sony_check_add() below for *all* devices?

Could you add a line to net/hidp/core.c where we write UNIQ that some
devices depend on this? Other than that, the patch looks good.

Thanks
David

>                 INIT_WORK(&sc->state_worker, sixaxis_state_worker);
>         } else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
>                 if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
> @@ -1524,6 +1670,11 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                                 goto err_stop;
>                         }
>                 }
> +
> +               ret = sony_check_add(sc);
> +               if (ret < 0)
> +                       goto err_stop;
> +
>                 /* The Dualshock 4 touchpad supports 2 touches and has a
>                  * resolution of 1920x940.
>                  */
> @@ -1588,6 +1739,8 @@ static void sony_remove(struct hid_device *hdev)
>                 sony_battery_remove(sc);
>         }
>
> +       sony_remove_dev_list(sc);
> +
>         cancel_work_sync(&sc->state_worker);
>
>         hid_hw_stop(hdev);
> --
> 1.8.5.3
>
