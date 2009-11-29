From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to specify exact irq flags
Date: Sun, 29 Nov 2009 23:58:44 +0100
Message-ID: <87hbsd2b17.fsf@tac.ki.iif.hu>
References: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:33607 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbZK2W6z (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 17:58:55 -0500
In-Reply-To: <Pine.LNX.4.44L0.0911291103070.3165-100000@netrider.rowland.org>
	(Alan Stern's message of "Sun, 29 Nov 2009 11:04:57 -0500 (EST)")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Alan Stern <stern@rowland.harvard.edu> writes:

> On Sun, 29 Nov 2009, Ferenc Wagner wrote:
>
>> I thought we'd better ask our friends over at linux-pm, if they've got
>> some interface for this task.  To summarize: an embedded application
>> wants to go into a "locked" state, where some input devices (gpio keys
>> in this case) are "muted", ie. they don't even generate interrupts to
>> minimize power consumption.  This could be solved by adding a new
>> interface to gpio-keys, but the problem seems more general, so I wonder
>> if something like the USB selective runtime suspend is already available
>> (or preferable to develop) for such tasks.
>
> See Documentation/power/runtime_pm.txt.  I don't know to what extent 
> the input layer has implemented any runtime PM.

Hi Alan,

Looks like it wasn't a bright idea from me to mention runtime suspend
above.  We are looking from something else: some way to forcefully put a
device to "sleep" even thogh it's open (used), because we don't want to
receive input from it but want to save power instead.
-- 
Regards,
Feri.
