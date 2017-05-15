From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom: Improve generic name generation
Date: Mon, 15 May 2017 12:55:00 -0700
Message-ID: <CAF8JNhLVSZLBVV2Zj2sYtn8y9VcsGcMPGSw=31dy9dnsPOLPyQ@mail.gmail.com>
References: <20170328211531.4641-1-killertofu@gmail.com> <20170329073032.GJ4009@mail.corp.redhat.com>
 <26c7a863-f013-0961-9ec9-d351a4dd02ec@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35681 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966534AbdEOTzW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 15 May 2017 15:55:22 -0400
Received: by mail-oi0-f67.google.com with SMTP id m17so47316oik.2
        for <linux-input@vger.kernel.org>; Mon, 15 May 2017 12:55:21 -0700 (PDT)
In-Reply-To: <26c7a863-f013-0961-9ec9-d351a4dd02ec@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Fri, Mar 31, 2017 at 9:17 AM, Jason Gerecke <killertofu@gmail.com> wrote=
:
> On 03/29/2017 12:30 AM, Benjamin Tissoires wrote:
>> On Mar 28 2017 or thereabouts, Jason Gerecke wrote:
>>> The 'wacom_update_name' function is responsible for producing names for
>>> the input device nodes based on the hardware device name. Commit f2209d=
4
>>> added the ability to strip off prefixes like "Wacom Co.,Ltd." where the
>>> prefix was immediately (and redundantly) followed by "Wacom". The
>>> 2nd-generation Intuos Pro 2 has such a prefix, but with a small error
>>> (the period and comma are swapped) that prevents the existing code from
>>> matching it. We're loath to extend the number of cases out endlessly an=
d
>>> so instead try to be smarter about name generation.
>>>
>>> We observe that the cause of the redundant prefixes is HID combining th=
e
>>> manufacturer and product strings of USB devices together. By using the
>>> original product name (with "Wacom" prefixed, if it does not already
>>> exist in the string) we can bypass the gyrations to find and remove
>>> redundant prefixes. For devices connected by other busses, the problem
>>> either doesn't exist (e.g. BUS_BLUETOOTH) or the name should be replace=
d
>>> with a generic one entirely (e.g. BUS_I2C, BUS_INTEL_ISHTP).
>>
>> Ouch. I hope Wacom doesn't plan on using BUS_INTEL_ISHTP for new devices
>> :)
>>
>
> Just me parroting bus names at random. Perhaps BUS_INTEL_ISHTP wasn't a
> great example ;)
>
>>>
>>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>>> ---
>>>  drivers/hid/wacom_sys.c | 65 +++++++++++++++++++++++++----------------=
--------
>>>  1 file changed, 33 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
>>> index 037b9c04745a..ad5d8722fa84 100644
>>> --- a/drivers/hid/wacom_sys.c
>>> +++ b/drivers/hid/wacom_sys.c
>>> @@ -2026,41 +2026,42 @@ static void wacom_update_name(struct wacom *wac=
om, const char *suffix)
>>>
>>>      /* Generic devices name unspecified */
>>>      if ((features->type =3D=3D HID_GENERIC) && !strcmp("Wacom HID", fe=
atures->name)) {
>>> -            if (strstr(wacom->hdev->name, "Wacom") ||
>>> -                strstr(wacom->hdev->name, "wacom") ||
>>> -                strstr(wacom->hdev->name, "WACOM")) {
>>> -                    /* name is in HID descriptor, use it */
>>> -                    strlcpy(name, wacom->hdev->name, sizeof(name));
>>> -
>>> -                    /* strip out excess whitespaces */
>>> -                    while (1) {
>>> -                            char *gap =3D strstr(name, "  ");
>>> -                            if (gap =3D=3D NULL)
>>> -                                    break;
>>> -                            /* shift everything including the terminat=
or */
>>> -                            memmove(gap, gap+1, strlen(gap));
>>> -                    }
>>> +            char *product_name =3D NULL;
>>>
>>> -                    /* strip off excessive prefixing */
>>> -                    if (strstr(name, "Wacom Co.,Ltd. Wacom ") =3D=3D n=
ame) {
>>> -                            int n =3D strlen(name);
>>> -                            int x =3D strlen("Wacom Co.,Ltd. ");
>>> -                            memmove(name, name+x, n-x+1);
>>> -                    }
>>> -                    if (strstr(name, "Wacom Co., Ltd. Wacom ") =3D=3D =
name) {
>>> -                            int n =3D strlen(name);
>>> -                            int x =3D strlen("Wacom Co., Ltd. ");
>>> -                            memmove(name, name+x, n-x+1);
>>> -                    }
>>> +            if (wacom->hdev->bus =3D=3D BUS_USB) {
>>> +                    struct usb_interface *intf =3D to_usb_interface(wa=
com->hdev->dev.parent);
>>> +                    struct usb_device *dev =3D interface_to_usbdev(int=
f);
>>> +                    product_name =3D dev->product;
>>
>> This will break uhid emulated devices in a very bad way (oops).
>> How about you either add a stub to get the product name from the
>> low-level driver, or simply add 2 pointers to strings to store the
>> product_name and the vendor_name in struct hid_device?
>>
>
> Good call on the uhid emulation. I'll write up an alternate patch as
> suggested. Do you have any particular preference either way? I suppose
> the former would be more amenable to the extra credit, but...

Since Benjamin didn't have a preference (he didn't reply so I assumed
the answer ;), I think you can update the patch with your own choice.

>
>> Bonus point if you let hid-core decide on the name based on the vendor
>> ID with a table of commonly used companies. hid-core could also clean up
>> the product name so you won't have to do it in each HID driver.
>> The choice of using a weird name for I2C devices was a lazy one from me,
>> and I am starting to hope for something better in the future.
>>
>> Cheers,
>> Benjamin
>>
>
> ...I probably won't go for the extra-credit here. Our driver seems to be
> pretty unique in how it tries to prettify the vendor; others either
> replace the name wholesale (like we do in the non-generic codepath) or
> just append suffixes where necessary.

I agree. I don't think it is necessary to touch hid-core.

Cheers,
Ping

>
> Jason
> ---
> Now instead of four in the eights place /
> you=E2=80=99ve got three, =E2=80=98Cause you added one /
> (That is to say, eight) to the two, /
> But you can=E2=80=99t take seven from three, /
> So you look at the sixty-fours....
>
>>> +            }
>>> +            else if (wacom->hdev->bus =3D=3D BUS_BLUETOOTH) {
>>> +                    product_name =3D wacom->hdev->name;
>>> +            }
>>>
>>> -                    /* get rid of trailing whitespace */
>>> -                    if (name[strlen(name)-1] =3D=3D ' ')
>>> -                            name[strlen(name)-1] =3D '\0';
>>> -            } else {
>>> -                    /* no meaningful name retrieved. use product ID */
>>> -                    snprintf(name, sizeof(name),
>>> -                             "%s %X", features->name, wacom->hdev->pro=
duct);
>>> +            if (!product_name) {
>>> +                    snprintf(name, sizeof(name), "%s %X",
>>> +                             features->name, wacom->hdev->product);
>>>              }
>>> +            else if (strstr(product_name, "Wacom") ||
>>> +                     strstr(product_name, "wacom") ||
>>> +                     strstr(product_name, "WACOM")) {
>>> +                    strlcpy(name, product_name, sizeof(name));
>>> +            }
>>> +            else {
>>> +                    snprintf(name, sizeof(name), "Wacom %s", product_n=
ame);
>>> +            }
>>> +
>>> +            /* strip out excess whitespaces */
>>> +            while (1) {
>>> +                    char *gap =3D strstr(name, "  ");
>>> +                    if (gap =3D=3D NULL)
>>> +                            break;
>>> +                    /* shift everything including the terminator */
>>> +                    memmove(gap, gap+1, strlen(gap));
>>> +            }
>>> +
>>> +            /* get rid of trailing whitespace */
>>> +            if (name[strlen(name)-1] =3D=3D ' ')
>>> +                    name[strlen(name)-1] =3D '\0';
>>>      } else {
>>>              strlcpy(name, features->name, sizeof(name));
>>>      }
>>> --
>>> 2.12.0
>>>
