From: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>
Subject: Re: [PATCH 1/1] Input: joydev - blacklist ds3/ds4/udraw motion
 sensors
Date: Tue, 17 Oct 2017 00:48:57 +0000
Message-ID: <1DD62093774CEE42AFC16E785A1088049E206CA3@USCULXMSG13.am.sony.com>
References: <20171006010333.61496-1-roderick@gaikai.com>
 <20171006010333.61496-2-roderick@gaikai.com>
 <20171007184453.GB14355@dtor-ws>
 <1DD62093774CEE42AFC16E785A1088049E200451@USCULXMSG13.am.sony.com>
 <20171013235044.thyp7bajww7j62pr@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2nam02on0132.outbound.protection.outlook.com ([104.47.38.132]:14144
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752442AbdJQAtG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 16 Oct 2017 20:49:06 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "roderick@gaikai.com" <roderick@gaikai.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

Hi Dmitry,=0A=
=0A=
I would like to confirm that the changes are working correctly. The code =
=0A=
looked code before, but hadn't validated the changes yet. We did so =0A=
today and things work accordingly, so I think it is ready to merge.=0A=
=0A=
Thanks for the help!=0A=
=0A=
Thanks,=0A=
Roderick=0A=
=0A=
=0A=
On 10/13/2017 04:50 PM, Dmitry Torokhov wrote:=0A=
> Hi Roderick,=0A=
> =0A=
> On Wed, Oct 11, 2017 at 12:53:53AM +0000, Colenbrander, Roelof wrote:=0A=
>> Hi Dmitry,=0A=
>>=0A=
>> Thanks for your suggestions the feedback looks good. Just got back to of=
fice after a long weekend, then was surprised to see you already made a few=
 changes to the series. The changes look. Thanks for the assistance!=0A=
>>=0A=
> =0A=
> OK, if that works for you then I will queue it up.=0A=
> =0A=
> Thanks.=0A=
> =0A=
>> Thanks,=0A=
>> Roderick=0A=
>> ________________________________________=0A=
>> From: Dmitry Torokhov [dmitry.torokhov@gmail.com]=0A=
>> Sent: Saturday, October 07, 2017 11:44 AM=0A=
>> To: roderick@gaikai.com=0A=
>> Cc: linux-input@vger.kernel.org; Benjamin Tissoires; Jiri Kosina; Colenb=
rander, Roelof; stable@vger.kernel.org=0A=
>> Subject: Re: [PATCH 1/1] Input: joydev - blacklist ds3/ds4/udraw motion =
sensors=0A=
>>=0A=
>> Hi Roderick,=0A=
>>=0A=
>> On Thu, Oct 05, 2017 at 06:03:33PM -0700, Roderick Colenbrander wrote:=
=0A=
>>> From: Roderick Colenbrander <roderick.colenbrander@sony.com>=0A=
>>>=0A=
>>> Introduce a device table used for blacklisting devices. We currently=0A=
>>> blacklist the motion sensor subdevice of THQ Udraw and Sony ds3/ds4.=0A=
>>>=0A=
>>> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>=
=0A=
>>> Cc: stable@vger.kernel.org=0A=
>>> ---=0A=
>>>   drivers/input/joydev.c | 57 +++++++++++++++++++++++++++++++++++++++++=
+++++++++=0A=
>>>   1 file changed, 57 insertions(+)=0A=
>>>=0A=
>>> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c=0A=
>>> index 29d677c714d2..e2a0f63d5656 100644=0A=
>>> --- a/drivers/input/joydev.c=0A=
>>> +++ b/drivers/input/joydev.c=0A=
>>> @@ -70,6 +70,40 @@ struct joydev_client {=0A=
>>>        struct list_head node;=0A=
>>>   };=0A=
>>>=0A=
>>> +/* These codes are copied from from hid-ids.h, unfortunately there is =
no common=0A=
>>> + * usb_ids/bt_ids.h header.=0A=
>>> + */=0A=
>>> +#define USB_VENDOR_ID_SONY 0x54c=0A=
>>> +#define USB_VENDOR_ID_THQ            0x20d6=0A=
>>> +#define USB_DEVICE_ID_SONY_PS3_CONTROLLER    0x0268=0A=
>>> +#define USB_DEVICE_ID_SONY_PS4_CONTROLLER    0x05c4=0A=
>>> +#define USB_DEVICE_ID_SONY_PS4_CONTROLLER_2  0x09cc=0A=
>>> +#define USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE     0x0ba0=0A=
>>> +#define USB_DEVICE_ID_THQ_PS3_UDRAW  0xcb17=0A=
>>> +=0A=
>>> +/* List of devices blacklisted from joydev. A reason for blacklisting =
a=0A=
>>> + * device is to support (legacy) software supporting joydev, but which=
 will=0A=
>>> + * never get updated to support these devices or features. An example =
would=0A=
>>> + * be handling of motion sensors, which these applications could not h=
andle=0A=
>>> + * resulting in undefined behavior.=0A=
>>> + */=0A=
>>> +static const struct joydev_blacklist {=0A=
>>> +     __u16 bustype;=0A=
>>> +     __u16 vendor;=0A=
>>> +     __u16 product;=0A=
>>> +     unsigned long propbit; /* Allow for filtering based on device pro=
perties. */=0A=
>>> +} joydev_blacklist[] =3D {=0A=
>>> +     { BUS_BLUETOOTH, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTR=
OLLER, BIT(INPUT_PROP_ACCELEROMETER) },=0A=
>>> +     { BUS_BLUETOOTH, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTR=
OLLER, BIT(INPUT_PROP_ACCELEROMETER) },=0A=
>>> +     { BUS_BLUETOOTH, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTR=
OLLER_2, BIT(INPUT_PROP_ACCELEROMETER) },=0A=
>>> +     { BUS_USB, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER,=
 BIT(INPUT_PROP_ACCELEROMETER) },=0A=
>>> +     { BUS_USB, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER,=
 BIT(INPUT_PROP_ACCELEROMETER) },=0A=
>>> +     { BUS_USB, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_=
2, BIT(INPUT_PROP_ACCELEROMETER) },=0A=
>>> +     { BUS_USB, USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_=
DONGLE, BIT(INPUT_PROP_ACCELEROMETER) },=0A=
>>> +     { BUS_USB, USB_VENDOR_ID_THQ, USB_DEVICE_ID_THQ_PS3_UDRAW, BIT(IN=
PUT_PROP_ACCELEROMETER) },=0A=
>>> +     { 0, 0, 0, 0}=0A=
>>=0A=
>> I would assume that regardless of connection (USB, BT, SPI, I2C, the=0A=
>> accelerometer in PS4 controller should not be handled by joydev.  I=0A=
>> wonder if we should not factor out input device id matching from=0A=
>> input_match_device(), add propbit handling to input device id and use it=
=0A=
>> here? Then your blacklist would be:=0A=
>>=0A=
>> #define ACCEL_DEV(vendor, product)                              \=0A=
>>          {                                                              =
 \=0A=
>>                  .flags          =3D INPUT_DEVICE_ID_MATCH_VENDOR |     =
   \=0A=
>>                                          INPUT_DEVICE_ID_MATCH_PRODUCT |=
 \=0A=
>>                                          INPUT_DEVICE_ID_MATCH_PROPBIT, =
 \=0A=
>>                  .vendor         =3D (vendor),                          =
   \=0A=
>>                  .product        =3D (product),                         =
   \=0A=
>>                  .propbit[0]     =3D BIT(INPUT_PROP_ACCELEROMETER),     =
   \=0A=
>>          }=0A=
>>=0A=
>> static const struct input_device_id joydev_blacklist {=0A=
>>          ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER=
),=0A=
>>          ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER=
),=0A=
>>          ...=0A=
>>          { }=0A=
>> };=0A=
>>=0A=
>>> +};=0A=
>>> +=0A=
>>>   static int joydev_correct(int value, struct js_corr *corr)=0A=
>>>   {=0A=
>>>        switch (corr->type) {=0A=
>>> @@ -805,6 +839,25 @@ static bool joydev_dev_is_absolute_mouse(struct in=
put_dev *dev)=0A=
>>>        return true;=0A=
>>>   }=0A=
>>>=0A=
>>> +=0A=
>>> +static bool joydev_dev_is_blacklisted(struct input_dev *dev)=0A=
>>> +{=0A=
>>> +     int i;=0A=
>>> +=0A=
>>> +     for (i =3D 0; joydev_blacklist[i].vendor; i++) {=0A=
>>> +             if (dev->id.bustype =3D=3D joydev_blacklist[i].bustype &&=
=0A=
>>> +                 dev->id.vendor =3D=3D joydev_blacklist[i].vendor &&=
=0A=
>>> +                 dev->id.product =3D=3D joydev_blacklist[i].product &&=
=0A=
>>> +                 dev->propbit[0] =3D=3D joydev_blacklist[i].propbit)=
=0A=
>>=0A=
>> You probably want "&" and not strict match?=0A=
>>=0A=
>>> +             {=0A=
>>> +                     dev_info(&dev->dev, "joydev: Blacklisting '%s'\n"=
, dev->name);=0A=
>>> +                     return true;=0A=
>>> +             }=0A=
>>> +     }=0A=
>>> +=0A=
>>> +     return false;=0A=
>>> +}=0A=
>>> +=0A=
>>>   static bool joydev_match(struct input_handler *handler, struct input_=
dev *dev)=0A=
>>>   {=0A=
>>>        /* Avoid touchpads and touchscreens */=0A=
>>> @@ -819,6 +872,10 @@ static bool joydev_match(struct input_handler *han=
dler, struct input_dev *dev)=0A=
>>>        if (joydev_dev_is_absolute_mouse(dev))=0A=
>>>                return false;=0A=
>>>=0A=
>>> +     /* Disable blacklisted devices */=0A=
>>> +     if (joydev_dev_is_blacklisted(dev))=0A=
>>> +             return false;=0A=
>>> +=0A=
>>>        return true;=0A=
>>>   }=0A=
>>>=0A=
>>> --=0A=
>>> 2.13.6=0A=
>>>=0A=
>>=0A=
>> Thanks.=0A=
>>=0A=
>> --=0A=
>> Dmitry=0A=
>>=0A=
> =0A=
=0A=
