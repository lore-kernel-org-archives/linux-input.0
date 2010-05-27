From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 0/2] input: mt: Add EVIOC mechanism for MT slots
Date: Thu, 27 May 2010 15:59:37 -0700
Message-ID: <AANLkTimbs_8uAMMS2KuXodgTcHAs_vWJgYhDblUPY1jU@mail.gmail.com>
References: <1274788379-11026-1-git-send-email-rydberg@euromail.se>
	<20100525173446.GA4634@core.coreip.homeip.net>
	<4BFC2A7D.50501@euromail.se>
	<20100525202340.GD4455@core.coreip.homeip.net>
	<AANLkTimR3VN21URkandBGhPjWYdkdFP2zmAVscyRbqtW@mail.gmail.com>
	<20100527070310.GC17625@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100527070310.GC17625@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>
List-Id: linux-input@vger.kernel.org

On Thu, May 27, 2010 at 12:03 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, May 26, 2010 at 08:59:35AM -0700, Ping Cheng wrote:
>> On Tue, May 25, 2010 at 1:23 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Tue, May 25, 2010 at 09:52:29PM +0200, Henrik Rydberg wrote:
>> >> Dmitry Torokhov wrote:
>> >> > Hi Henrik,
>> >> >
>> >> > On Tue, May 25, 2010 at 01:52:57PM +0200, Henrik Rydberg wrote:
>> >> >> These patches are in response to the discussion about input st=
ate
>> >> >> retrieval.
>> >> >>
>> >> >> The current EVIOCGABS method does not work with MT slots. =A0T=
hese
>> >> >> patches provides a mechanism where a slot is first selected vi=
a a call
>> >> >> to EVIOCSABS, after which the corresponding MT events can be e=
xtracted
>> >> >> with calls to EVIOCGABS.
>> >> >>
>> >> >> The symmetric operation, to set the MT state via EVIOCSABS, se=
ems to
>> >> >> violate input data integrity, and is therefore not implemented=
=2E
>> >> >>
>> >> >
>> >> > This looks sane, however the question remains - is there any us=
ers for
>> >> > this data? Like I mentioned, I can see the need to fetch state =
of
>> >> > switches and ranges of absolute axis, and even non-multitouch A=
BS values
>> >> > (due to the fact that some input devices, like sliders, may sta=
y in a
>> >> > certain position for long periods of time), but I expect multit=
ouch data
>> >> > to be "refreshed" very quickly.
>> >> >
>> >> > Thanks.
>> >> >
>> >>
>> >> There were some voices addressing this issue, and the patches are=
 here,
>> >> available for whomever to pick up. Drop them if you wish, I will =
not send them anew.
>> >>
>> >
>> > I'll save them in my queue but will hold off applying until I hear
>> > userspace folks requesting such functionality.
>>
>> Hi Dmitry,
>>
>> You do have a valid point - the (x,y) from a touch object would most
>> likely change all the time. Even if the object itself is in a steady
>> state on the digitizer, i.e., without any intentional movement, the
>> electronic noise would most likely lead to some (x,y) changes. So, t=
he
>> chance that we need to retrieve (x,y) is rare.
>>
>> However, it is possibe that when X driver starts, an object was
>> already on the digitizer. And the digitizer is of such a high qualit=
y
>> :), it filtered all the noises so we can not locate the touch withou=
t
>> a EVIOCGABS call.
>>
>> Plus, from a pure coding/development point of view, it is not a bad
>> practice to provide the equivalent features for _MT_ support as we d=
id
>> for the existing input devices. At least, it doesn't hurt to make th=
e
>> support consistent across devices/tools (considering touch as a new
>> input device/tool).
>
> Ping,
>
> I did not say that there was a problem with the patch, I agree with i=
t.
> However if no one using this - why should we bother? Will _you_ utili=
ze
> this functionality in Wacom X driver? If so let me know and I will me=
rge
> it.

tbh, I can not say that I will need it in my X driver for sure. But I
vote for it to be merged.

Thank you for placing me in such an important position :).

Ping
