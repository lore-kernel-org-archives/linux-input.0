From: Oliver Neukum <oliver@neukum.org>
Subject: Re: question on LEDs on keyboards
Date: Tue, 14 Oct 2008 20:13:59 +0200
Message-ID: <200810142014.00517.oliver@neukum.org>
References: <200810141521.00225.oliver@neukum.org> <alpine.LNX.1.10.0810141530220.26779@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:37290 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbYJNSPP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 14:15:15 -0400
In-Reply-To: <alpine.LNX.1.10.0810141530220.26779@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Am Dienstag, 14. Oktober 2008 15:32:41 schrieb Jiri Kosina:
> On Tue, 14 Oct 2008, Oliver Neukum wrote:
> 
> > I found an error in the hid autosuspend patches. Keyboards can have more 
> > than one LED. Is there a way to query the HID layer about active LEDs?
> 
> Hi Oliver,
> 
> you can either get the information from the underlying input device, or 
> you can use hidinput_find_field() to find the fields of EV_LED type, and 
> obtain the value from the offset that this function gives you.

What is the prefered way of doing that? There seems to be no hid_get_field().

	Regards
		Oliver
