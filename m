From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 0/3] input: evdev: Dynamic buffers (rev4)
Date: Tue, 15 Jun 2010 11:43:13 +0200
Message-ID: <4C174B31.6040403@euromail.se>
References: <1275735869-2185-1-git-send-email-rydberg@euromail.se> <201006101211.51395.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:45215 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754605Ab0FOJn2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jun 2010 05:43:28 -0400
In-Reply-To: <201006101211.51395.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>

Dmitry Torokhov wrote:
> On Saturday, June 05, 2010 04:04:26 am Henrik Rydberg wrote:
>> Dmitry,
>>
>> Please find enclosed the fourth version of the evdev buffer patches.
>>
>> This version implements buffer locking using event_lock as you
>> suggested, such that we can proceed with fixing the evdev buffer
>> problem independently from providing a suitable one-to-many buffer.
>>
>> The first patch converts the per-client buffers to a common buffer,
>> and adds a fixme since the code is expected to be further
>> improved. The second and third patch includes your review comments.
> 
> Henrik,
> 
> Applied to .36 queue with minor adjustments, please take a peek in my
> 'for-linus' branch and see if you spot anything wrong.

We are talking about your tree @kernel.org, right? Nothing appeared there...

> The changes have
> been made with an eye of implementing a per-client event filters which
> would again require using private event queues (but only by clients that
> request filtering).

Would not having the separate reader tails suffice? Implementing the filtering
during client read?

> The desire for allowing event filtering in kernel is to avoid waking up
> HAL-ish processes (ones that only interested in certain special events, 
> like KEY_SUSPEND, KEY_WIFI, KEY_MUTE, etc) needlessly. Not sure if I am
> going to have time to actually implement it though, anyone wants to
> take a stab?

I see. Something like a lovely new ioctl() command, setting the evbits on a per
client basis?

Henrik

