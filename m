From: Marcin Tolysz <tolysz@gmail.com>
Subject: Re: [RFC] Simple but effective way of changing HID device descriptors
	(resent)
Date: Thu, 31 Dec 2009 17:28:59 +0000
Message-ID: <54bbe4e00912310928o70b3111cu7d1058a61947f971@mail.gmail.com>
References: <4B32D21B.9090800@gmail.com>
	 <20091224093918.1fe7e32a.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:7911 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbZLaR3B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Dec 2009 12:29:01 -0500
Received: by fg-out-1718.google.com with SMTP id 22so5252721fge.1
        for <linux-input@vger.kernel.org>; Thu, 31 Dec 2009 09:29:00 -0800 (PST)
In-Reply-To: <20091224093918.1fe7e32a.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org

Just to make sure the corrected patch is: [RFC v2] [HID] allow using
external Hid Descriptors.

2009/12/24 Antonio Ospite <ospite@studenti.unina.it>:
> On Thu, 24 Dec 2009 02:29:47 +0000
> Marcin Tolysz <tolysz@gmail.com> wrote:
>
>> Simple but effective way of changing HID device descriptors using
>> firmware loading mechanism.
>> Just place your new descriptor in a location specified by driver
>> i.e. somewhere in /lib/firmware/hid/
>> If it is there it will replace HID descriptor from the device.
>> I do not do any parsing or checking, as it is done by hid driver.
>>
>> Signed-off-by: Marcin Tolysz <tolysz@gmail.com>
>>
>
> Only some style comments below, I haven't tested the patch. Plus, try
> running the patch through scripts/checkpatch.pl to spot all the other
> style issues.

Corrected most of style errors but 3 too long lines.

>> ---
>> =C2=A0 drivers/hid/hid-core.c | =C2=A0 26 +++++++++++++++++++++++++-
>> =C2=A0 1 files changed, 25 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 80792d3..5d8d656 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -27,6 +27,7 @@
>> =C2=A0 #include <linux/wait.h>
>> =C2=A0 #include <linux/vmalloc.h>
>> =C2=A0 #include <linux/sched.h>
>> +#include <linux/firmware.h>
>>
>> =C2=A0 #include <linux/hid.h>
>> =C2=A0 #include <linux/hiddev.h>
>> @@ -640,6 +641,10 @@ int hid_parse_report(struct hid_device *device,
>> __u8 *start,
>> =C2=A0 =C2=A0 =C2=A0 struct hid_item item;
>> =C2=A0 =C2=A0 =C2=A0 __u8 *end;
>> =C2=A0 =C2=A0 =C2=A0 int ret;
>> + =C2=A0 =C2=A0 const struct firmware *fw;
>> + =C2=A0 =C2=A0 int succ;
>
> success? Can't you init fw to NULL and derive this info checking
> (fw !=3D NULL) before releasing firmware?
every other driver checks this value, fw is a structure thus I would
need to check fw->data;

>> + =C2=A0 =C2=A0 char *file;
>> +
>> =C2=A0 =C2=A0 =C2=A0 static int (*dispatch_type[])(struct hid_parser=
 *parser,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hid_ite=
m *item) =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hid_parser_main,
>> @@ -650,10 +655,27 @@ int hid_parse_report(struct hid_device *device=
,
>> __u8 *start,
>>
>> =C2=A0 =C2=A0 =C2=A0 if (device->driver->report_fixup)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device->driver->rep=
ort_fixup(device, start, size);
>> + =C2=A0 =C2=A0 /* Now load a hid descriptor from a file firmware
>> + =C2=A0 =C2=A0 ignoring this fixup thing */
>> + =C2=A0 =C2=A0 file=3Dkmalloc(29, GFP_KERNEL);
>> +
>> sprintf(file,"hid/%04X:%04X:%04X:%04X.bin",device->bus,device->vendo=
r,device->product,device->version);
>> +
>
> What about removing this 29?
> #define NEW_HID_DESCRIPTOR_PATH_FMT "hid/%04X:%04X:%04X:%04X.bin"
> and use it in kmalloc with strlen and in sprintf.

replaced by:
       file =3D kasprintf(GFP_KERNEL, "hid/%04X:%04X:%04X:%04X.bin",
                      device->bus, device->vendor, device->product,
device->version);
I did not putted it into define as this heavily depends on parameters,
and I do not want to separate them yet.

>> + =C2=A0 =C2=A0 succ =3D request_firmware(&fw, file, &device->dev);
>> +
>> + =C2=A0 =C2=A0 if (succ)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO "To rel=
ace HID descriptor place it in
>> /lib/firmaware/%s\n", file);
>
> pr_info() could be used or maybe even dev_info()

I went for pr_info.

>> + =C2=A0 =C2=A0 else{
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D fw->data;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D fw->size;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO "HID de=
scriptor relaced with /lib/firmaware/%s\n",
>> file);
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 kfree(file);
>>
>> =C2=A0 =C2=A0 =C2=A0 device->rdesc =3D kmalloc(size, GFP_KERNEL);
>> - =C2=A0 =C2=A0 if (device->rdesc =3D=3D NULL)
>> + =C2=A0 =C2=A0 if (device->rdesc =3D=3D NULL){
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if(!succ)release_firmwar=
e(fw);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
>> + =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 memcpy(device->rdesc, start, size);
>> =C2=A0 =C2=A0 =C2=A0 device->rsize =3D size;
>>
>> @@ -690,6 +712,7 @@ int hid_parse_report(struct hid_device *device, =
__u8
>> *start,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dbg_hid("unbalanced delimiter at en=
d of report description\n");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if(!succ)release_firmware(fw);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 vfree(parser);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> @@ -697,6 +720,7 @@ int hid_parse_report(struct hid_device *device, =
__u8
>> *start,
>>
>> =C2=A0 =C2=A0 =C2=A0 dbg_hid("item fetching failed at offset %d\n", =
(int)(end - start));
>> =C2=A0 err:
>> + =C2=A0 =C2=A0 if(!succ)release_firmware(fw);
>> =C2=A0 =C2=A0 =C2=A0 vfree(parser);
>> =C2=A0 =C2=A0 =C2=A0 return ret;
>> =C2=A0 }
>> -- 1.6.5.7
>
> Regards,
> =C2=A0 Antonio

Many thanks for your help.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
