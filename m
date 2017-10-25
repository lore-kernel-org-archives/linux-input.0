From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH] Input: gtco - fix potential out-of-bound access
Date: Wed, 25 Oct 2017 12:33:38 +0200
Message-ID: <CAAeHK+xXPwKZwqoBM7afu1UcKbzz0hUYMPcGyGJ5nQhrZ0HdOA@mail.gmail.com>
References: <20171024052823.jpetpk2bfazfvfah@dtor-ws> <CAAeHK+y120RWP1GZPmtdtWCjsB=_hCKJkHN4QRhb_5QQpgV2xQ@mail.gmail.com>
 <20171024163943.gpkmpgexfuqe5vun@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:54022 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932385AbdJYKdj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Oct 2017 06:33:39 -0400
Received: by mail-oi0-f65.google.com with SMTP id h6so42165893oia.10
        for <linux-input@vger.kernel.org>; Wed, 25 Oct 2017 03:33:39 -0700 (PDT)
In-Reply-To: <20171024163943.gpkmpgexfuqe5vun@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Oct 24, 2017 at 6:39 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Oct 24, 2017 at 01:04:03PM +0200, Andrey Konovalov wrote:
>> On Tue, Oct 24, 2017 at 7:28 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > parse_hid_report_descriptor() has a while (i < length) loop, which
>> > only guarantees that there's at least 1 byte in the buffer, but the
>> > loop body can read multiple bytes which causes out-of-bounds access.
>> >
>> > Reported-by: Andrey Konovalov <andreyknvl@google.com>
>> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> > ---
>> >  drivers/input/tablet/gtco.c | 24 +++++++++++++++++-------
>> >  1 file changed, 17 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
>> > index b796e891e2ee..0351203b8c24 100644
>> > --- a/drivers/input/tablet/gtco.c
>> > +++ b/drivers/input/tablet/gtco.c
>> > @@ -230,13 +230,24 @@ static void parse_hid_report_descriptor(struct gtco *device, char * report,
>> >
>> >         /* Walk  this report and pull out the info we need */
>> >         while (i < length) {
>> > -               prefix = report[i];
>> > -
>> > -               /* Skip over prefix */
>> > -               i++;
>> > +               prefix = report[i++];
>> >
>> >                 /* Determine data size and save the data in the proper variable */
>> > -               size = PREF_SIZE(prefix);
>> > +               if (PREF_SIZE(prefix) < 1) {
>>
>> AFAIU PREF_SIZE(prefix) == 0 is a perfectly valid item data size.
>
> Fair enough. How about the below instead then?
>
> --
> Dmitry
>
>
> Input: gtco - fix potential out-of-bound access
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> parse_hid_report_descriptor() has a while (i < length) loop, which
> only guarantees that there's at least 1 byte in the buffer, but the
> loop body can read multiple bytes which causes out-of-bounds access.
>
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/tablet/gtco.c |   17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
> index b796e891e2ee..7d8e9fb831c4 100644
> --- a/drivers/input/tablet/gtco.c
> +++ b/drivers/input/tablet/gtco.c
> @@ -230,13 +230,17 @@ static void parse_hid_report_descriptor(struct gtco *device, char * report,
>
>         /* Walk  this report and pull out the info we need */
>         while (i < length) {
> -               prefix = report[i];
> -
> -               /* Skip over prefix */
> -               i++;
> +               prefix = report[i++];
>
>                 /* Determine data size and save the data in the proper variable */
> -               size = PREF_SIZE(prefix);
> +               size = (1U << PREF_SIZE(prefix)) >> 1;
> +               if (size && i + size >= length) {

I think this should be >, not >=, as when i + size == length, item
data fits into the remaining space precisely. Also I don't see much
point in checking that size is not 0, but I don't mind it.

> +                       dev_err(ddev,
> +                               "Not enough data (need %d, have %d)\n",
> +                               i + size, length);
> +                       break;
> +               }
> +
>                 switch (size) {
>                 case 1:
>                         data = report[i];
> @@ -244,8 +248,7 @@ static void parse_hid_report_descriptor(struct gtco *device, char * report,
>                 case 2:
>                         data16 = get_unaligned_le16(&report[i]);
>                         break;
> -               case 3:
> -                       size = 4;
> +               case 4:
>                         data32 = get_unaligned_le32(&report[i]);
>                         break;
>                 }
>
>
