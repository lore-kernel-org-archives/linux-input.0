From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Wed, 10 Mar 2010 00:23:06 +0100
Message-ID: <4B96D85A.4060604@euromail.se>
References: <4B75E14A.2050602@seas.upenn.edu> <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu> <4B760D60.6020907@seas.upenn.edu> <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz> <4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu> <4B96C4A8.3060005@euromail.se> <4B96CB41.9040804@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:51674 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754679Ab0CIX3m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 18:29:42 -0500
In-Reply-To: <4B96CB41.9040804@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr

Rafi Rubin wrote:
>> Single touch should be goverened by one of BTN_TOUCH or ABS_PRESSURE.
>> BTN_TOOL_DOUBLETAP is a two-finger event.
> 
> That definitely makes sense to me.  I really don't know why wacom uses
> double tap there.
> 
> Is there any harm in letting through the BTN_0 events?  Is the "rdesc"
> mapping defined by the hardware or hid?

I cannot imagine BTN_0 will do any harm. In synaptics, the BTN_X buttons are
mapped to multibuttons without clear-cut usage. The button events that carry
well-defined semantic meaning with regard to touch screens are BTN_TOUCH (any
finger), BTN_TOOL_FINGER (one finger), BTN_TOOL_PEN (pen), BTN_TOOL_DOUBLETAP
(two fingers) and BTN_TOOL_TRIPLETAP (three fingers or more).

Henrik

