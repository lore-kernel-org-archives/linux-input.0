From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 2/3] HID: multitouch: use input_register callback
Date: Wed, 30 Nov 2011 15:56:49 +0100
Message-ID: <CAN+gG=FObDG8zj0VqswXvjPCfNdFOt3oNcZhgaanSQ89a4_WGw@mail.gmail.com>
References: <1322568792-4432-1-git-send-email-benjamin.tissoires@enac.fr>
	<1322568792-4432-3-git-send-email-benjamin.tissoires@enac.fr>
	<alpine.LNX.2.00.1111301534540.4648@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39157 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab1K3O4u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Nov 2011 09:56:50 -0500
In-Reply-To: <alpine.LNX.2.00.1111301534540.4648@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 30, 2011 at 15:37, Jiri Kosina <jkosina@suse.cz> wrote:
> On Tue, 29 Nov 2011, Benjamin Tissoires wrote:
>
>> Use the input_register mechanism to avoid a race in which the device
>> may emit events before the slots are ready.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
>> ---
>> =A0drivers/hid/hid-multitouch.c | =A0 37 ++++++++++++++++++++++++---=
----------
>> =A01 files changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitou=
ch.c
>> index 91c13bc..bd6e410 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -574,6 +574,29 @@ static void mt_set_input_mode(struct hid_device=
 *hdev)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static int mt_input_register(struct hid_device *hdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct hid_input *hidinput)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hdev);
>> +
>> + =A0 =A0 td->slots =3D kzalloc(td->maxcontacts * sizeof(struct mt_s=
lot),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL=
);
>> + =A0 =A0 if (!td->slots) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev, "cannot allocate multi=
touch slots\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D sysfs_create_group(&hdev->dev.kobj, &mt_attribute_=
group);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 hid_warn(hdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"can't create sysfs qui=
rks attribute err: %d\n", ret);
>> +
>> + =A0 =A0 mt_set_input_mode(hdev);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> =A0static int mt_probe(struct hid_device *hdev, const struct hid_dev=
ice_id *id)
>> =A0{
>> =A0 =A0 =A0 int ret, i;
>> @@ -610,19 +633,6 @@ static int mt_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>> =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>>
>> - =A0 =A0 td->slots =3D kzalloc(td->maxcontacts * sizeof(struct mt_s=
lot),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL=
);
>> - =A0 =A0 if (!td->slots) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&hdev->dev, "cannot allocate multi=
touch slots\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 hid_hw_stop(hdev);
>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto fail;
>> - =A0 =A0 }
>> -
>> - =A0 =A0 ret =3D sysfs_create_group(&hdev->dev.kobj, &mt_attribute_=
group);
>> -
>> - =A0 =A0 mt_set_input_mode(hdev);
>> -
>> =A0 =A0 =A0 return 0;
>>
>> =A0fail:
>> @@ -843,6 +853,7 @@ static struct hid_driver mt_driver =3D {
>> =A0 =A0 =A0 .input_mapping =3D mt_input_mapping,
>> =A0 =A0 =A0 .input_mapped =3D mt_input_mapped,
>> =A0 =A0 =A0 .feature_mapping =3D mt_feature_mapping,
>> + =A0 =A0 .input_register =3D mt_input_register,
>
> Umm, where does this come from? My memory is famous for not being rea=
lly
> excellent, but I don't immediately remember any patchset adding such
> callback to hid_driver struct.
>
> And it's not anywhere in my applied queue anyway.

Indeed, your memory is perfectly working: I had some hallucinations.
I was sure you accepted the following patch:
http://article.gmane.org/gmane.linux.kernel.input/21692

It was when Jaikumar Ganesh tried to fix a race in the init of hid-magi=
cmouse.

As the input_register callback is not queued, you can drop this.

Cheers,
Benjamin

>
>> =A0 =A0 =A0 .usage_table =3D mt_grabbed_usages,
>> =A0 =A0 =A0 .event =3D mt_event,
>> =A0#ifdef CONFIG_PM
>> --
>> 1.7.4.4
>>
>
> --
> Jiri Kosina
> SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
