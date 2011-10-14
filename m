From: Oliver Neukum <oneukum@suse.de>
Subject: Re: possible race between reset and error handling in usbhid
Date: Fri, 14 Oct 2011 08:37:29 +0200
Message-ID: <201110140837.29660.oneukum@suse.de>
References: <201110121614.23410.oneukum@suse.de> <alpine.LNX.2.00.1110131819500.14768@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40420 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379Ab1JNGhJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Oct 2011 02:37:09 -0400
In-Reply-To: <alpine.LNX.2.00.1110131819500.14768@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Am Donnerstag, 13. Oktober 2011, 18:20:52 schrieb Jiri Kosina:
> On Wed, 12 Oct 2011, Oliver Neukum wrote:
> 
> > looking at the usbhid code it seems to me that there is no protection
> > between the error handling code and pre_reset() racing.
> > 
> > In particular there seems to be no protection from hid_retry_timeout() calling
> > hid_start_in() which would start IO after hid_pre_reset() has already called
> > hid_cease_io() because that uses del_timer(), not del_timer_sync()
> > 
> > What do you think about this patch?
> 
> Looks like you made a good catch, thanks. Out of curiosity -- did you 
> encounter this happening for real, or have you find out by code reading?

A bit of both. I was looking for causes of a mysterious bug report that
just mentions HID devices and resets and is known to be a race.
So I may have indirectly encountered it.

	Regards
		Oliver
