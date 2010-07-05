From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH] hid-magicmouse: Correct parsing of large X and Y motions.
Date: Mon, 05 Jul 2010 16:33:06 -0400
Message-ID: <87wrt9acu5.fsf@troilus.org>
References: <878w5qaspq.fsf@troilus.org>
	<AANLkTim9R0ur7r2Y3r3bOMIRSM7JYVcZdGZ0QMaYvK4X@mail.gmail.com>
	<1278360120.2425.97.camel@cndougla>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51068 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754895Ab0GEUdN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Jul 2010 16:33:13 -0400
Received: by mail-qw0-f53.google.com with SMTP id 8so1962244qwj.40
        for <linux-input@vger.kernel.org>; Mon, 05 Jul 2010 13:33:08 -0700 (PDT)
In-Reply-To: <1278360120.2425.97.camel@cndougla> (Chase Douglas's message of
	"Mon, 05 Jul 2010 16:02:00 -0400")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Chase Douglas writes:

> On Tue, 2010-07-06 at 03:54 +0800, Ping Cheng wrote:
>> On Mon, Jul 5, 2010 at 10:50 PM, Michael Poole <mdpoole@troilus.org> wrote:
>> > The X and Y values have two more significant bits in the same byte
>> > that contains click status.  Include these in the reported value.
>> > Thanks to Iain Hibbert of NetBSD for pointing this out.
>> >
>> > Signed-off-by: Michael Poole <mdpoole@troilus.org>
>> > ---
>> >  drivers/hid/hid-magicmouse.c |    4 ++--
>> >  1 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
>> > index 0b89c1c..7cdda23 100644
>> > --- a/drivers/hid/hid-magicmouse.c
>> > +++ b/drivers/hid/hid-magicmouse.c
>> > @@ -267,8 +267,8 @@ static int magicmouse_raw_event(struct hid_device *hdev,
>> >                 * to have the current touch information before
>> >                 * generating a click event.
>> >                 */
>> > -               x = (signed char)data[1];
>> > -               y = (signed char)data[2];
>> > +               x = (int)(((data[3] & 0x0c) << 28) | (data[1] << 22)) >> 22;
>> > +               y = (int)(((data[3] & 0x30) << 26) | (data[2] << 22)) >> 22;
>> 
>> Will the following give us the same result?
>> 
>>  +               x = (int)(((data[3] & 0x0c) << 6) | data[1]);
>>  +               y = (int)(((data[3] & 0x30) << 4) | data[2]);
>
> I thought about this too, but there's a sign extension issue. If the X
> coordinate is -1 (these are relative coordinates), then you will end up
> with (int)(1023), which is no longer -1.
>
> When you shift to the right, the bits are sign-extended. Thus, shifting
> everything to the most significant bit of an integer, and then shifting
> everything back to the least significant will properly sign extend.
>
> (I actually wrote a test program just to verify this)
>
> That's just a reason for the shifts. There very well could be a more
> elegant solution.

C99 says that the result of right-shifting a negative value is
compiler-defined.  gcc documents that it ensures sign extension.  Other
parts of hid-magicmouse.c use this idiom already.  The corresponding
idiom in hid-core.c (see the snto32() function) would look something
like this:

      x = ((data[3] & 0x0c) << 6) | data[1];
      x |= (x & (1 << 9)) ? (-1 << 10) : 0;

Which do people find more readable?  Is the more portable behavior of
this idiom preferred over requiring sign extension by the compiler?

Michael Poole
