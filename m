From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] input: mt: Add an envelope tool type
Date: Wed, 08 Dec 2010 10:38:55 -0800
Message-ID: <4CFFD0BF.2020601@canonical.com>
References: <1291721340-22652-1-git-send-email-rydberg@euromail.se> <4CFFC3C2.1080905@canonical.com> <4CFFCD10.5030202@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CFFCD10.5030202@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 12/08/2010 10:23 AM, Henrik Rydberg wrote:
>>> This patch represents an MT solution for those devices that can detect
> 
>>> and report some effects of dual touch, but cannot report individual
>>> contacts. Synaptics and elantech are two examples. Having the drivers
>>> report the bounding rectangle of the touches is useful in userland,
>>> since the information makes it possible to implement zooming
>>> gestures. At the same time, it would be confusing to send these
>>> envelope points as fingers, since they clearly are not. As a remedy,
>>> introduce MT_TOOL_ENVELOPE, which tells applications that care about
>>> details that these are not real fingers, at the same time as it allows
>>> gesture applications based on MT data to function without
>>> modification.
>>
>> Is it assumed that the envelop has only two touches comprising it? Or is
>> it any number of touches? If it's any number of touches, how does one
>> know how many touches it is?
> 
> 
> It could be any number of points, although, as you say, the exact semantics of
> multiple points have not yet been defined/documented. Traditionally, a convex
> hull is defined as a sequence of points, such that the last links to the first.
> It makes sense to define the envelope points similarly. However, we can pass
> that bridge as we get there. Right now, we have use for the two-point case. The
> number is determined the same was as for fingers - count the number of active slots.

Ahh. That leaves me with two thoughts:

1. A real convex hull would imply that the points given are correct.
This is the fundamental issue with these touchpads though, and I feel
envelope semantics would only help solve a different problem: touch
object shape.

As you noted, what we are really interested here is a bounding
rectangle. I think Ping has said that Wacom could provide something that
is similar to a real convex hull, and mixing the two concepts together
could cause another ambiguity like BTN_TOOL_DOUBLETAP :).

I suggest merely renaming this to MT_TOOL_RECT to avoid confusion.

2. We could provide for multiple simultaneous rects by using the value
of the MT_TOOL_RECT property. The first rect would have value 0, the
second would have value 1, etc. I don't know if this will ever be used
since most devices will have real MT soon enough, but it wouldn't hurt
to define this.

-- Chase
