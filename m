From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: Re: [PATCH] Input: Do not add SYN_REPORT in between a single packet data
Date: Fri, 3 Jun 2016 01:52:37 +0530
Message-ID: <CADYu30-T1bw1Wuoj_nbvTWjYDHnWokez8j5YJaBh4zwacvrNEg@mail.gmail.com>
References: <1462376571-4280-1-git-send-email-a.mathur@samsung.com>
	<CADYu30_21fFCswd3dCsaqUUg1fEVKBxazMPpSOURzNBA10UnSQ@mail.gmail.com>
	<CADYu308HQxPfq-C3ccS_n-=DO0xFdK9vr5XmyAx3kWeryKFfyA@mail.gmail.com>
	<20160512223159.GA12463@dtor-ws>
	<CADYu3093GqD6vNSq083uP85HmphKGxJ6wmrNN6AhoEnjZVPqqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35780 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593AbcFBUWi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Jun 2016 16:22:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id e3so18631999wme.2
        for <linux-input@vger.kernel.org>; Thu, 02 Jun 2016 13:22:38 -0700 (PDT)
In-Reply-To: <CADYu3093GqD6vNSq083uP85HmphKGxJ6wmrNN6AhoEnjZVPqqA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Aniroop Mathur <a.mathur@samsung.com>

Hello Mr. Torokhov,


On Fri, May 13, 2016 at 8:34 PM, Aniroop Mathur
<aniroop.mathur@gmail.com> wrote:
> On Fri, May 13, 2016 at 4:01 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> Hi Aniroop,
>>
>> On Fri, May 13, 2016 at 03:57:06AM +0530, Aniroop Mathur wrote:
>>> Hello Mr. Torokhov,
>>>
>>> Would you please help to update on the below patch?
>>> I have fixed the out of bound error which you mentioned last time.
>>> I have been really waiting for a long time. Please be kind to conclude it.
>>
>> I believe that this problem is a best theoretical and does not cause
>> issues with any of the drivers at present and therefore is not a
>> priority. Given that we already took quite a few iterations trying to
>> fix the issue without introducing worse regressions I'd like to leave
>> the code as is for now.
>>
>
> I agree that this part of code is not used by any driver so far but there
> are other factors to consider as well. There are many people in the
> world who develop concepts about kernel by reading the code as this
> is the best way to do so. If someone (especially beginners) read this
> part of code then he/she will learn wrong concept for SYN_REPORT
> event and "as more time passes more people will read this code
> and hence more will end up in a state of doubt whether it is correct to
> insert SYN_REPORT event in between a single packet or not?" This
> looks more dangerous to me.
> So to avoid that this code misguides someone now and in future, I
> believe it is very good reason to fix it. I believe that whether some
> driver uses it or not is a second concern and foremost concern is
> that code should follow protocol and should not mislead someone
> to develop wrong concepts.
>
> It happened many times that people needed more than 3 iterations
> to submit a patch so it looks normal to me that this patch too took 3
> iterations (especially when people are in the phase of learning kernel)
> and now the fix looks good to apply with no problems.
> I am sure you agree on the part that code review, code reading are
> best ways to learn concepts about kernel core and so kernel
> subsystem protocols should be given priority. Keeping this in mind,
> I request you again to kindly consider the patch for submission
> to fix this protocol part.
>
> Hope to hear positive reply from you. Have a good day!
>

How about above? Isn't this sufficient enough reason to fix this bug?

> Thanks,
> Aniroop Mathur
>> Thanks.
>>
>>>
>>> Thanks,
>>> Aniroop Mathur
>>>
>>> On Wed, May 11, 2016 at 7:40 PM, Aniroop Mathur
>>> <aniroop.mathur@gmail.com> wrote:
>>> > Hello Mr. Torokhov,
>>> >
>>> > Would you please provide update for this patch?
>>> > As you can notice it is really pending for a long time,
>>> > I'll be grateful if you could update and conclude it quickly.
>>> >
>>> > Thank you.
>>> >
>>> > BR,
>>> > Aniroop Mathur
>>> >
>>> >
>>> > On Wed, May 4, 2016 at 9:12 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
>>> >> As mentioned in documentation, SYN_REPORT should be used to separate two packets
>>> >> and should not be inserted in between a single packet as otherwise with multiple
>>> >> SYN_REPORT in a single packet, input reader would not be able to know when the
>>> >> packet ended really.
>>> >>
>>> >> Documentation snippet:
>>> >> * SYN_REPORT:
>>> >>   - Used to synchronize and separate events into packets of input data changes
>>> >>     occurring at the same moment in time. For example, motion of a mouse may set
>>> >>     the REL_X and REL_Y values for one motion, then emit a SYN_REPORT. The next
>>> >>     motion will emit more REL_X and REL_Y values and send another SYN_REPORT.
>>> >>
>>> >> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
>>> >> ---
>>> >>  drivers/input/input.c | 12 +++++++-----
>>> >>  1 file changed, 7 insertions(+), 5 deletions(-)
>>> >>
>>> >> diff --git a/drivers/input/input.c b/drivers/input/input.c
>>> >> index 8806059..5b0b1ae 100644
>>> >> --- a/drivers/input/input.c
>>> >> +++ b/drivers/input/input.c
>>> >> @@ -401,12 +401,14 @@ static void input_handle_event(struct input_dev *dev,
>>> >>                 if (dev->num_vals >= 2)
>>> >>                         input_pass_values(dev, dev->vals, dev->num_vals);
>>> >>                 dev->num_vals = 0;
>>> >> -       } else if (dev->num_vals >= dev->max_vals - 2) {
>>> >> -               dev->vals[dev->num_vals++] = input_value_sync;
>>> >> -               input_pass_values(dev, dev->vals, dev->num_vals);
>>> >> -               dev->num_vals = 0;
>>> >> +       } else if (dev->num_vals >= dev->max_vals - 1) {
>>> >> +               /* Pass all events except the newest event in order to
>>> >> +                * not suppress the immediate EV_SYN/SYN_REPORT event.
>>> >> +                */
>>> >> +               input_pass_values(dev, dev->vals, dev->num_vals - 1);
>>> >> +               dev->vals[0] = dev->vals[dev->num_vals - 1];
>>> >> +               dev->num_vals = 1;
>>> >>         }
>>> >> -
>>> >>  }
>>> >>
>>> >>  /**
>>> >> --
>>> >> 2.6.2
>>> >>
>>
>> --
>> Dmitry
