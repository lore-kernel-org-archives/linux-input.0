From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] hid: Add a hid quirk for input sync override
Date: Fri, 17 Sep 2010 18:20:41 +0200
Message-ID: <D154A68C-ABA2-4C6C-B7E1-C0989357B8F7@enac.fr>
References: <1282640084-19217-1-git-send-email-rydberg@euromail.se>  <alpine.LNX.2.00.1009011252450.26813@pobox.suse.cz>  <4C7E39CC.80402@euromail.se> <alpine.LNX.2.00.1009021630000.26813@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:59078 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab0IQQUs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Sep 2010 12:20:48 -0400
In-Reply-To: <alpine.LNX.2.00.1009021630000.26813@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

>>
>>
>> Sounds good. I suppose Stephane wants to have a say regarding the  
>> 3m driver
>> first, but no rush. What version are you targeting?
>
> 2.6.37 looks reasonable if everything it agreed upon in the following
> week(s).
>

After many adventures, I finally managed to get the driver *and* the  
3M panel available at the same time. XDS and the satellite events did  
not help :-)

I'm observing a few things that look strange with evtest, starting  
with missing ABS_MT_SLOT at the beginning of interaction sequences.  
Investigating... Henrik, would it be useful if I send you evtest  
logs, what I did with my fingers and what I find strange in the result?

Cheers

St.

