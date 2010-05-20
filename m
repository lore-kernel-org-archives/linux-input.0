From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev2)
Date: Wed, 19 May 2010 21:18:36 -0700
Message-ID: <AANLkTinAQ4ygkcX_4D_Lbi-eLbbghdSXlLzH3HZBhDou@mail.gmail.com>
References: <1274213429-22667-1-git-send-email-rydberg@euromail.se>
	 <1274213429-22667-2-git-send-email-rydberg@euromail.se>
	 <AANLkTikpmYwEYh5Dh-p3478cDMVo9hXOsDkt54ltHW6J@mail.gmail.com>
	 <4BF4756C.8030204@seas.upenn.edu>
	 <AANLkTinLNuyDDR0ISjOcXDatdXWEN4RIyuXc-3aSz2b3@mail.gmail.com>
	 <4BF48198.4090300@seas.upenn.edu>
	 <AANLkTik3wNaTCh5JBI7A69QWh9RXvZo0UcuoZ-rQTDlz@mail.gmail.com>
	 <4BF48A4E.4060807@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:44030 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab0ETESo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 00:18:44 -0400
In-Reply-To: <4BF48A4E.4060807@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Michael Poole <mdpoole@troilus.org>

On Wed, May 19, 2010 at 6:03 PM, Rafi Rubin <rafi@seas.upenn.edu> wrote=
:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 05/19/10 20:51, Ping Cheng wrote:
>> On Wed, May 19, 2010 at 5:26 PM, Rafi Rubin <rafi@seas.upenn.edu> wr=
ote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> On 05/19/10 20:13, Ping Cheng wrote:
>>>> On Wed, May 19, 2010 at 4:34 PM, Rafi Rubin <rafi@seas.upenn.edu> =
wrote:
>>>>> My understanding is that it would be more like
>>>>> + =A0 SYN_MT_SLOT 0
>>>>> + =A0 ABS_MT_POSITION_X x
>>>>> + =A0 ABS_MT_POSITION_Y y
>>>>> + =A0 SYN_REPORT
>>>>> + =A0 SYN_MT_SLOT 0
>>>>> + =A0 ABS_MT_POSITION_X x
>>>>> + =A0 ABS_MT_POSITION_Y y
>>>>> + =A0 SYN_REPORT
>>>>> + =A0 SYN_MT_SLOT 0
>>>>> + =A0 ABS_MT_POSITION_X x
>>>>> + =A0 ABS_MT_POSITION_Y y
>>>>> + =A0 SYN_MT_SLOT 1
>>>>> + =A0 ABS_MT_POSITION_X x
>>>>> + =A0 ABS_MT_POSITION_Y y
>>>>> + =A0 SYN_REPORT
>>>>
>>>> You are right if one slot only has or is only allowed to have one
>>>> point. My scenario is that one slot can have more than one point.
>>>> Basically, my intention is to utilize the MT_SLOT and MT_TRACKING_=
ID
>>>> in such a way that it avoids as much overlap as possible.
>>>>
>>>> And hopefully it makes sesne in the reality too.
>>>
>>> Please clarify by what you mean by more than one point.
>>
>> I might have been confused myself by ABS_MT_BLOB_ID and SYN_MT_SLOT
>> here. =A0What I meant by "more than one point" is a contact (or touc=
h, I
>> am not sure which one is the right term :) is represented by a few
>> (x,y) coordinates. Maybe we should use SYN_MT_SLOT for my case?

The last sentence above should be "Maybe we should NOT use SYN_MT_SLOT
for my case?" or "Maybe I should use MT_BLOB_ID for that case?". A
typical typo for those whose hands are slower than their brains :).

>>> I may be misunderstanding, but I thought that these slots are basic=
ally a
>>> superior replacement to tracking id.
>>>
>>> one finger -> one slot
>>
>> This is what I needed to understand. Is slot for one (x,y) only or c=
an
>> it also be used for more than one set of (x,y)?
>>
>>> But with slots we can use the filtering that input provides, which =
we've been
>>> by-passing with the existing MT protocol (at least that's what I th=
ink Henrik's
>>> goal is).
>>
>> Good to know that filtering has already been considered. I know I mu=
st
>> be out of sync with Henrik's goal. =A0That's why I wanted to show my
>> ignorance :).
>>
>> Ping
>>
>
> Hey, sometimes Mark Twain's old advice is good, and sometimes its not=
=2E
>
> It's better to keep your mouth shut and be thought a fool than to ope=
n it and
> leave no doubt. --Mark Twain
>
>
> I think this is definitely a case where he's wrong. =A0We need to syn=
c up so that
> we're all implementing the same protocol, and can move on to the next
> interesting problem.

I hope this is the common goal for everyone who has been involved in
the _MT_ support.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
