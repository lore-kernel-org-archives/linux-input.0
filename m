From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 08/15] Input - wacom: remove usb dependency for siblings devices
Date: Fri, 11 Jul 2014 09:15:39 -0400
Message-ID: <CAN+gG=GJU-XyGke-HQK23BoRb3GfYH=aFJgHue982+zXjzzHFg@mail.gmail.com>
References: <1404163586-29582-1-git-send-email-benjamin.tissoires@redhat.com>
	<1404163586-29582-9-git-send-email-benjamin.tissoires@redhat.com>
	<CANRwn3TJtBVfhHYoX6oqzo4-tHTXairquATnVYQNzt9pEtmWSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:42756 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbaGKNPl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jul 2014 09:15:41 -0400
In-Reply-To: <CANRwn3TJtBVfhHYoX6oqzo4-tHTXairquATnVYQNzt9pEtmWSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxwacom-devel <linuxwacom-devel@lists.sourceforge.net>

On Thu, Jul 10, 2014 at 8:10 PM, Jason Gerecke <killertofu@gmail.com> w=
rote:
> On Mon, Jun 30, 2014 at 2:26 PM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>> Wacom tablets can share different physical sensors on one physical d=
evice.
>> These are called siblings in the code. The current way of implementa=
tion
>> relies on the USB topology to be able to share data amongs those sen=
sors.
>>
>> We can replace the code to match a HID subsystem, without involving =
the USB
>> topology:
>> - the first probed sensor does not find any siblings in the list
>>   wacom_udev_list, so it creates its own wacom_hdev_data with its ow=
n
>>   struct hid_device
>> - the other sensor checks the current list of siblings in wacom_hdev=
_data,
>>   and if there is a match, it associates itself to the matched devic=
e.
>>
>> To be sure that we are not associating different sensors from differ=
ent
>> physical devices, we also check for the phys path of the hid device =
which
>> contains the USB topology.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> ---
>>  drivers/input/tablet/wacom_sys.c | 75 +++++++++++++++++++----------=
-----------
>>  1 file changed, 35 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet=
/wacom_sys.c
>> index 0d0397d..6fe7a6c 100644
>> --- a/drivers/input/tablet/wacom_sys.c
>> +++ b/drivers/input/tablet/wacom_sys.c
>> @@ -488,46 +488,45 @@ static int wacom_retrieve_hid_descriptor(struc=
t hid_device *hdev,
>>         return error;
>>  }
>>
>> -struct wacom_usbdev_data {
>> +struct wacom_hdev_data {
>>         struct list_head list;
>>         struct kref kref;
>> -       struct usb_device *dev;
>> +       struct hid_device *dev;
>>         struct wacom_shared shared;
>>  };
>>
>>  static LIST_HEAD(wacom_udev_list);
>>  static DEFINE_MUTEX(wacom_udev_list_lock);
>>
>> -static struct usb_device *wacom_get_sibling(struct usb_device *dev,=
 int vendor, int product)
>> +static bool wacom_are_sibling(struct hid_device *hdev,
>> +               struct hid_device *sibling)
>>  {
>> -       int port1;
>> -       struct usb_device *sibling;
>> -
>> -       if (vendor =3D=3D 0 && product =3D=3D 0)
>> -               return dev;
>> -
>> -       if (dev->parent =3D=3D NULL)
>> -               return NULL;
>> -
>> -       usb_hub_for_each_child(dev->parent, port1, sibling) {
>> -               struct usb_device_descriptor *d;
>> -               if (sibling =3D=3D NULL)
>> -                       continue;
>> +       struct wacom *wacom =3D hid_get_drvdata(hdev);
>> +       struct wacom_features *features =3D &wacom->wacom_wac.featur=
es;
>> +       int vid =3D features->oVid;
>> +       int pid =3D features->oPid;
>>
>> -               d =3D &sibling->descriptor;
>> -               if (d->idVendor =3D=3D vendor && d->idProduct =3D=3D=
 product)
>> -                       return sibling;
>> +       if (vid =3D=3D 0 && pid =3D=3D 0) {
>> +               vid =3D hdev->vendor;
>> +               pid =3D hdev->product;
>>         }
>>
>> -       return NULL;
>> +       if (vid !=3D sibling->vendor || pid !=3D sibling->product)
>> +               return false;
>> +
>> +       /*
>> +        * Compare the physical path.
>> +        * Dump the last two chars which should contain the input nu=
mber.
>> +        */
>> +       return !strncmp(hdev->phys, sibling->phys, strlen(hdev->phys=
) - 2);
>
> Good idea, but this implementation doesn't work. "Siblings" (such as
> you'd find on a 24HDT) are separate USB devices but share the same US=
B
> hub. Trimming off just the input number isn't sufficient since the US=
B
> path preceding it is going to be different for the two devices. For
> example, I the touch and pen interfaces on my 24HDT show up as
> "usb-0000:00:1d.0-1.4.3/input0" and "usb-0000:00:1d.0-1.4.2/input1".

You are right. I thought I managed to make the 22HDT working with my
patches, but maybe I overlooked it

>
> Something like the following could work though:
>
> int n1 =3D strrchr(hdev->phys, '.') - hdev->phys;
> int n2 =3D strrchr(sibling->phys, '.') - sibling->phys;
> if (n1 !=3D n2 || n1 <=3D 0 || n2 <=3D 0)
>     return false;
> else
>     return !strncmp(hdev->phys, sibling->phys, n1);

Seems fair. I'll give a try and update the patches.

Thanks!

Cheers,
Benjamin

>
> Jason
> ---
> Now instead of four in the eights place /
> you=E2=80=99ve got three, =E2=80=98Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can=E2=80=99t take seven from three,    /
> So you look at the sixty-fours....
>
>>  }
>>
>> -static struct wacom_usbdev_data *wacom_get_usbdev_data(struct usb_d=
evice *dev)
>> +static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_devic=
e *hdev)
>>  {
>> -       struct wacom_usbdev_data *data;
>> +       struct wacom_hdev_data *data;
>>
>>         list_for_each_entry(data, &wacom_udev_list, list) {
>> -               if (data->dev =3D=3D dev) {
>> +               if (wacom_are_sibling(hdev, data->dev)) {
>>                         kref_get(&data->kref);
>>                         return data;
>>                 }
>> @@ -536,28 +535,29 @@ static struct wacom_usbdev_data *wacom_get_usb=
dev_data(struct usb_device *dev)
>>         return NULL;
>>  }
>>
>> -static int wacom_add_shared_data(struct wacom_wac *wacom,
>> -                                struct usb_device *dev)
>> +static int wacom_add_shared_data(struct hid_device *hdev)
>>  {
>> -       struct wacom_usbdev_data *data;
>> +       struct wacom *wacom =3D hid_get_drvdata(hdev);
>> +       struct wacom_wac *wacom_wac =3D &wacom->wacom_wac;
>> +       struct wacom_hdev_data *data;
>>         int retval =3D 0;
>>
>>         mutex_lock(&wacom_udev_list_lock);
>>
>> -       data =3D wacom_get_usbdev_data(dev);
>> +       data =3D wacom_get_hdev_data(hdev);
>>         if (!data) {
>> -               data =3D kzalloc(sizeof(struct wacom_usbdev_data), G=
=46P_KERNEL);
>> +               data =3D kzalloc(sizeof(struct wacom_hdev_data), GFP=
_KERNEL);
>>                 if (!data) {
>>                         retval =3D -ENOMEM;
>>                         goto out;
>>                 }
>>
>>                 kref_init(&data->kref);
>> -               data->dev =3D dev;
>> +               data->dev =3D hdev;
>>                 list_add_tail(&data->list, &wacom_udev_list);
>>         }
>>
>> -       wacom->shared =3D &data->shared;
>> +       wacom_wac->shared =3D &data->shared;
>>
>>  out:
>>         mutex_unlock(&wacom_udev_list_lock);
>> @@ -566,8 +566,8 @@ out:
>>
>>  static void wacom_release_shared_data(struct kref *kref)
>>  {
>> -       struct wacom_usbdev_data *data =3D
>> -               container_of(kref, struct wacom_usbdev_data, kref);
>> +       struct wacom_hdev_data *data =3D
>> +               container_of(kref, struct wacom_hdev_data, kref);
>>
>>         mutex_lock(&wacom_udev_list_lock);
>>         list_del(&data->list);
>> @@ -578,10 +578,10 @@ static void wacom_release_shared_data(struct k=
ref *kref)
>>
>>  static void wacom_remove_shared_data(struct wacom_wac *wacom)
>>  {
>> -       struct wacom_usbdev_data *data;
>> +       struct wacom_hdev_data *data;
>>
>>         if (wacom->shared) {
>> -               data =3D container_of(wacom->shared, struct wacom_us=
bdev_data, shared);
>> +               data =3D container_of(wacom->shared, struct wacom_hd=
ev_data, shared);
>>                 kref_put(&data->kref, wacom_release_shared_data);
>>                 wacom->shared =3D NULL;
>>         }
>> @@ -1311,8 +1311,6 @@ static int wacom_probe(struct hid_device *hdev=
,
>>                 "%s Pad", features->name);
>>
>>         if (features->quirks & WACOM_QUIRK_MULTI_INPUT) {
>> -               struct usb_device *other_dev;
>> -
>>                 /* Append the device type to the name */
>>                 if (features->device_type !=3D BTN_TOOL_FINGER)
>>                         strlcat(wacom_wac->name, " Pen", WACOM_NAME_=
MAX);
>> @@ -1321,10 +1319,7 @@ static int wacom_probe(struct hid_device *hde=
v,
>>                 else
>>                         strlcat(wacom_wac->name, " Pad", WACOM_NAME_=
MAX);
>>
>> -               other_dev =3D wacom_get_sibling(dev, features->oVid,=
 features->oPid);
>> -               if (other_dev =3D=3D NULL || wacom_get_usbdev_data(o=
ther_dev) =3D=3D NULL)
>> -                       other_dev =3D dev;
>> -               error =3D wacom_add_shared_data(wacom_wac, other_dev=
);
>> +               error =3D wacom_add_shared_data(hdev);
>>                 if (error)
>>                         goto fail1;
>>         }
>> --
>> 2.0.0
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
