From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] update my generaltouch driver for linux by luosong
Date: Wed, 02 Oct 2013 11:15:28 +0200
Message-ID: <524BE430.5070206@redhat.com>
References: <2013090912331785917915@generaltouch.com>,  <alpine.LNX.2.00.1309091500230.22174@pobox.suse.cz>,  <2013091011204090692411@generaltouch.com> <201309171015166098835@generaltouch.com>,  <52385770.1000604@redhat.com> <2013092515142828117311@generaltouch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43537 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963Ab3JBJQE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Oct 2013 05:16:04 -0400
In-Reply-To: <2013092515142828117311@generaltouch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: android <android@generaltouch.com>
Cc: jkosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

Hi Luosong,

ok, your mailer still sends emails as HTML, and it also mangles the
tabs, which is not good for the LKML.
The commit message is a little bit fuzzy and does not follow the kernel
rules. I'll send a followup patch correctly formatted so that we can al=
l
switch to something else.

Cheers,
Benjamin

On 25/09/13 09:14, Lamson_Luo wrote:
> Dear,Sir
> =20
> OK,I have modified some problems for this patch as follows:
> (1) I have used my real name ,my name is Luosong, my email is
> android@generaltouch.com <mailto:android@generaltouch.com>
> (2) I have sorted
> alphabetically the PID you are adding both in hid-multitouch,c and hi=
d-ids.h(0003
> to e100)
> (3) I have tested them in our products.
> =20
> In addition, I have added the patch into the attachment
> =20
> =20
> commit ef879474d31fbf671f1eadda1b618a606c28e680 Mon Sep 17 00:00:00 2=
001
> From: Luosong <android@generaltouch.com>
> Date: Wed, 25 Sep 2013 06:22:48 +0800
> Subject: [PATCH] "0101,e100,0102,0106,010a", these ID are our General=
Touch's
> new products change to "MT_QUIRK_SLOT_IS_CONTACTID",doing
> this is for correcting a bug for our GeneralTouch'products
> =20
> Signed-off-by: Luosong <android@generaltouch.com>
> =20
> ---
>  drivers/hid/hid-ids.h        |    5 +++++
>  drivers/hid/hid-multitouch.c |   19 +++++++++++++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> =20
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index e60e8d5..9a91dee 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -332,6 +332,11 @@
>  #define USB_VENDOR_ID_GENERAL_TOUCH 0x0dfc
>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS 0x0003
>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS 0x0100
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0101 0x0101
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0102 0x0102
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0106 0x0106
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
> =20
>  #define USB_VENDOR_ID_GLAB 0x06c2
>  #define USB_DEVICE_ID_4_PHIDGETSERVO_30 0x0038
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 5e5fe1b..cb3250c 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -250,12 +250,12 @@ static struct mt_class mt_classes[] =3D {
>   { .name =3D MT_CLS_GENERALTOUCH_TWOFINGERS,
>   .quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP |
>   MT_QUIRK_VALID_IS_INRANGE |
> - MT_QUIRK_SLOT_IS_CONTACTNUMBER,
> + MT_QUIRK_SLOT_IS_CONTACTID,
>   .maxcontacts =3D 2
>   },
>   { .name =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>   .quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP |
> - MT_QUIRK_SLOT_IS_CONTACTNUMBER
> + MT_QUIRK_SLOT_IS_CONTACTID
>   },
> =20
>   { .name =3D MT_CLS_FLATFROG,
> @@ -1173,6 +1173,21 @@ static const struct hid_device_id mt_devices[]=
 =3D {
>   { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>   MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>   USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS) },
> + { .driver_data =3D MT_CLS_GENERALTOUCH_TWOFINGERS,
> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0101) },
> + { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0102) },
> + { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0106) },
> + { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A) },
> + { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100) },
> =20
>   /* Gametel game controller */
>   { .driver_data =3D MT_CLS_NSMU,
> --=20
> 1.7.9.5
> =20
> *********************************************************************=
*************
> *********************************************************************=
*************************
>=20
> Hi,
> =20
> On 17/09/13 04:15, Lamson_Luo wrote:
>> Hi,Sir
>> I am sorry to trouble you .
>> =20
>> I want to ask you something about adding our GeneralTouch's patch
>> =20
>> is it OK?
> =20
> well, it is nearly ok:
> - I have nothing against the patch, regarding the fact that you are
> working for GeneralTouch and that I hope that you have tested it agai=
nst
> the new devices and the older ones.
> - small nitpick in the patch anyway, could you please just sort
> alphabetically the PID you are adding both in hid-multitouch,c and hi=
d-ids.h
> - your mail client continue to try to send your messages as HTML, whi=
ch
> are rejected by linux-input@vger...
> - you should inline the patch in the mail. The simplest way to do tha=
t
> is to use the commands "git format-patch" then "git send-email" which
> will do all the tedious work for you (or nearly)
> - the "from" field and your Signed-off-by is not compliant with the
> kernel rules:
> see "12) Sign your work" in the file Documentation/SubmittingPatches =
in
> the kernel tree (Jiri already pointed this link) The important part i=
s:
> "using your real name (sorry, no pseudonyms or anonymous contribution=
s.)"
> =20
>> or what should we do ?
> =20
> follow the rule number 10) in the previously mentioned document:
> "Don't get discouraged.  Re-submit."
> =20
>> =20
>> which linux version is it updated  in ?
> =20
> Given that Jiri is currently attending LPC in New Orleans, don't expe=
ct
> a very fast answer from him currently. Then, once it will land in his
> tree, it will be scheduled for the next Linux release (3.12 or 3.13),
> and Jiri may also submit it to stable if there are no conflicts (i.e.=
 in
> this case 3.10 and 3.11 I would say).
> =20
> Cheers,
> Benjamin
> =20
>> =20
>> =20
>> --------------------------------------------------------------------=
----
>> =A1=A1
>> =20
>> =20
>> Please feel free to contact me if you have any question.
>> Thanks & Best Regards
>>=20
>> Email: android@generaltouch.com <mailto:android@generaltouch.com>
>> R&D Department
>> GeneralTouch Technology Co., Ltd.
>> =20
>> *=B7=A2=BC=FE=C8=CB=A3=BA* Lamson_Luo <mailto:android@generaltouch.c=
om>
>> *=B7=A2=CB=CD=CA=B1=BC=E4=A3=BA* 2013-09-10 11:20
>> *=CA=D5=BC=FE=C8=CB=A3=BA* jkosina <mailto:jkosina@suse.cz>
>> *=B3=AD=CB=CD=A3=BA* linux-input <mailto:linux-input@vger.kernel.org=
>; Henrik
>> Rydberg <mailto:rydberg@euromail.se>; Benjamin Tissoires
>> <mailto:benjamin.tissoires@redhat.com>
>> *=D6=F7
> =CC=E2=A3=BA* Re: Re: [PATCH] update my generaltouch driver for linux=
 by luosong
>> Dear,Jiri Kosina
>> thanks for your reply
>> =20
>> for your message, my reply is as follows:
>> =20
>> 1)
>> On Mon, 9 Sep 2013, android wrote:
>> =20
>>> I am a software engineer from GeneralTouch Technology Co., Ltd.=20
>>>=20
>>> I want to add some driver patches to the linux kernel .
>>>=20
>>> I do these jobs in hid-ids.h and hid-multitouch.c
>> =20
>> Adding Henrik and Benjamon to CC for the hid-multitouch driver.
>> =20
>> [RE]:
>> yes,I added them.
>> but when I tried to send this mail to
>> linux-input(linux-input@vger.kernel.org ) ,I failed to do it.
>> the reference info is :
>> # host vger.kernel.org[209.132.180.67] said: 550 5.7.1 Content-Polic=
y
>> reject msg: The message contains HTML, therefore we consider it SPAM=
=2E
>> Send pure TEXT/PLAIN if you are not a spammer. BF:_; S1750878Ab3IIIl=
i
>> (in reply to end of DATA command) _
>>=20
>> 2)
>> =20
>>> The main changes in hid driver are like those:
>>> (1)add our new products into kernel driver
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0102 0x0102
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0101 0x0101
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0106 0x0106
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
>>> (2) correct previous bug=20
>>> - MT_QUIRK_SLOT_IS_CONTACTNUMBER
>>> + MT_QUIRK_SLOT_IS_CONTACTID
>> =20
>> This needs explanation / clarification in the changelog.
>> =20
>> =20
>> [RE]:
>>=20
>>     I will give you the reference changelog:
>>     =20
>>     commit 94e68a8c72e2dc300a08a751cd52d9a97cbb43ac
>>     Author: luosong <android@generaltouch.com>
>>     Date:   Tue Sep 10 02:04:46 2013 +0800
>>     =20
>>         hid-for-generaltouch
>>        =20
>>         "0101,e100,0102,0106,010a", these ID are our GeneralTouch's =
new products
>>         change to "MT_QUIRK_SLOT_IS_CONTACTID",doing this is for cor=
recting a bug for our GeneralTouch'products
>>         Signed-off-by:luosong android@generaltouch.com
>>     <mailto:android@generaltouch.com>
>>=20
>> =20
>> =20
>> =20
>> 3)
>>> the content of patch is shown below:
>>>=20
>>> From 5db217392e661695058606c7919be7fa6509f1e4 Mon Sep 17 00:00:00 2=
001
>>> From: luosong android@generaltouch.com
>> =20
>> This doesn't look like a RFC-compliant from, I think.
>> =20
>> [RE]:
>> I got the source by git tool ,I built a branch named
>> hid-for-generaltouch ,and  I also configured my username and mail.
>> =20
>> =20
>> =20
>> 4)
>>> Date: Mon, 9 Sep 2013 02:30:10 +0800
>>> Subject: [PATCH] update my generaltouch driver for linux by luosong
>> =20
>> Please insert changelog (description of the changes) and Signed-off-=
by:=20
>> line here, as documented in Documentation/SubmittingPatches
>> =20
>> =20
>> [RE]:
>>     "0101,e100,0102,0106,010a", these ID are our GeneralTouch's new =
products
>>     change to "MT_QUIRK_SLOT_IS_CONTACTID",doing this is for correct=
ing a bug for our GeneralTouch'products
>> =20
>> 5)
>>> ---
>>>  drivers/hid/hid-ids.h        |    5 +++++
>>>  drivers/hid/hid-multitouch.c |   19 +++++++++++++++++--
>>>  2 files changed, 22 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>>> index ffe4c7a..ca78f09 100644
>>> --- a/drivers/hid/hid-ids.h
>>> +++ b/drivers/hid/hid-ids.h
>>> @@ -332,6 +332,11 @@
>>>  #define USB_VENDOR_ID_GENERAL_TOUCH 0x0dfc
>>>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS 0x0003
>>>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS 0x0100
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0102 0x0102
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0101 0x0101
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0106 0x0106
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
>>>=20
>>>  #define USB_VENDOR_ID_GLAB 0x06c2
>>>  #define USB_DEVICE_ID_4_PHIDGETSERVO_30 0x0038
>>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multito=
uch.c
>>> index cb0e361..9558dde 100644
>>> --- a/drivers/hid/hid-multitouch.c
>>> +++ b/drivers/hid/hid-multitouch.c
>>> @@ -244,12 +244,12 @@ static struct mt_class mt_classes[] =3D {
>>>   { .name =3D MT_CLS_GENERALTOUCH_TWOFINGERS,
>>>   .quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP |
>>>   MT_QUIRK_VALID_IS_INRANGE |
>>> - MT_QUIRK_SLOT_IS_CONTACTNUMBER,
>>> + MT_QUIRK_SLOT_IS_CONTACTID,
>>>   .maxcontacts =3D 2
>>>   },
>>>   { .name =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>>>   .quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP |
>>> - MT_QUIRK_SLOT_IS_CONTACTNUMBER
>>> + MT_QUIRK_SLOT_IS_CONTACTID
>>>   },
>>>=20
>>>   { .name =3D MT_CLS_FLATFROG,
>>> @@ -1191,6 +1191,21 @@ static const struct hid_device_id mt_devices=
[] =3D {
>>>   { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>>>   MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>>>   USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS) },
>>> + { .driver_data =3D MT_CLS_GENERALTOUCH_TWOFINGERS,
>>> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>>> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0101) },
>>> + { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>>> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>>> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100) },
>>> + { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>>> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>>> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0102) },
>>> + { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>>> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>>> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0106) },
>>> + { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>>> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>>> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A) },
>> =20
>> Your mail client seems to be whitespace-corrupting patches (it ate t=
he=20
>> tabs at least).
>> =20
>> Could you please fix all the above and resubmit?
>> =20
>> [RE]:
>> I will send  some attachments to you=20
>> =20
>> =20
>> is it OK? if it is not right,could you help me to modify it?
>> =20
>> =20
>> =20
>> =20
>> =20
>> =20
>> *From:* Jiri Kosina <mailto:jkosina@suse.cz>
>> *Date:* 2013-09-09 21:04
>> *To:* android <mailto:android@generaltouch.com>
>> *CC:* linux-input <mailto:linux-input@vger.kernel.org>; Henrik Rydbe=
rg
>> <mailto:rydberg@euromail.se>; Benjamin Tissoires
>> <mailto:benjamin.tissoires@redhat.com>
>> *Subject:* Re: [PATCH] update my generaltouch driver for linux by lu=
osong
>> On Mon, 9 Sep 2013, android wrote:
>> =20
>>> I am a software engineer from GeneralTouch Technology Co., Ltd.=20
>>>=20
>>> I want to add some driver patches to the linux kernel .
>>>=20
>>> I do these jobs in hid-ids.h and hid-multitouch.c
>> =20
>> Adding Henrik and Benjamon to CC for the hid-multitouch driver.
>> =20
>>> The main changes in hid driver are like those:
>>> (1)add our new products into kernel driver
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0102 0x0102
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0101 0x0101
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0106 0x0106
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
>>> (2) correct previous bug=20
>>> - MT_QUIRK_SLOT_IS_CONTACTNUMBER
>>> + MT_QUIRK_SLOT_IS_CONTACTID
>> =20
>> This needs explanation / clarification in the changelog.
>> =20
>>> the content of patch is shown below:
>>>=20
>>> From 5db217392e661695058606c7919be7fa6509f1e4 Mon Sep 17 00:00:00 2=
001
>>> From: luosong android@generaltouch.com
>> =20
>> This doesn't look like a RFC-compliant from, I think.
>> =20
>>> Date: Mon, 9 Sep 2013 02:30:10 +0800
>>> Subject: [PATCH] update my generaltouch driver for linux by luosong
>> =20
>> Please insert changelog (description of the changes) and Signed-off-=
by:=20
>> line here, as documented in Documentation/SubmittingPatches
>> =20
>>> ---
>>>  drivers/hid/hid-ids.h        |    5 +++++
>>>  drivers/hid/hid-multitouch.c |   19 +++++++++++++++++--
>>>  2 files changed, 22 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>>> index ffe4c7a..ca78f09 100644
>>> --- a/drivers/hid/hid-ids.h
>>> +++ b/drivers/hid/hid-ids.h
>>> @@ -332,6 +332,11 @@
>>>  #define USB_VENDOR_ID_GENERAL_TOUCH 0x0dfc
>>>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS 0x0003
>>>  #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS 0x0100
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0102 0x0102
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0101 0x0101
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0106 0x0106
>>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
>>>=20
>>>  #define USB_VENDOR_ID_GLAB 0x06c2
>>>  #define USB_DEVICE_ID_4_PHIDGETSERVO_30 0x0038
>>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multito=
uch.c
>>> index cb0e361..9558dde 100644
>>> --- a/drivers/hid/hid-multitouch.c
>>> +++ b/drivers/hid/hid-multitouch.c
>>> @@ -244,12 +244,12 @@ static struct mt_class mt_classes[] =3D {
>>>   { .name =3D MT_CLS_GENERALTOUCH_TWOFINGERS,
>>>   .quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP |
>>>   MT_QUIRK_VALID_IS_INRANGE |
>>> - MT_QUIRK_SLOT_IS_CONTACTNUMBER,
>>> + MT_QUIRK_SLOT_IS_CONTACTID,
>>>   .maxcontacts =3D 2
>>>   },
>>>   { .name =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>>>   .quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP |
>>> - MT_QUIRK_SLOT_IS_CONTACTNUMBER
>>> + MT_QUIRK_SLOT_IS_CONTACTID
>>>   },
>>>=20
>>>   { .name =3D MT_CLS_FLATFROG,
>>> @@ -1191,6 +1191,21 @@ static const struct hid_device_id mt_devices=
[] =3D {
>>>   { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>>>   MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>>>   USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PWT_TENFINGERS) },
>>> + { .driver_data =3D MT_CLS_GENERALTOUCH_TWOFINGERS,
>>> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>>> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0101) },
>>> + { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>>> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>>> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100) },
>>> + { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>>> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>>> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0102) },
>>> + { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>>> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>>> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_0106) },
>>> + { .driver_data =3D MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
>>> + MT_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH,
>>> + USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A) },
>> =20
>> Your mail client seems to be whitespace-corrupting patches (it ate t=
he=20
>> tabs at least).
>> =20
>> Could you please fix all the above and resubmit?
>> =20
>> Thanks a lot,
>> =20
>> --=20
>> Jiri Kosina
>> SUSE Labs
>> =20
>> =20
> =20
> =20
> =20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
