From: Anshul Garg <aksgarg1989@gmail.com>
Subject: Re: [PATCH] Input: Use for_each_set_bit where appropriate
Date: Thu, 9 Jul 2015 23:47:35 +0530
Message-ID: <CA+HOOsj5VJnh8X=_pAy6guhUY1qxvpGdZGfhvK_j5FPau3JX9Q@mail.gmail.com>
References: <aksgarg1989@gmail.com>
	<1436449261-66742-1-git-send-email-aksgarg1989@gmail.com>
	<20150709172630.GA1237@dtor-ws>
	<CA+HOOsg0pM2OohoJFKFkyS09x_1kZNu9FAkjLSLfUmkDHi47Yw@mail.gmail.com>
	<20150709181415.GC1237@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36343 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbbGISRg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2015 14:17:36 -0400
Received: by qkei195 with SMTP id i195so191413807qke.3
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2015 11:17:36 -0700 (PDT)
In-Reply-To: <20150709181415.GC1237@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello Mr. Dmitry ,

udev->tail change i have not tested.
i have suggested this change for sole optimization purpose.

Yes this "udev->tail = (udev->tail + 1) & (UINPUT_BUFFER_SIZE - 1);"
should be code.


On Thu, Jul 9, 2015 at 11:44 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Jul 09, 2015 at 11:05:57PM +0530, Anshul Garg wrote:
>> Hello Mr. Dmitry ,
>>
>>
>>
>> On Thu, Jul 9, 2015 at 10:56 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Thu, Jul 09, 2015 at 06:41:01AM -0700, Anshul Garg wrote:
>> >> Use for_each_set_bit to check for set bits in bitmap
>> >> as it is more efficient and compact.
>> >> Also use bitwise and instead of expensive %
>> >> operation while fetching next event.
>> >
>> > It is not expensive if we are using a constant that is carefully
>> > selected (and it is).
>> >
>> Ok i understood now.
>> >>
>> >> Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
>> >> ---
>> >>  drivers/input/misc/uinput.c |   11 ++++-------
>> >>  1 file changed, 4 insertions(+), 7 deletions(-)
>> >>
>> >> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
>> >> index 421e29e..a3c15ad 100644
>> >> --- a/drivers/input/misc/uinput.c
>> >> +++ b/drivers/input/misc/uinput.c
>> >> @@ -319,11 +319,8 @@ static int uinput_validate_absbits(struct input_dev *dev)
>> >>       /*
>> >>        * Check if absmin/absmax/absfuzz/absflat are sane.
>> >>        */
>> >> -
>> >> -     for (cnt = 0; cnt < ABS_CNT; cnt++) {
>> >> +     for_each_set_bit(cnt, dev->absbit, ABS_CNT) {
>> >>               int min, max;
>> >> -             if (!test_bit(cnt, dev->absbit))
>> >> -                     continue;
>> >>
>> >>               min = input_abs_get_min(dev, cnt);
>> >>               max = input_abs_get_max(dev, cnt);
>> >> @@ -415,8 +412,8 @@ static int uinput_setup_device(struct uinput_device *udev,
>> >>       dev->id.vendor  = user_dev->id.vendor;
>> >>       dev->id.product = user_dev->id.product;
>> >>       dev->id.version = user_dev->id.version;
>> >> -
>> >> -     for (i = 0; i < ABS_CNT; i++) {
>> >> +
>> >> +     for_each_set_bit(i, dev->absbit, ABS_CNT) {
>> >>               input_abs_set_max(dev, i, user_dev->absmax[i]);
>> >>               input_abs_set_min(dev, i, user_dev->absmin[i]);
>> >>               input_abs_set_fuzz(dev, i, user_dev->absfuzz[i]);
>> >> @@ -493,7 +490,7 @@ static bool uinput_fetch_next_event(struct uinput_device *udev,
>> >>       have_event = udev->head != udev->tail;
>> >>       if (have_event) {
>> >>               *event = udev->buff[udev->tail];
>> >> -             udev->tail = (udev->tail + 1) % UINPUT_BUFFER_SIZE;
>> >> +             udev->tail &= UINPUT_BUFFER_SIZE - 1;
>> >
>> > What is this exactly? And how did you test it?
>> >
>> > This chunk dropped form the patch.
>> >
>> Rest changes are using  for_each_set_bit instead of for loop which
>> checks every bit in absbit bitmap.
>
> I understand what the rest of the changes are doing. My comment was
> regarding the very last chunk and I wondered how exactly you tested you
> changes because it is obviously broken as it no longer advances the
> tail.
>
> The proper way (if you wanted to switch to bitwise and) would be to do:
>
>         udev->tail = (udev->tail + 1) & (UINPUT_BUFFER_SIZE - 1);
>
> Thanks.
>
> --
> Dmitry
