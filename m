From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 09 Mar 2010 17:32:00 -0500
Message-ID: <4B96CC60.8030608@seas.upenn.edu>
References: <4B75E14A.2050602@seas.upenn.edu> <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu> <4B760D60.6020907@seas.upenn.edu> <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz> <4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu> <alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz> <5423752A-3AE0-4848-9149-B0C01B0BCA39@enac.fr> <20100309222731.GA29517@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:46735 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363Ab0CIWcL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 17:32:11 -0500
In-Reply-To: <20100309222731.GA29517@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

>> With this regard, I am a big fan of the idea of having hierarchical
>> devices, just like with have hierarchical file systems. Each finger
>> on the dual-touch panel would be a device, child of the panel
>> device. Each would be equivalent to a mouse, and voila, the symmetry
>> is restored. Conceptually, saying (panel/finger1, any event) or
>> (panel, finger1 events) are equivalent; but in the first case the
>> routing is done by the OS and in the second case it has to be done
>> by the app, which breaks reusability. There are other interesting
>> perspectives, but I don't want to get carried away too much.
>
> Theoretically it is nice but it practice the cases are differemt: with
> mice you are dealing with 2 separate devices whereas with touchscreen
> there is one and it is mater of interpretation whether 2 touches should
> be taken as independent events or a complex gestures.

I see your point, reporting the position on separate axes (ABS_X and 
ABS_MT_X) isn't as problematic as seeing TOUCH turn on twice.
