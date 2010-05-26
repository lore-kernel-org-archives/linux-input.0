From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 0/2] input: mt: Add EVIOC mechanism for MT slots
Date: Wed, 26 May 2010 08:59:35 -0700
Message-ID: <AANLkTimR3VN21URkandBGhPjWYdkdFP2zmAVscyRbqtW@mail.gmail.com>
References: <1274788379-11026-1-git-send-email-rydberg@euromail.se>
	 <20100525173446.GA4634@core.coreip.homeip.net>
	 <4BFC2A7D.50501@euromail.se>
	 <20100525202340.GD4455@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100525202340.GD4455@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>
List-Id: linux-input@vger.kernel.org

On Tue, May 25, 2010 at 1:23 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, May 25, 2010 at 09:52:29PM +0200, Henrik Rydberg wrote:
>> Dmitry Torokhov wrote:
>> > Hi Henrik,
>> >
>> > On Tue, May 25, 2010 at 01:52:57PM +0200, Henrik Rydberg wrote:
>> >> These patches are in response to the discussion about input state
>> >> retrieval.
>> >>
>> >> The current EVIOCGABS method does not work with MT slots. =A0Thes=
e
>> >> patches provides a mechanism where a slot is first selected via a=
 call
>> >> to EVIOCSABS, after which the corresponding MT events can be extr=
acted
>> >> with calls to EVIOCGABS.
>> >>
>> >> The symmetric operation, to set the MT state via EVIOCSABS, seems=
 to
>> >> violate input data integrity, and is therefore not implemented.
>> >>
>> >
>> > This looks sane, however the question remains - is there any users=
 for
>> > this data? Like I mentioned, I can see the need to fetch state of
>> > switches and ranges of absolute axis, and even non-multitouch ABS =
values
>> > (due to the fact that some input devices, like sliders, may stay i=
n a
>> > certain position for long periods of time), but I expect multitouc=
h data
>> > to be "refreshed" very quickly.
>> >
>> > Thanks.
>> >
>>
>> There were some voices addressing this issue, and the patches are he=
re,
>> available for whomever to pick up. Drop them if you wish, I will not=
 send them anew.
>>
>
> I'll save them in my queue but will hold off applying until I hear
> userspace folks requesting such functionality.

Hi Dmitry,

You do have a valid point - the (x,y) from a touch object would most
likely change all the time. Even if the object itself is in a steady
state on the digitizer, i.e., without any intentional movement, the
electronic noise would most likely lead to some (x,y) changes. So, the
chance that we need to retrieve (x,y) is rare.

However, it is possibe that when X driver starts, an object was
already on the digitizer. And the digitizer is of such a high quality
:), it filtered all the noises so we can not locate the touch without
a EVIOCGABS call.

Plus, from a pure coding/development point of view, it is not a bad
practice to provide the equivalent features for _MT_ support as we did
for the existing input devices. At least, it doesn't hurt to make the
support consistent across devices/tools (considering touch as a new
input device/tool).

Hope I didn't miss too much this round :).

Ping
