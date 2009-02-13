From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: dead USB devices after resume [mmotm 2009-02-10-16-35]
Date: Fri, 13 Feb 2009 19:19:03 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0902131917090.7361@twin.jikos.cz>
References: <Pine.LNX.4.44L0.0902111009260.3056-100000@iolanthe.rowland.org> <49954E04.6090008@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56157 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbZBMSTK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Feb 2009 13:19:10 -0500
In-Reply-To: <49954E04.6090008@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org, Greg KH <gregkh@suse.de>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, Oliver Neukum <oliver@neukum.org>

On Fri, 13 Feb 2009, Jiri Slaby wrote:

> Here comes the resume part (including unplug, replug). I suspect 
> auto-suspend?

The log looks fine IMHO.

The autosuspend shouldn't be the culprit, as it should definitely be 
turned off by default for mice and keyboards (could you please verify that 
it really is)?

I any way, the autosuspend for HID has been implemented by Oliver and is 
currently sitting as 8390887fae ("HID: autosuspend support for USB HID") 
through which it gets to -next. Could you please verify that this patch 
really isn't the culprit?

Thanks,

-- 
Jiri Kosina
SUSE Labs

