From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 09 Mar 2010 16:17:37 -0500
Message-ID: <4B96BAF1.5070209@seas.upenn.edu>
References: <4B75E14A.2050602@seas.upenn.edu> <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu> <4B760D60.6020907@seas.upenn.edu> <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz> <4B96B740.7020208@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:57925 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab0CIVRs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 16:17:48 -0500
In-Reply-To: <4B96B740.7020208@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr

On 03/09/2010 04:01 PM, Henrik Rydberg wrote:
> In hid-ntrig.c, I see BTN_TOUCH set to one in one place in the code, but no
> place where it is set to zero.

Oops.  I removed that accidentally when I backed off on some of the more 
aggressive ideas.

> Incidently, I have a documentation patch pending which further specifies how to
> handle the fingers-off-screen events. Perhaps that is the issue here?

Nope just purely a mistake.


Since you're considering protocol clarification, what's your opinion on 
splitting the multi-touch and single touch (possibly emulated) to 
separate input devices?

Also BTN_0 or BTN_TOOL_DOUBLETAP for single touch (or both)?  It seems 
to me Wacom uses doubletap, whereas my hardware's rdesc defaults to btn0 
and evdev prefers btn0 as well.


Rafi
