From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 09 Mar 2010 22:01:52 +0100
Message-ID: <4B96B740.7020208@euromail.se>
References: <4B75E14A.2050602@seas.upenn.edu> <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu> <4B760D60.6020907@seas.upenn.edu> <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:46093 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753049Ab0CIVWE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 16:22:04 -0500
In-Reply-To: <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr

Jiri Kosina wrote:
> On Fri, 12 Feb 2010, Rafi Rubin wrote:
> 
>> This patch builds on the second of the 4 previous patches.  The latter 2 should
>> be ignored for now.
>>
>> This cleans up the behavior particularly for the latest firmware.  That firmware
>> really doesn't work well with the version of the driver in the linus tree, hence
>> my push to fix that and more.
>>
>> I will leave the more aggressive alterations until we get some feedback on
>> proper handling of multitouch and the question of redirecting single touch to a
>> separate device.
>>
>> In this form, when multitouch is active, both mt and st events will come out of
>> the "N-Trig MultiTouch" device.  And when its not st events will come out of
>> "N-Trig Touchscreen".
> 
> Thanks for clarification. I have updated the changelog to provide a little 
> bit more reasoning for the changes being made, and applied the patch.
> 

In hid-ntrig.c, I see BTN_TOUCH set to one in one place in the code, but no
place where it is set to zero.

Incidently, I have a documentation patch pending which further specifies how to
handle the fingers-off-screen events. Perhaps that is the issue here?

Henrik
