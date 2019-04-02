From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: force setting drvdata to NULL when removing the driver
Date: Tue, 2 Apr 2019 16:00:41 +0200
Message-ID: <CAO-hwJK5B1uEmw7vnt73k2BLv4YQeLMf_KwS58-LgAOrLfCqhA@mail.gmail.com>
References: <20190328155151.577687-1-benjamin.tissoires@redhat.com>
 <CAKdAkRRwKS+wzXjh=gyOQtSEiMwWhArZVc_cwecJsEZ=MGRa8w@mail.gmail.com>
 <CAO-hwJK2yusO2f+oFnUcNGuxo6e_+7F6Cjqmcsuimy4zrm-Jww@mail.gmail.com> <a31a6f95-924a-4930-e4df-5576abc694fb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a31a6f95-924a-4930-e4df-5576abc694fb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Apr 2, 2019 at 3:52 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 02-04-19 15:44, Benjamin Tissoires wrote:
> > Hi Dmitry,
> >
> > On Fri, Mar 29, 2019 at 11:26 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >>
> >> Hi Benjamin,
> >>
> >> On Thu, Mar 28, 2019 at 8:52 AM Benjamin Tissoires
> >> <benjamin.tissoires@redhat.com> wrote:
> >>>
> >>> Or when the probe failed.
> >>>
> >>> This is a common pattern in the HID drivers to reset the drvdata. Some
> >>> do it properly, some do it only in case of failure.
> >>> Anyway, it's never a good thing to have breadcrumbs, so force a clean
> >>> state when removing or when probe is failing.
> >>
> >> Just a data point: driver core already clears drvdata, so as long as
> >> dev_get/set_drvdata() is the same as hid_get/set_drvdata() no special
> >> handling is needed in HID core.
> >
> > You are correct (as always ;-P). I'll drop the hid-core changes and
> > send a v2 ASAP.
>
> I was just looking at the same thing. I should have known about this
> since I wrote the patch to make the core clear drvdata. I should have
> mentioned that, but I was assuming that the hid code was special somehow,
> however now I see it just uses a regular device_add, so indeed the core
> changes are not necessary.
>
> Given the large hid-logitech-*.c patch-set it might be easier for
> Jiri if you split out the hid-logitech-*.c changes into a separate
> patch, then he can keep that on his logitech branch (just a thought).
>

I do not expect the logitech changes to now create some big conflict.
But looking at the current for-5.2* branches, I should probably split
the series per driver given that there is no more dependency on
hid-core. This way, we can take the logitech changes in the
for-5.2/logitech branch, and you can rebase your work on top of it.

Cheers,
Benjamin

> Regards,
>
> Hans
>
>
> >
> > Cheers,
> > Benjamin
> >
> >>
> >> Thanks.
> >>
> >> --
> >> Dmitry
> >>
> >> On Thu, Mar 28, 2019 at 8:52 AM Benjamin Tissoires
> >> <benjamin.tissoires@redhat.com> wrote:
> >>>
> >>> Or when the probe failed.
> >>>
> >>> This is a common pattern in the HID drivers to reset the drvdata. Some
> >>> do it properly, some do it only in case of failure.
> >>> Anyway, it's never a good thing to have breadcrumbs, so force a clean
> >>> state when removing or when probe is failing.
> >>>
> >>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >>> ---
> >>>   drivers/hid/hid-core.c           |  2 ++
> >>>   drivers/hid/hid-cougar.c         |  6 ++----
> >>>   drivers/hid/hid-gfrm.c           |  7 -------
> >>>   drivers/hid/hid-lenovo.c         |  2 --
> >>>   drivers/hid/hid-logitech-dj.c    |  2 --
> >>>   drivers/hid/hid-logitech-hidpp.c |  8 +++-----
> >>>   drivers/hid/hid-picolcd_core.c   |  7 +------
> >>>   drivers/hid/hid-sensor-hub.c     |  1 -
> >>>   drivers/hid/wacom_sys.c          | 18 +++++-------------
> >>>   9 files changed, 13 insertions(+), 40 deletions(-)
> >>>
> >>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> >>> index b5a8af8daa74..011e49da4d63 100644
> >>> --- a/drivers/hid/hid-core.c
> >>> +++ b/drivers/hid/hid-core.c
> >>> @@ -2203,6 +2203,7 @@ static int hid_device_probe(struct device *dev)
> >>>                  if (ret) {
> >>>                          hid_close_report(hdev);
> >>>                          hdev->driver = NULL;
> >>> +                       hid_set_drvdata(hdev, NULL);
> >>>                  }
> >>>          }
> >>>   unlock:
> >>> @@ -2231,6 +2232,7 @@ static int hid_device_remove(struct device *dev)
> >>>                  else /* default remove */
> >>>                          hid_hw_stop(hdev);
> >>>                  hid_close_report(hdev);
> >>> +               hid_set_drvdata(hdev, NULL);
> >>>                  hdev->driver = NULL;
> >>>          }
> >>>
> >>> diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
> >>> index e0bb7b34f3a4..4ff3bc1d25e2 100644
> >>> --- a/drivers/hid/hid-cougar.c
> >>> +++ b/drivers/hid/hid-cougar.c
> >>> @@ -207,7 +207,7 @@ static int cougar_probe(struct hid_device *hdev,
> >>>          error = hid_parse(hdev);
> >>>          if (error) {
> >>>                  hid_err(hdev, "parse failed\n");
> >>> -               goto fail;
> >>> +               return error;
> >>>          }
> >>>
> >>>          if (hdev->collection->usage == COUGAR_VENDOR_USAGE) {
> >>> @@ -219,7 +219,7 @@ static int cougar_probe(struct hid_device *hdev,
> >>>          error = hid_hw_start(hdev, connect_mask);
> >>>          if (error) {
> >>>                  hid_err(hdev, "hw start failed\n");
> >>> -               goto fail;
> >>> +               return error;
> >>>          }
> >>>
> >>>          error = cougar_bind_shared_data(hdev, cougar);
> >>> @@ -249,8 +249,6 @@ static int cougar_probe(struct hid_device *hdev,
> >>>
> >>>   fail_stop_and_cleanup:
> >>>          hid_hw_stop(hdev);
> >>> -fail:
> >>> -       hid_set_drvdata(hdev, NULL);
> >>>          return error;
> >>>   }
> >>>
> >>> diff --git a/drivers/hid/hid-gfrm.c b/drivers/hid/hid-gfrm.c
> >>> index cf477f8c8f4c..1a20997e7750 100644
> >>> --- a/drivers/hid/hid-gfrm.c
> >>> +++ b/drivers/hid/hid-gfrm.c
> >>> @@ -127,12 +127,6 @@ static int gfrm_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >>>          return ret;
> >>>   }
> >>>
> >>> -static void gfrm_remove(struct hid_device *hdev)
> >>> -{
> >>> -       hid_hw_stop(hdev);
> >>> -       hid_set_drvdata(hdev, NULL);
> >>> -}
> >>> -
> >>>   static const struct hid_device_id gfrm_devices[] = {
> >>>          { HID_BLUETOOTH_DEVICE(0x58, 0x2000),
> >>>                  .driver_data = GFRM100 },
> >>> @@ -146,7 +140,6 @@ static struct hid_driver gfrm_driver = {
> >>>          .name = "gfrm",
> >>>          .id_table = gfrm_devices,
> >>>          .probe = gfrm_probe,
> >>> -       .remove = gfrm_remove,
> >>>          .input_mapping = gfrm_input_mapping,
> >>>          .raw_event = gfrm_raw_event,
> >>>          .input_configured = gfrm_input_configured,
> >>> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> >>> index eacc76d2ab96..cde9d22bb3ec 100644
> >>> --- a/drivers/hid/hid-lenovo.c
> >>> +++ b/drivers/hid/hid-lenovo.c
> >>> @@ -869,8 +869,6 @@ static void lenovo_remove_tpkbd(struct hid_device *hdev)
> >>>
> >>>          led_classdev_unregister(&data_pointer->led_micmute);
> >>>          led_classdev_unregister(&data_pointer->led_mute);
> >>> -
> >>> -       hid_set_drvdata(hdev, NULL);
> >>>   }
> >>>
> >>>   static void lenovo_remove_cptkbd(struct hid_device *hdev)
> >>> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> >>> index 826fa1e1c8d9..a75101293755 100644
> >>> --- a/drivers/hid/hid-logitech-dj.c
> >>> +++ b/drivers/hid/hid-logitech-dj.c
> >>> @@ -1094,7 +1094,6 @@ static int logi_dj_probe(struct hid_device *hdev,
> >>>   hid_parse_fail:
> >>>          kfifo_free(&djrcv_dev->notif_fifo);
> >>>          kfree(djrcv_dev);
> >>> -       hid_set_drvdata(hdev, NULL);
> >>>          return retval;
> >>>
> >>>   }
> >>> @@ -1145,7 +1144,6 @@ static void logi_dj_remove(struct hid_device *hdev)
> >>>
> >>>          kfifo_free(&djrcv_dev->notif_fifo);
> >>>          kfree(djrcv_dev);
> >>> -       hid_set_drvdata(hdev, NULL);
> >>>   }
> >>>
> >>>   static const struct hid_device_id logi_dj_receivers[] = {
> >>> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> >>> index 199cc256e9d9..b950a44157a2 100644
> >>> --- a/drivers/hid/hid-logitech-hidpp.c
> >>> +++ b/drivers/hid/hid-logitech-hidpp.c
> >>> @@ -3237,15 +3237,15 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >>>          if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
> >>>                  ret = wtp_allocate(hdev, id);
> >>>                  if (ret)
> >>> -                       goto allocate_fail;
> >>> +                       return ret;
> >>>          } else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560) {
> >>>                  ret = m560_allocate(hdev);
> >>>                  if (ret)
> >>> -                       goto allocate_fail;
> >>> +                       return ret;
> >>>          } else if (hidpp->quirks & HIDPP_QUIRK_CLASS_K400) {
> >>>                  ret = k400_allocate(hdev);
> >>>                  if (ret)
> >>> -                       goto allocate_fail;
> >>> +                       return ret;
> >>>          }
> >>>
> >>>          INIT_WORK(&hidpp->work, delayed_work_cb);
> >>> @@ -3343,8 +3343,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >>>          sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
> >>>          cancel_work_sync(&hidpp->work);
> >>>          mutex_destroy(&hidpp->send_mutex);
> >>> -allocate_fail:
> >>> -       hid_set_drvdata(hdev, NULL);
> >>>          return ret;
> >>>   }
> >>>
> >>> diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
> >>> index c1b29a9eb41a..a5d30f267a7b 100644
> >>> --- a/drivers/hid/hid-picolcd_core.c
> >>> +++ b/drivers/hid/hid-picolcd_core.c
> >>> @@ -550,8 +550,7 @@ static int picolcd_probe(struct hid_device *hdev,
> >>>          data = kzalloc(sizeof(struct picolcd_data), GFP_KERNEL);
> >>>          if (data == NULL) {
> >>>                  hid_err(hdev, "can't allocate space for Minibox PicoLCD device data\n");
> >>> -               error = -ENOMEM;
> >>> -               goto err_no_cleanup;
> >>> +               return -ENOMEM;
> >>>          }
> >>>
> >>>          spin_lock_init(&data->lock);
> >>> @@ -613,9 +612,6 @@ static int picolcd_probe(struct hid_device *hdev,
> >>>          hid_hw_stop(hdev);
> >>>   err_cleanup_data:
> >>>          kfree(data);
> >>> -err_no_cleanup:
> >>> -       hid_set_drvdata(hdev, NULL);
> >>> -
> >>>          return error;
> >>>   }
> >>>
> >>> @@ -651,7 +647,6 @@ static void picolcd_remove(struct hid_device *hdev)
> >>>          picolcd_exit_cir(data);
> >>>          picolcd_exit_keys(data);
> >>>
> >>> -       hid_set_drvdata(hdev, NULL);
> >>>          mutex_destroy(&data->mutex);
> >>>          /* Finally, clean up the picolcd data itself */
> >>>          kfree(data);
> >>> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> >>> index 4256fdc5cd6d..a3db5d8b382d 100644
> >>> --- a/drivers/hid/hid-sensor-hub.c
> >>> +++ b/drivers/hid/hid-sensor-hub.c
> >>> @@ -755,7 +755,6 @@ static void sensor_hub_remove(struct hid_device *hdev)
> >>>          }
> >>>          spin_unlock_irqrestore(&data->lock, flags);
> >>>          mfd_remove_devices(&hdev->dev);
> >>> -       hid_set_drvdata(hdev, NULL);
> >>>          mutex_destroy(&data->mutex);
> >>>   }
> >>>
> >>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> >>> index a8633b1437b2..c2fb614bff44 100644
> >>> --- a/drivers/hid/wacom_sys.c
> >>> +++ b/drivers/hid/wacom_sys.c
> >>> @@ -2716,14 +2716,12 @@ static int wacom_probe(struct hid_device *hdev,
> >>>          wacom_wac->features = *((struct wacom_features *)id->driver_data);
> >>>          features = &wacom_wac->features;
> >>>
> >>> -       if (features->check_for_hid_type && features->hid_type != hdev->type) {
> >>> -               error = -ENODEV;
> >>> -               goto fail;
> >>> -       }
> >>> +       if (features->check_for_hid_type && features->hid_type != hdev->type)
> >>> +               return -ENODEV;
> >>>
> >>>          error = kfifo_alloc(&wacom_wac->pen_fifo, WACOM_PKGLEN_MAX, GFP_KERNEL);
> >>>          if (error)
> >>> -               goto fail;
> >>> +               return error;
> >>>
> >>>          wacom_wac->hid_data.inputmode = -1;
> >>>          wacom_wac->mode_report = -1;
> >>> @@ -2741,12 +2739,12 @@ static int wacom_probe(struct hid_device *hdev,
> >>>          error = hid_parse(hdev);
> >>>          if (error) {
> >>>                  hid_err(hdev, "parse failed\n");
> >>> -               goto fail;
> >>> +               return error;
> >>>          }
> >>>
> >>>          error = wacom_parse_and_register(wacom, false);
> >>>          if (error)
> >>> -               goto fail;
> >>> +               return error;
> >>>
> >>>          if (hdev->bus == BUS_BLUETOOTH) {
> >>>                  error = device_create_file(&hdev->dev, &dev_attr_speed);
> >>> @@ -2757,10 +2755,6 @@ static int wacom_probe(struct hid_device *hdev,
> >>>          }
> >>>
> >>>          return 0;
> >>> -
> >>> -fail:
> >>> -       hid_set_drvdata(hdev, NULL);
> >>> -       return error;
> >>>   }
> >>>
> >>>   static void wacom_remove(struct hid_device *hdev)
> >>> @@ -2789,8 +2783,6 @@ static void wacom_remove(struct hid_device *hdev)
> >>>                  wacom_release_resources(wacom);
> >>>
> >>>          kfifo_free(&wacom_wac->pen_fifo);
> >>> -
> >>> -       hid_set_drvdata(hdev, NULL);
> >>>   }
> >>>
> >>>   #ifdef CONFIG_PM
> >>> --
> >>> 2.19.2
> >>>
> >>
> >>
> >> --
> >> Dmitry
