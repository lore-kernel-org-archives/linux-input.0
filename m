From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH v3] HID: wacom: Improve generic name generation
Date: Thu, 29 Jun 2017 08:35:48 -0700
Message-ID: <CANRwn3SndCWUdRyP54r7turG7u7-FiiTeR=czyCsE4h+fZh_8g@mail.gmail.com>
References: <20170628211921.5638-1-killertofu@gmail.com> <20170629141021.GG26073@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33074 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753396AbdF2Pfu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Jun 2017 11:35:50 -0400
Received: by mail-vk0-f66.google.com with SMTP id 82so5921092vki.0
        for <linux-input@vger.kernel.org>; Thu, 29 Jun 2017 08:35:49 -0700 (PDT)
In-Reply-To: <20170629141021.GG26073@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On June 29, 2017 7:10:21 AM PDT, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>Hi Jason,
>
>On Jun 28 2017 or thereabouts, Jason Gerecke wrote:
>> The 'wacom_update_name' function is responsible for producing names
>for
>> the input device nodes based on the hardware device name. Commit
>f2209d4
>> added the ability to strip off prefixes like "Wacom Co.,Ltd." where
>the
>> prefix was immediately (and redundantly) followed by "Wacom". The
>> 2nd-generation Intuos Pro 2 has such a prefix, but with a small error
>> (the period and comma are swapped) that prevents the existing code
>from
>> matching it. We're loath to extend the number of cases out endlessly
>and
>> so instead try to be smarter about name generation.
>>
>> We observe that the cause of the redundant prefixes is HID combining
>the
>> manufacturer and product strings of USB devices together. By using
>the
>> original product name (with "Wacom" prefixed, if it does not already
>> exist in the string) we can bypass the gyrations to find and remove
>> redundant prefixes. Other devices either don't have a manufacturer
>string
>> that needs to be removed (Bluetooth, uhid) or should have their name
>> generated from scratch (I2C).
>>
>
>Sorry for nitpicking, but I have a couple of comments:
>

Might as well get the patch right :)

>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>> ---
>> Changes from v2:
>>  * Use export/extern to directly gain access to the usb_hid_driver
>struct
>>    for comparison to ll_driver (rather than scanning through the list
>of
>>    USB devices for a matching parent).
>>
>>  drivers/hid/usbhid/hid-core.c |  1 +
>>  drivers/hid/wacom_sys.c       | 60
>+++++++++++++++++++++----------------------
>>  2 files changed, 30 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/hid/usbhid/hid-core.c
>b/drivers/hid/usbhid/hid-core.c
>> index 83772fa7d92a..4a7a306995a9 100644
>> --- a/drivers/hid/usbhid/hid-core.c
>> +++ b/drivers/hid/usbhid/hid-core.c
>> @@ -1269,6 +1269,7 @@ static struct hid_ll_driver usb_hid_driver =3D {
>>   .output_report =3D usbhid_output_report,
>>   .idle =3D usbhid_idle,
>>  };
>> +EXPORT_SYMBOL_GPL(usb_hid_driver);
>
>I would rather see this in a separate commit (in case we need to revert
>this one, we shouldn't revert the export).
>

Ack. Left it here momentarily to keep mail noise down while the review
process chugs along :)

>>
>>  static int usbhid_probe(struct usb_interface *intf, const struct
>usb_device_id *id)
>>  {
>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
>> index 0022c0dac88a..94d493c724c8 100644
>> --- a/drivers/hid/wacom_sys.c
>> +++ b/drivers/hid/wacom_sys.c
>> @@ -22,6 +22,8 @@
>>  #define DEV_ATTR_WO_PERM (S_IWUSR | S_IWGRP)
>>  #define DEV_ATTR_RO_PERM (S_IRUSR | S_IRGRP)
>>
>> +extern struct hid_ll_driver usb_hid_driver;
>
>Ouch. I'd rather see that one in drivers/hid/usbhid/usbhid.h
>
>I would like also to have the following in usbhid.h, that you can reuse
>later in the patch:
>static inline bool hid_is_using_usbhid(struct hid_device *hdev)
>{
> return hdev->ll_driver =3D=3D &usb_hid_driver;
>}
>

As I mentioned earlier, our input-wacom driver can't access usbhid.h.
I don't imagine a patch to make usbhid.h public would be accepted, and
I am strongly against requiring our users to have a copy of their
distro's full kernel source tree (not just development headers) merely
to compile our driver. Certainly we could create our own definition of
`hid_is_using_usbhid` within input-wacom which only uses
otherwise-public functions, but it'd be a hack that we'd have to
maintain indefinitely. I'm looking to create a patch which can work
both upstream and downstream (hence my earlier awkward
`wacom_is_real_usb` function that used only public functions).

Would it be reasonable to define `hid_is_using_usbhid` within hid.h
instead? I'm guessing the answer is "no" since the function is
transport-specific, but knowing what specific ll_driver is in use /is/
something useful to any HID driver...

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one /
(That is to say, eight) to the two, /
But you can=E2=80=99t take seven from three, /
So you look at the sixty-fours....

>
>> +
>>  static int wacom_get_report(struct hid_device *hdev, u8 type, u8
>*buf,
>>      size_t size, unsigned int retries)
>>  {
>> @@ -2026,41 +2028,37 @@ static void wacom_update_name(struct wacom
>*wacom, const char *suffix)
>>
>>   /* Generic devices name unspecified */
>>   if ((features->type =3D=3D HID_GENERIC) && !strcmp("Wacom HID",
>features->name)) {
>> - if (strstr(wacom->hdev->name, "Wacom") ||
>> -    strstr(wacom->hdev->name, "wacom") ||
>> -    strstr(wacom->hdev->name, "WACOM")) {
>> - /* name is in HID descriptor, use it */
>> - strlcpy(name, wacom->hdev->name, sizeof(name));
>> -
>> - /* strip out excess whitespaces */
>> - while (1) {
>> - char *gap =3D strstr(name, "  ");
>> - if (gap =3D=3D NULL)
>> - break;
>> - /* shift everything including the terminator */
>> - memmove(gap, gap+1, strlen(gap));
>> - }
>> + char *product_name =3D wacom->hdev->name;
>>
>> - /* strip off excessive prefixing */
>> - if (strstr(name, "Wacom Co.,Ltd. Wacom ") =3D=3D name) {
>> - int n =3D strlen(name);
>> - int x =3D strlen("Wacom Co.,Ltd. ");
>> - memmove(name, name+x, n-x+1);
>> - }
>> - if (strstr(name, "Wacom Co., Ltd. Wacom ") =3D=3D name) {
>> - int n =3D strlen(name);
>> - int x =3D strlen("Wacom Co., Ltd. ");
>> - memmove(name, name+x, n-x+1);
>> - }
>> + if (wacom->hdev->ll_driver =3D=3D &usb_hid_driver) {
>> + struct usb_interface *intf =3D
>to_usb_interface(wacom->hdev->dev.parent);
>> + struct usb_device *dev =3D interface_to_usbdev(intf);
>> + product_name =3D dev->product;
>> + }
>>
>> - /* get rid of trailing whitespace */
>> - if (name[strlen(name)-1] =3D=3D ' ')
>> - name[strlen(name)-1] =3D '\0';
>> + if (wacom->hdev->bus =3D=3D BUS_I2C) {
>> + snprintf(name, sizeof(name), "%s %X",
>> + features->name, wacom->hdev->product);
>> + } else if (strstr(product_name, "Wacom") ||
>> +   strstr(product_name, "wacom") ||
>> +   strstr(product_name, "WACOM")) {
>> + strlcpy(name, product_name, sizeof(name));
>>   } else {
>> - /* no meaningful name retrieved. use product ID */
>> - snprintf(name, sizeof(name),
>> - "%s %X", features->name, wacom->hdev->product);
>> + snprintf(name, sizeof(name), "Wacom %s", product_name);
>>   }
>> +
>> + /* strip out excess whitespaces */
>> + while (1) {
>> + char *gap =3D strstr(name, "  ");
>> + if (gap =3D=3D NULL)
>> + break;
>> + /* shift everything including the terminator */
>> + memmove(gap, gap+1, strlen(gap));
>> + }
>> +
>> + /* get rid of trailing whitespace */
>> + if (name[strlen(name)-1] =3D=3D ' ')
>> + name[strlen(name)-1] =3D '\0';
>>   } else {
>>   strlcpy(name, features->name, sizeof(name));
>>   }
>> --
>> 2.13.1
>>
>
>Rest looks good to me.
>
>Cheers,
>Benjamin
