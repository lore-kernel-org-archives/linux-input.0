From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gtco - fix potential out-of-bound access
Date: Wed, 25 Oct 2017 09:10:51 -0700
Message-ID: <20171025161051.kxdsmxhh2yx46ysv@dtor-ws>
References: <20171024052823.jpetpk2bfazfvfah@dtor-ws>
 <CAAeHK+y120RWP1GZPmtdtWCjsB=_hCKJkHN4QRhb_5QQpgV2xQ@mail.gmail.com>
 <20171024163943.gpkmpgexfuqe5vun@dtor-ws>
 <CAAeHK+xXPwKZwqoBM7afu1UcKbzz0hUYMPcGyGJ5nQhrZ0HdOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:52533 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdJYQKz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Oct 2017 12:10:55 -0400
Content-Disposition: inline
In-Reply-To: <CAAeHK+xXPwKZwqoBM7afu1UcKbzz0hUYMPcGyGJ5nQhrZ0HdOA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, Oct 25, 2017 at 12:33:38PM +0200, Andrey Konovalov wrote:
> On Tue, Oct 24, 2017 at 6:39 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Oct 24, 2017 at 01:04:03PM +0200, Andrey Konovalov wrote:
> >> On Tue, Oct 24, 2017 at 7:28 AM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > parse_hid_report_descriptor() has a while (i < length) loop, which
> >> > only guarantees that there's at least 1 byte in the buffer, but the
> >> > loop body can read multiple bytes which causes out-of-bounds access.
> >> >
> >> > Reported-by: Andrey Konovalov <andreyknvl@google.com>
> >> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> > ---
> >> >  drivers/input/tablet/gtco.c | 24 +++++++++++++++++-------
> >> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >> >
> >> > diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
> >> > index b796e891e2ee..0351203b8c24 100644
> >> > --- a/drivers/input/tablet/gtco.c
> >> > +++ b/drivers/input/tablet/gtco.c
> >> > @@ -230,13 +230,24 @@ static void parse_hid_report_descriptor(struct gtco *device, char * report,
> >> >
> >> >         /* Walk  this report and pull out the info we need */
> >> >         while (i < length) {
> >> > -               prefix = report[i];
> >> > -
> >> > -               /* Skip over prefix */
> >> > -               i++;
> >> > +               prefix = report[i++];
> >> >
> >> >                 /* Determine data size and save the data in the proper variable */
> >> > -               size = PREF_SIZE(prefix);
> >> > +               if (PREF_SIZE(prefix) < 1) {
> >>
> >> AFAIU PREF_SIZE(prefix) == 0 is a perfectly valid item data size.
> >
> > Fair enough. How about the below instead then?
> >
> > --
> > Dmitry
> >
> >
> > Input: gtco - fix potential out-of-bound access
> >
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> > parse_hid_report_descriptor() has a while (i < length) loop, which
> > only guarantees that there's at least 1 byte in the buffer, but the
> > loop body can read multiple bytes which causes out-of-bounds access.
> >
> > Reported-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/tablet/gtco.c |   17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
> > index b796e891e2ee..7d8e9fb831c4 100644
> > --- a/drivers/input/tablet/gtco.c
> > +++ b/drivers/input/tablet/gtco.c
> > @@ -230,13 +230,17 @@ static void parse_hid_report_descriptor(struct gtco *device, char * report,
> >
> >         /* Walk  this report and pull out the info we need */
> >         while (i < length) {
> > -               prefix = report[i];
> > -
> > -               /* Skip over prefix */
> > -               i++;
> > +               prefix = report[i++];
> >
> >                 /* Determine data size and save the data in the proper variable */
> > -               size = PREF_SIZE(prefix);
> > +               size = (1U << PREF_SIZE(prefix)) >> 1;
> > +               if (size && i + size >= length) {
> 
> I think this should be >, not >=, as when i + size == length, item
> data fits into the remaining space precisely. Also I don't see much
> point in checking that size is not 0, but I don't mind it.

Yes, you are right, I ma not sure why I thought that condition should be
greater or equal, not simply greater. I'll adjust this and drop the size
!= 0 check as it is definitely not needed with the updated condition.

I'll put you down as reviewed-by.

Thanks!

-- 
Dmitry
