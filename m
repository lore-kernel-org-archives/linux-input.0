From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2] HID: autoload hid-multitouch as needed
Date: Wed, 28 Mar 2012 11:31:26 +0200
Message-ID: <CAN+gG=HQoyEXLGDQ38YOc_EMs5zj7whP7xNOR0VEd4EFsgKiqw@mail.gmail.com>
References: <1332864735-18709-1-git-send-email-benjamin.tissoires@gmail.com>
	<20120328070351.GA29947@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44745 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241Ab2C1Jb1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Mar 2012 05:31:27 -0400
In-Reply-To: <20120328070351.GA29947@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

I'll do the requested changes: no need to comment ;-)

Cheers,
Benjamin

On Wed, Mar 28, 2012 at 09:03, Henrik Rydberg <rydberg@bitmath.se> wrot=
e:
> Hi Benjamin,
>
>> When the generic hid parsing of the report descriptors in hid-core
>> detects that the device contains the field ContactID, the device sho=
uld
>> be handled by hid-multitouch, and hid-core should release it.
>> This patch implements a temporary fix for hid-core to automatically
>> call the loading of hid-multitouch. A better solution would involve
>> userspace.
>>
>> The code is inspired from what is done in the bttv module.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> ---
>>
>> Hi guys,
>>
>> I finally managed to find some time to resend this patch.
>
> Great, please find some comments inline.
>
>> =A0drivers/hid/hid-core.c | =A0 33 ++++++++++++++++++++++++++++++++-
>> =A0include/linux/hid.h =A0 =A0| =A0 =A08 ++++++++
>> =A02 files changed, 40 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 990fe19..a84221e 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1210,6 +1210,31 @@ static struct bin_attribute dev_bin_attr_repo=
rt_desc =3D {
>> =A0 =A0 =A0 .size =3D HID_MAX_DESCRIPTOR_SIZE,
>> =A0};
>>
>> +#if defined(CONFIG_MODULES) && defined(MODULE)
>> +/* Loading of hid_multitouch. This is done from the kernel until we=
 come up
>> + * with a more robust solution. */
>> +static void hid_request_hid_mt_module_async(struct work_struct *wor=
k)
>> +{
>> + =A0 =A0 request_module("hid-multitouch");
>> +}
>> +
>> +static void hid_request_hid_mt_module(struct hid_device *dev)
>> +{
>> + =A0 =A0 dev->request_hid_mt_module =3D 1;
>> + =A0 =A0 INIT_WORK(&dev->request_hid_mt_module_wk,
>> + =A0 =A0 =A0 =A0 =A0 =A0 hid_request_hid_mt_module_async);
>
> This init would probably be better off as a static declaration; after
> all, we do not need one workqueue per hid device.
>
>> + =A0 =A0 schedule_work(&dev->request_hid_mt_module_wk);
>> +}
>> +
>> +static void hid_flush_request_modules(struct hid_device *dev)
>> +{
>> + =A0 =A0 flush_work_sync(&dev->request_hid_mt_module_wk);
>> +}
>> +#else
>> +#define hid_request_hid_mt_module(dev)
>> +#define hid_flush_request_modules(dev)
>> +#endif /* CONFIG_MODULES */
>> +
>> =A0int hid_connect(struct hid_device *hdev, unsigned int connect_mas=
k)
>> =A0{
>> =A0 =A0 =A0 static const char *types[] =3D { "Device", "Pointer", "M=
ouse", "Device",
>> @@ -1235,7 +1260,9 @@ int hid_connect(struct hid_device *hdev, unsig=
ned int connect_mask)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 connect_=
mask & HID_CONNECT_HIDINPUT_FORCE))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdev->claimed |=3D HID_CLAIMED_INPUT;
>> =A0 =A0 =A0 if (hdev->quirks & HID_QUIRK_MULTITOUCH) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* this device should be handled by hid-mu=
ltitouch, skip it */
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* this device should be handled by hid-mu=
ltitouch, request
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* for hid-multitouch to be loaded and l=
eave the device to it */
>> + =A0 =A0 =A0 =A0 =A0 =A0 hid_request_hid_mt_module(hdev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> =A0 =A0 =A0 }
>>
>> @@ -2107,6 +2134,8 @@ struct hid_device *hid_allocate_device(void)
>> =A0 =A0 =A0 INIT_LIST_HEAD(&hdev->debug_list);
>> =A0 =A0 =A0 sema_init(&hdev->driver_lock, 1);
>>
>> + =A0 =A0 hdev->request_hid_mt_module =3D 0;
>> +
>
> Allocated using kzalloc, so no need.
>
>> =A0 =A0 =A0 return hdev;
>> =A0err:
>> =A0 =A0 =A0 put_device(&hdev->dev);
>> @@ -2121,6 +2150,8 @@ static void hid_remove_device(struct hid_devic=
e *hdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hid_debug_unregister(hdev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdev->status &=3D ~HID_STAT_ADDED;
>> =A0 =A0 =A0 }
>> + =A0 =A0 if (hdev->request_hid_mt_module)
>> + =A0 =A0 =A0 =A0 =A0 =A0 hid_flush_request_modules(hdev);
>
> I would put the test inside the flush function instead, to restrict
> the use of the bare variables.
>
>> =A0}
>>
>> =A0/**
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index 3a95da6..0058ca9 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -538,6 +538,14 @@ struct hid_device { =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0/* device report descriptor */
>> =A0 =A0 =A0 struct dentry *debug_events;
>> =A0 =A0 =A0 struct list_head debug_list;
>> =A0 =A0 =A0 wait_queue_head_t debug_wait;
>> +
>> + =A0 =A0 /* This is a temporary fix to make hid-multitouch loadable=
 from
>> + =A0 =A0 =A0* the kernel before we come up with more robust solutio=
n
>> + =A0 =A0 =A0* (with userspace involvement).
>> + =A0 =A0 =A0* In case we detect a multitouch device through the par=
sing of
>> + =A0 =A0 =A0* hid-core, we request for hid-multitouch to be loaded.=
 */
>> + =A0 =A0 struct work_struct request_hid_mt_module_wk;
>> + =A0 =A0 bool request_hid_mt_module;
>
> This increases memory per hid device, which is not so nice. A static
> declaration in the core module ought to suffice. Probably needs
> additional locking as well.
>
>> =A0};
>>
>> =A0static inline void *hid_get_drvdata(struct hid_device *hdev)
>> --
>> 1.7.7.6
>>
>
> Thanks,
> Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
