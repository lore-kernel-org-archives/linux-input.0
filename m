From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH 0/3] input: evdev: Dynamic buffers (rev4)
Date: Wed, 16 Jun 2010 18:17:10 +0200
Message-ID: <4C18F906.5060805@bitmath.org>
References: <1275735869-2185-1-git-send-email-rydberg@euromail.se> <201006101211.51395.dmitry.torokhov@gmail.com> <alpine.LRH.2.00.1006161645380.2497@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp3.one.com ([91.198.169.23]:57211 "EHLO csmtp3.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750Ab0FPQRN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jun 2010 12:17:13 -0400
In-Reply-To: <alpine.LRH.2.00.1006161645380.2497@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>

Jiri Kosina wrote:
> On Thu, 10 Jun 2010, Dmitry Torokhov wrote:
> 
>>> This version implements buffer locking using event_lock as you
>>> suggested, such that we can proceed with fixing the evdev buffer
>>> problem independently from providing a suitable one-to-many buffer.
>>>
>>> The first patch converts the per-client buffers to a common buffer,
>>> and adds a fixme since the code is expected to be further
>>> improved. The second and third patch includes your review comments.
>> Henrik,
>>
>> Applied to .36 queue with minor adjustments, please take a peek in my
>> 'for-linus' branch and see if you spot anything wrong. 
> 
> Hi Dmitry,
> 
> I guess you forgot to push it to kernel.org? Last change I see in your 
> tree is 6 days old.
> 
> Thanks,
> 

... which seems like a lucky strike; the patch has a blatant security hole,
leaking grabbed events to listening clients after ungrab. I sent an updated
patch to Dmitry earlier today, in a brown paper bag. Not knowing if the original
patch was actually applied or not, I thought I had better hold on to the change
just a little bit.

Henrik
