From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 1/5] Input: wacom - Allow any multi-input Intuos device to
 set prox
Date: Mon, 1 Oct 2012 10:09:24 -0700
Message-ID: <CANRwn3Qjx75e5tXu0bSredFOrscYJ2SuWZ+myU=866Aa0tTzmQ@mail.gmail.com>
References: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
	<CAF8JNhKrkbLCTLUpsWJVCbgtdaDSYa1S7tdH=KHi=LXXc2Ac7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45552 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab2JARJZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Oct 2012 13:09:25 -0400
Received: by weyt9 with SMTP id t9so3056780wey.19
        for <linux-input@vger.kernel.org>; Mon, 01 Oct 2012 10:09:24 -0700 (PDT)
In-Reply-To: <CAF8JNhKrkbLCTLUpsWJVCbgtdaDSYa1S7tdH=KHi=LXXc2Ac7w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, chris@cnpbagwell.com

On Fri, Sep 28, 2012 at 2:18 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> On Thu, Sep 6, 2012 at 3:53 PM, Jason Gerecke <killertofu@gmail.com> wrote:
>> The ability to set the proximity flag should apply to any device
>> that has both pen and touch input. Rather than listing classes of
>> devices known to meet this criteria, simply filter on the quirk
>> defining all such devices.
>>
>> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
>
> Tested-by: Ping Cheng <pingc@wacom.com> for the whole set.
>
> Dmitry, do you have questions about this patchset and "input: wacom:
> Report correct touch contact size for I5/Bamboo"? We hope they can be
> merged soon since we have more patches coming.
>
> Thank you.
>
> Ping
>
The 24HD touch patches from September 6th as well ("Input: wacom - Add
touch sensor support for Cintiq 24HD touch"). I was hoping to get them
accepted before yesterday's 3.7 merge window opened.

Jason

---
When you're rife with devastation / There's a simple explanation:
You're a toymaker's creation / Trapped inside a crystal ball.
And whichever way he tilts it / Know that we must be resilient
We won't let them break our spirits / As we sing our silly song.

>> ---
>>  drivers/input/tablet/wacom_wac.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
>> index 532d067..a8bc6c9 100644
>> --- a/drivers/input/tablet/wacom_wac.c
>> +++ b/drivers/input/tablet/wacom_wac.c
>> @@ -326,7 +326,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
>>
>>         /* Enter report */
>>         if ((data[1] & 0xfc) == 0xc0) {
>> -               if (features->type >= INTUOS5S && features->type <= INTUOS5L)
>> +               if (features->quirks == WACOM_QUIRK_MULTI_INPUT)
>>                         wacom->shared->stylus_in_proximity = true;
>>
>>                 /* serial number of the tool */
>> @@ -414,7 +414,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
>>
>>         /* Exit report */
>>         if ((data[1] & 0xfe) == 0x80) {
>> -               if (features->type >= INTUOS5S && features->type <= INTUOS5L)
>> +               if (features->quirks == WACOM_QUIRK_MULTI_INPUT)
>>                         wacom->shared->stylus_in_proximity = false;
>>
>>                 /*
>> --
>> 1.7.12
>>
