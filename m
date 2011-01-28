From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [RFC 1/2] input: mt: Add method to extract the MT slot state
Date: Fri, 28 Jan 2011 19:10:34 +0100
Message-ID: <AANLkTikM-DguswOb6Hv5jgkrirfFf+MHTJgK_Xk45gz5@mail.gmail.com>
References: <1296124547-3323-1-git-send-email-benjamin.tissoires@enac.fr>
	<1296124547-3323-2-git-send-email-benjamin.tissoires@enac.fr>
	<20110127120603.GB15626@polaris.bitmath.org>
	<AANLkTim7DbxhEO7vHPFcC1PFf=d2mSEyL+wurzUQa0pg@mail.gmail.com>
	<20110128173355.GD2586@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110128173355.GD2586@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, Jiri Kosina <jkosina@suse.cz>, Chris Bagwell <chris@cnpbagwell.com>, Rafi Rubin <rafi@seas.upenn.edu>, Stephane Chatty <chatty@lii-enac.fr>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 28, 2011 at 18:33, Henrik Rydberg <rydberg@euromail.se> wrote:
> On Thu, Jan 27, 2011 at 01:49:18PM +0100, Benjamin Tissoires wrote:
>> Hi Henrik,
>>
>> On Thu, Jan 27, 2011 at 13:06, Henrik Rydberg <rydberg@euromail.se> wrote:
>> > Hi Benjamin,
>> >
>> > On Thu, Jan 27, 2011 at 11:35:46AM +0100, Benjamin Tissoires wrote:
>> >> This patch adds the function input_mt_get_abs_value(), which may be
>> >
>> > Ehm, input_mt_get_absinfo?
>>
>> In fact, the idea was to put this on the table again ;). I have no
>> idea of what is the right think to do in such case.
>> So I'll take all comments.
>>
>> >
>> >> used to extract the current state of the MT slots.
>> >>
>> >> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
>> >
>> > I had rather re-add this myself, thanks.
>>
>> That was my question. Plus I had a subliminal message in which I
>> intend you to take the drive on this work. ;)
>
> Thanks for the patches, Benjamin, perhaps they do need a bit of
> rewrite or a new ioctl. We will see what happens.
>

Today  I found a bug in these 2 patches: they send garbage with
devices that use protocol A.
This is definitely a bad idea to send the input_absinfo.

In addition to that, using the original behavior (which seems better)
does not seems to add sth in regard to input_mt_get_value.
It would just add some guards that can be resumed in just a test:
(code >= ABS_MT_FIRST && code <= ABS_MT_LAST && dev->mt &&
	slot >= 0 && slot < dev->mtsize)

Henrik, if you want to introduce the new IOCTL, feel free, I don't
need it right now.

Cheers,
Benjamin
