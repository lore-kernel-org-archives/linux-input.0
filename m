From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: question on LEDs on keyboards
Date: Tue, 14 Oct 2008 15:32:41 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810141530220.26779@jikos.suse.cz>
References: <200810141521.00225.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:54073 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750722AbYJNNcn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 09:32:43 -0400
In-Reply-To: <200810141521.00225.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org

On Tue, 14 Oct 2008, Oliver Neukum wrote:

> I found an error in the hid autosuspend patches. Keyboards can have more 
> than one LED. Is there a way to query the HID layer about active LEDs?

Hi Oliver,

you can either get the information from the underlying input device, or 
you can use hidinput_find_field() to find the fields of EV_LED type, and 
obtain the value from the offset that this function gives you.

Hope this helps,

-- 
Jiri Kosina
SUSE Labs
