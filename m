From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH v2] hid: assorted usage updates from hut 1.12
Date: Tue, 24 May 2011 13:49:01 -0400
Message-ID: <4DDBEF8D.2090600@redhat.com>
References: <4DADDEBF.3050407@redhat.com> <1303241310-21354-1-git-send-email-jarod@redhat.com> <alpine.LNX.2.00.1105181708210.28291@pobox.suse.cz> <4DDACC93.5020105@redhat.com> <alpine.LNX.2.00.1105241357340.28291@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7059 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932362Ab1EXRs4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2011 13:48:56 -0400
In-Reply-To: <alpine.LNX.2.00.1105241357340.28291@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Jiri Kosina wrote:
> On Mon, 23 May 2011, Jarod Wilson wrote:
>
>>>> Outside of fixing the obviously incorrect mapping of 0xc 0x45 from
>>>> KEY_RADIO to KEY_RIGHT, and making use of the new KEY_IMAGES (just added
>>>> in 2.6.39-rc4) for AL Image Browser instead of KEY_MEDIA, these are
>>>> purely additions, and thus should have no negative impact on any already
>>>> functional HID devices. Most of the added mappings seemed to be
>>>> perfectly logical to me, but there were a few that were mapped on more
>>>> of an "I think this makes the most sense" basis.
>>> It took me quite some time to go over the individual changes, sorry for
>>> the delay. I have applied the patch.
>> Cool, thanks much. Any word on the follow-on TiVo Slide patch?
>
> Hmm, it might have escaped my attention, I don't seem to have it in my
> queue. Could you please resend it?

Gah. Seems I should send it, period. I now have vague recollections that 
I decided to refrain from sending the follow-on patch until this patch 
was accepted. I'll get the TiVo Slide one sent along shortly.

Sorry for the confusion,

-- 
Jarod Wilson
jarod@redhat.com


