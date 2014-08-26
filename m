From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH] HID: add support for PenMount HID TouchScreen Driver
Date: Tue, 26 Aug 2014 09:29:38 +0200
Message-ID: <CAH9NwWe7FSmvVx+BNf7gsjOm9oWLEO7CunHrZjPUwkxiKWLb9w@mail.gmail.com>
References: <1408978083-569-1-git-send-email-christian.gmeiner@gmail.com> <CAN+gG=Gpze-CA_LRa-69+M_rL3HzSiM_DwMAW1TW8xkA_Kc82w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:47058 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933874AbaHZHaA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Aug 2014 03:30:00 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so3658591wiv.1
        for <linux-input@vger.kernel.org>; Tue, 26 Aug 2014 00:29:58 -0700 (PDT)
In-Reply-To: <CAN+gG=Gpze-CA_LRa-69+M_rL3HzSiM_DwMAW1TW8xkA_Kc82w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Benjamin.

2014-08-25 17:43 GMT+02:00 Benjamin Tissoires <benjamin.tissoires@gmail.com>:
> On Mon, Aug 25, 2014 at 10:48 AM, Christian Gmeiner
> <christian.gmeiner@gmail.com> wrote:
>> This driver is a cleaned up version of
>> http://git.android-x86.org/?p=kernel/cdv.git;a=blob_plain;f=drivers/hid/hid-penmount.c;hb=HEAD
>
> This is definitively weird. According to your driver, it should go by
> default through hid-multitouch and behave correctly (at least the
> multi-touch versions, and I would say yours too).
>

I thought I have tried it with hid-multitouch, but I it never gets used.

[   94.342542] usb 2-1.7: USB disconnect, device number 6
[   96.312636] usb 2-1.7: new full-speed USB device number 7 using ehci-pci
[   96.399606] usb 2-1.7: New USB device found, idVendor=14e1, idProduct=6000
[   96.399611] usb 2-1.7: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[   96.399614] usb 2-1.7: Product: PenMount USB
[   96.399617] usb 2-1.7: Manufacturer: DIALOGUE INC
[   96.402777] input: DIALOGUE INC PenMount USB as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.7/2-1.7:1.0/0003:14E1:6000.0004/input/input12
[   96.403533] hid-generic 0003:14E1:6000.0004: input,hidraw2: USB HID
v1.01 Mouse [DIALOGUE INC PenMount USB] on usb-0000:00:1d.0-1.7/input0


> Can you send me some touch recordings of your device with
> hid-recorder[1] please? No need to remove your driver, it will capture
> raw input events, so you should be just fine.

[christian@chgm-pc hid]$ sudo hid-recorder
Available devices:
/dev/hidraw0:   Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)
/dev/hidraw1:   LITE-ON Technology USB NetVista Full Width Keyboard.
/dev/hidraw2:   DIALOGUE INC PenMount USB
Select the device event number [0-2]: 2
R: 76 05 01 09 02 a1 01 09 01 a1 00 09 00 15 00 25 01 95 06 75 01 81
01 05 09 19 01 29 03 15 00 25 01 95 02 75 01 81 02 05 01 09 30 09 31
15 00 26 ff 03 36 80 00 46 ff 7f 75 10 95 02 81 02 09 00 15 00 26 ff
00 75 08 95 05 b1 02 c0 c0
N: DIALOGUE INC PenMount USB
P: usb-0000:00:1d.0-1.7/input0
I: 3 14e1 6000
E: 0.000000 5 30 d0 00 d1 01
E: 0.000945 5 70 d0 00 d1 01
E: 0.006984 5 70 d0 00 d1 01
E: 0.012961 5 70 d0 00 d1 01
E: 0.019001 5 70 d0 00 d1 01
E: 0.025965 5 70 d0 00 d1 01
E: 0.031960 5 70 d0 00 d1 01
E: 0.037964 5 70 d0 00 d1 01
E: 0.043964 5 70 d0 00 d1 01
E: 0.050988 5 70 d0 00 d1 01
E: 0.056945 5 70 d0 00 d1 01
E: 0.062985 5 70 d0 00 d1 01
E: 0.068965 5 70 d0 00 d1 01
E: 0.075974 5 70 d0 00 d1 01
E: 0.081961 5 70 d0 00 d1 01
E: 0.112985 5 70 d0 00 d1 01
E: 0.118978 5 70 d0 00 d0 01
E: 0.124978 5 70 d1 00 d0 01
E: 0.131973 5 70 d3 00 d0 01
E: 0.137971 5 70 d4 00 d0 01
E: 0.143919 5 70 d5 00 cf 01
E: 0.149938 5 70 d7 00 cf 01
E: 0.155971 5 70 d9 00 cf 01
E: 0.163011 5 70 db 00 ce 01
E: 0.168984 5 70 dc 00 ce 01
E: 0.174996 5 70 de 00 cd 01
E: 0.180957 5 70 e0 00 cd 01
E: 0.187985 5 70 e1 00 cc 01
E: 0.193991 5 70 e3 00 cc 01
E: 0.199984 5 70 e5 00 cb 01
E: 0.206006 5 70 e7 00 cb 01
E: 0.212986 5 70 e9 00 ca 01
E: 0.218988 5 70 eb 00 ca 01
E: 0.224955 5 70 ed 00 c9 01
E: 0.230943 5 70 f0 00 c9 01
E: 0.237986 5 70 f2 00 c8 01
E: 0.243951 5 70 f5 00 c7 01
E: 0.262959 5 70 f8 00 c6 01
E: 0.269008 5 70 fc 00 c5 01
E: 0.274963 5 70 ff 00 c3 01
E: 0.280913 5 70 03 01 c1 01
E: 0.287962 5 70 07 01 c0 01
E: 0.293989 5 70 0a 01 bf 01
E: 0.299971 5 70 0e 01 be 01
E: 0.305973 5 70 12 01 bd 01
E: 0.313004 5 70 15 01 bc 01
E: 0.318966 5 70 18 01 bb 01
E: 0.324979 5 70 1b 01 ba 01
E: 0.330975 5 70 1f 01 b9 01
E: 0.337957 5 70 22 01 b8 01
E: 0.343986 5 70 25 01 b7 01
E: 0.349924 5 70 28 01 b5 01
E: 0.355963 5 70 2c 01 b4 01
E: 0.362928 5 70 2f 01 b3 01
E: 0.368975 5 70 33 01 b1 01
E: 0.374911 5 70 36 01 b0 01
E: 0.380961 5 70 39 01 af 01
E: 0.387969 5 70 3d 01 af 01
E: 0.393916 5 70 40 01 ae 01
E: 0.399961 5 70 43 01 ad 01
E: 0.405957 5 70 47 01 ad 01
E: 0.412947 5 70 4a 01 ac 01
E: 0.418982 5 70 4d 01 ab 01
E: 0.424983 5 70 50 01 aa 01
E: 0.430989 5 70 54 01 a9 01
E: 0.437946 5 70 57 01 a8 01
E: 0.443999 5 70 5a 01 a7 01
E: 0.449980 5 70 5d 01 a6 01
E: 0.455972 5 70 61 01 a5 01
E: 0.462986 5 70 64 01 a4 01
E: 0.468994 5 70 67 01 a3 01
E: 0.474981 5 70 6a 01 a3 01
E: 0.480990 5 70 6c 01 a2 01
E: 0.487974 5 70 6f 01 a1 01
E: 0.493988 5 70 72 01 a1 01
E: 0.500009 5 70 75 01 a0 01
E: 0.505973 5 70 77 01 9f 01
E: 0.512990 5 70 7a 01 9f 01
E: 0.518971 5 70 7d 01 9e 01
E: 0.524988 5 70 7f 01 9e 01
E: 0.530969 5 70 81 01 9e 01
E: 0.537991 5 70 83 01 9d 01
E: 0.543979 5 70 86 01 9d 01
E: 0.549988 5 70 88 01 9c 01
E: 0.555973 5 70 8a 01 9c 01
E: 0.562958 5 70 8c 01 9c 01
E: 0.568917 5 70 8d 01 9b 01
E: 0.574984 5 70 8f 01 9b 01
E: 0.580986 5 70 92 01 9b 01
E: 0.587984 5 70 94 01 9a 01
E: 0.593990 5 70 95 01 9a 01
E: 0.599959 5 70 97 01 99 01
E: 0.605980 5 70 97 01 99 01
E: 0.612983 5 70 98 01 99 01
E: 0.618990 5 70 9a 01 98 01
E: 0.624972 5 70 9b 01 98 01
E: 0.630983 5 70 9c 01 97 01
E: 0.638007 5 70 9e 01 97 01
E: 0.643953 5 70 9f 01 97 01
E: 0.649986 5 70 a1 01 96 01
E: 0.655975 5 70 a1 01 96 01
E: 0.662980 5 70 a3 01 96 01
E: 0.668993 5 70 a4 01 95 01


> If the default binding does not work and if we can not make this work
> through hid-multitouch, then I'll have some comments on your patch,
> but I keep that for later :)
>



Greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner

> Cheers,
> Benjamin
>
> [1] http://bentiss.github.io/hid-replay-docs/
>
>
>
>>
>> As I only have a PenMount 6000 to test I removed the multi touch support from the dirver.
>>
>> Bus 002 Device 006: ID 14e1:6000 Dialogue Technology Corp.
>> Device Descriptor:
>>   bLength                18
>>   bDescriptorType         1
>>   bcdUSB               1.10
>>   bDeviceClass            0 (Defined at Interface level)
>>   bDeviceSubClass         0
>>   bDeviceProtocol         0
>>   bMaxPacketSize0        64
>>   idVendor           0x14e1 Dialogue Technology Corp.
>>   idProduct          0x6000
>>   bcdDevice           a4.b4
>>   iManufacturer           1 DIALOGUE INC
>>   iProduct                2 PenMount USB
>>   iSerial                 0
>>   bNumConfigurations      1
>>   Configuration Descriptor:
>>     bLength                 9
>>     bDescriptorType         2
>>     wTotalLength           41
>>     bNumInterfaces          1
>>     bConfigurationValue     1
>>     iConfiguration          4 full speed
>>     bmAttributes         0xa0
>>       (Bus Powered)
>>       Remote Wakeup
>>     MaxPower              500mA
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        0
>>       bAlternateSetting       0
>>       bNumEndpoints           2
>>       bInterfaceClass         3 Human Interface Device
>>       bInterfaceSubClass      0 No Subclass
>>       bInterfaceProtocol      0 None
>>       iInterface              3 EndPoint1 Interrupt Pipe
>>         HID Device Descriptor:
>>           bLength                 9
>>           bDescriptorType        33
>>           bcdHID               1.01
>>           bCountryCode            0 Not supported
>>           bNumDescriptors         1
>>           bDescriptorType        34 Report
>>           wDescriptorLength      76
>>          Report Descriptors:
>>            ** UNAVAILABLE **
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x81  EP 1 IN
>>         bmAttributes            3
>>           Transfer Type            Interrupt
>>           Synch Type               None
>>           Usage Type               Data
>>         wMaxPacketSize     0x0005  1x 5 bytes
>>         bInterval               1
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x02  EP 2 OUT
>>         bmAttributes            3
>>           Transfer Type            Interrupt
>>           Synch Type               None
>>           Usage Type               Data
>>         wMaxPacketSize     0x0005  1x 5 bytes
>>         bInterval               1
>> Device Status:     0x0000
>>   (Bus Powered)
>>
>> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
>> ---
>>  drivers/hid/Kconfig        |   6 ++
>>  drivers/hid/Makefile       |   1 +
>>  drivers/hid/hid-core.c     |   1 +
>>  drivers/hid/hid-ids.h      |   1 +
>>  drivers/hid/hid-penmount.c | 200 +++++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 209 insertions(+)
>>  create mode 100644 drivers/hid/hid-penmount.c
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index c18d5d7..0351b66 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -530,6 +530,12 @@ config PANTHERLORD_FF
>>           Say Y here if you have a PantherLord/GreenAsia based game controller
>>           or adapter and want to enable force feedback support for it.
>>
>> +config HID_PENMOUNT
>> +       tristate "Penmount touch device"
>> +       depends on USB_HID
>> +       ---help---
>> +         Say Y here if you have a Penmount based touch controller.
>> +
>>  config HID_PETALYNX
>>         tristate "Petalynx Maxter remote control"
>>         depends on HID
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index 4dbac7f..e2850d8 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -71,6 +71,7 @@ obj-$(CONFIG_HID_NTRIG)               += hid-ntrig.o
>>  obj-$(CONFIG_HID_ORTEK)                += hid-ortek.o
>>  obj-$(CONFIG_HID_PRODIKEYS)    += hid-prodikeys.o
>>  obj-$(CONFIG_HID_PANTHERLORD)  += hid-pl.o
>> +obj-$(CONFIG_HID_PENMOUNT)     += hid-penmount.o
>>  obj-$(CONFIG_HID_PETALYNX)     += hid-petalynx.o
>>  obj-$(CONFIG_HID_PICOLCD)      += hid-picolcd.o
>>  hid-picolcd-y                  += hid-picolcd_core.o
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 12b6e67..6827196 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1880,6 +1880,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>>         { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_18) },
>>         { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_PKB1700) },
>>         { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
>> +       { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
>>         { HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
>>         { HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
>>  #if IS_ENABLED(CONFIG_HID_ROCCAT)
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 25cd674..3943ffe 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -722,6 +722,7 @@
>>  #define USB_DEVICE_ID_PENMOUNT_PCI     0x3500
>>  #define USB_DEVICE_ID_PENMOUNT_1610    0x1610
>>  #define USB_DEVICE_ID_PENMOUNT_1640    0x1640
>> +#define USB_DEVICE_ID_PENMOUNT_6000    0x6000
>>
>>  #define USB_VENDOR_ID_PETALYNX         0x18b1
>>  #define USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE   0x0037
>> diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
>> new file mode 100644
>> index 0000000..3a630d1
>> --- /dev/null
>> +++ b/drivers/hid/hid-penmount.c
>> @@ -0,0 +1,200 @@
>> +/*
>> + *  HID driver for PenMount touchscreens
>> + *
>> + *  Copyright (c) 2011 PenMount Touch Solutions <penmount@seed.net.tw>
>> + *
>> + */
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License as published by the Free
>> + * Software Foundation; either version 2 of the License, or (at your option)
>> + * any later version.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/hid.h>
>> +#include <linux/version.h>
>> +#include <linux/input/mt.h>
>> +#include "hid-ids.h"
>> +
>> +struct penmount_priv {
>> +       u8 touch;
>> +       bool touching;
>> +       u16 x;
>> +       u16 y;
>> +};
>> +
>> +static int penmount_input_mapping(struct hid_device *hdev,
>> +               struct hid_input *hi, struct hid_field *field,
>> +               struct hid_usage *usage, unsigned long **bit, int *max)
>> +{
>> +       struct input_dev *dev = hi->input;
>> +       int mapped = 0;
>> +
>> +       switch (usage->hid & HID_USAGE_PAGE) {
>> +       case HID_UP_GENDESK:
>> +               switch (usage->hid) {
>> +               case HID_GD_X:
>> +                       hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_X);
>> +                       mapped = 1;
>> +                       break;
>> +               case HID_GD_Y:
>> +                       hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_Y);
>> +                       mapped = 1;
>> +                       break;
>> +               }
>> +               break;
>> +       case HID_UP_BUTTON:
>> +               hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
>> +               mapped = 1;
>> +               break;
>> +       case HID_UP_DIGITIZER:
>> +               switch (usage->hid) {
>> +               case HID_DG_TIPSWITCH:
>> +                       hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
>> +                       mapped = 1;
>> +                       break;
>> +               case HID_DG_CONTACTID:
>> +                       input_mt_init_slots(dev, 1, 0);
>> +                       mapped = -1;
>> +                       break;
>> +               case HID_DG_INRANGE:
>> +               case HID_DG_CONFIDENCE:
>> +                       mapped = -1;
>> +                       break;
>> +               }
>> +               break;
>> +       }
>> +
>> +       return mapped;
>> +}
>> +
>> +static void penmount_process(struct input_dev *dev, struct penmount_priv *priv)
>> +{
>> +       if (!priv->touching) {
>> +               if (priv->touch) {
>> +                       input_report_key(dev, BTN_TOUCH, 1);
>> +                       priv->touching = true;
>> +               }
>> +       } else {
>> +               if (!priv->touch) {
>> +                       input_report_key(dev, BTN_TOUCH, 0);
>> +                       priv->touching = false;
>> +               }
>> +       }
>> +
>> +       input_report_abs(dev, ABS_X, priv->x);
>> +       input_report_abs(dev, ABS_Y, priv->y);
>> +       input_sync(dev);
>> +
>> +       priv->touch = 0;
>> +}
>> +
>> +static int penmount_event(struct hid_device *hdev, struct hid_field *field,
>> +               struct hid_usage *usage, __s32 value)
>> +{
>> +       if (hdev->claimed & HID_CLAIMED_INPUT) {
>> +               struct penmount_priv *priv = hid_get_drvdata(hdev);
>> +               struct input_dev *dev = field->hidinput->input;
>> +
>> +               switch (usage->hid) {
>> +               case HID_DG_TIPSWITCH:
>> +                       priv->touch = value;
>> +                       break;
>> +               case HID_GD_X:
>> +                       priv->x = value;
>> +                       break;
>> +               case HID_GD_Y:
>> +                       priv->y = value;
>> +                       break;
>> +               default:
>> +                       /* fallback to the generic hidinput handling */
>> +                       return 0;
>> +               }
>> +
>> +               penmount_process(dev, priv);
>> +       }
>> +
>> +       if ((hdev->claimed & HID_CLAIMED_HIDDEV) && (hdev->hiddev_hid_event))
>> +               hdev->hiddev_hid_event(hdev, field, usage, value);
>> +
>> +       return 1;
>> +}
>> +
>> +static int penmount_probe(struct hid_device *hdev,
>> +               const struct hid_device_id *id)
>> +{
>> +       struct penmount_priv *priv;
>> +       int ret = 0;
>> +
>> +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
>> +
>> +       hid_set_drvdata(hdev, priv);
>> +
>> +       ret = hid_parse(hdev);
>> +       if (ret) {
>> +               hid_err(hdev, "parse failed\n");
>> +               goto err_free;
>> +       }
>> +
>> +       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>> +       if (ret) {
>> +               hid_err(hdev, "hw start failed\n");
>> +               goto err_free;
>> +       }
>> +
>> +       return 0;
>> +
>> +err_free:
>> +       kfree(priv);
>> +       return ret;
>> +}
>> +
>> +static void penmount_remove(struct hid_device *hdev)
>> +{
>> +       struct penmount_priv *priv = hid_get_drvdata(hdev);
>> +
>> +       hid_hw_stop(hdev);
>> +       kfree(priv);
>> +}
>> +
>> +static const struct hid_device_id penmount_devices[] = {
>> +       { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(hid, penmount_devices);
>> +
>> +static const struct hid_usage_id penmount_usages[] = {
>> +       { HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
>> +       { HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1 }
>> +};
>> +
>> +static struct hid_driver penmount_driver = {
>> +       .name = "hid-penmount",
>> +       .id_table = penmount_devices,
>> +       .probe = penmount_probe,
>> +       .remove = penmount_remove,
>> +       .input_mapping = penmount_input_mapping,
>> +       .usage_table = penmount_usages,
>> +       .event = penmount_event,
>> +};
>> +
>> +static int __init penmount_init(void)
>> +{
>> +       return hid_register_driver(&penmount_driver);
>> +}
>> +
>> +static void __exit penmount_exit(void)
>> +{
>> +       hid_unregister_driver(&penmount_driver);
>> +}
>> +
>> +module_init(penmount_init);
>> +module_exit(penmount_exit);
>> +
>> +MODULE_AUTHOR("PenMount Touch Solutions <penmount@seed.net.tw>");
>> +MODULE_DESCRIPTION("PenMount HID TouchScreen Driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 1.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
