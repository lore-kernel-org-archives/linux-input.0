From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] input : wacom - report resolution for ABS_MT events
Date: Fri, 28 Jan 2011 13:57:17 -0800
Message-ID: <AANLkTikUmajiTDxNzOKNznevdutnefO7CgTrBg8=rRCu@mail.gmail.com>
References: <1296179245-14614-1-git-send-email-pinglinux@gmail.com>
	<20110128173048.GC2586@polaris.bitmath.org>
	<AANLkTi=d7frmTyAPzRSPmgXkvDh-Lc=WCvu9+tdA1Sg8@mail.gmail.com>
	<20110128184654.GG6252@core.coreip.homeip.net>
	<AANLkTikgTYQvhTzEHWw0Yhigno7TLJ8jm9jaw10mOhk+@mail.gmail.com>
	<20110128193731.GH6252@core.coreip.homeip.net>
	<AANLkTi=31ckFhy28R30=64+BBmHkn43DA8js1b0pdoQ4@mail.gmail.com>
	<20110128205403.GI6252@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63619 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab1A1V5T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 16:57:19 -0500
Received: by wwa36 with SMTP id 36so3876043wwa.1
        for <linux-input@vger.kernel.org>; Fri, 28 Jan 2011 13:57:18 -0800 (PST)
In-Reply-To: <20110128205403.GI6252@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Fri, Jan 28, 2011 at 12:54 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>> >> > so I believe
>> >> > min, max and resultion should be reported on ABS_X, Y, X, etc, or, if
>> >> > you want to have this data in ABS_MT_POSITION, it should be trhe same.
>> >>
>> >> max/min is different from resolution. We can scale max/min since they
>> >> are logical data. But we can not change the device's physical size.
>> >> That's the root cause of the "stubborn" nature of resolution.
>> >
>> > This is the same device so it should have the same physical dimensions,
>> > right?
>>
>> No, pen and touch use different chips. They can have different sizes.
>
> It does not matter how many chips you have inside. What matters whether
> they share a working surface or not. If working surface is the same (and
> consequentially you have single input_dev structure) then dimensions are
> the same.

They do not always share the exact same surface. Most of the devices
do have the same working surface. But not all of them although the
differences are normally small. To represent a finger touch, it may
not be too big a deal. But, making the assumption that they are the
same size doesn't sound right.

Do we ignore that small imprecision? Or do I submit a version 2 (I'll
update Bamboo resolution with Henrik's scale in the same patch)?

Thank you.

Ping
