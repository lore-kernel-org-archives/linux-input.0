From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid: Add a hid quirk for input sync override
Date: Wed, 01 Sep 2010 13:32:28 +0200
Message-ID: <4C7E39CC.80402@euromail.se>
References: <1282640084-19217-1-git-send-email-rydberg@euromail.se> <alpine.LNX.2.00.1009011252450.26813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:45830 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751103Ab0IALcx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Sep 2010 07:32:53 -0400
In-Reply-To: <alpine.LNX.2.00.1009011252450.26813@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Stephane Chatty <chatty@enac.fr>

On 09/01/2010 12:54 PM, Jiri Kosina wrote:

> On Tue, 24 Aug 2010, Henrik Rydberg wrote:
> 
>> From: Henrik Rydberg <rydberg@thabit.(none)>
>>
>> As of lately, HID devices which send per-frame data split over several
>> HID reports have started to emerge. This patch adds a quirk which
>> allows the HID driver to take over the input layer synchronization,
>> and hence the control of the frame boundary.
>>
>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
>> ---
>> Jiri, Dmitry, Stephane,
>>
>> No doubt, this is not a final solution, but it serves the purpose of
>> being able to make existing drivers functional while a satisfactory
>> solution is being worked out.
> 
> Hi Henrik,
> 
> I obviously don't have any major objections to the patch, as it was my 
> initial idea :)


Ah! Then all is fine. :-)

> 
> I'd like to merge it together with driver which actually uses it though.


Sounds good. I suppose Stephane wants to have a say regarding the 3m driver
first, but no rush. What version are you targeting?

Thanks,
Henrik
