From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch]full autosuspend for USB HID
Date: Wed, 7 May 2008 19:18:23 +0200
Message-ID: <200805071918.24653.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0805071156300.2174-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:45565 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbYEGRS1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2008 13:18:27 -0400
In-Reply-To: <Pine.LNX.4.44L0.0805071156300.2174-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Am Mittwoch 07 Mai 2008 17:57:14 schrieb Alan Stern:
> > Unfortunately, I vaguely remember that some keyboards exposed the 
> > behaviors only when connected to certain HCI controllers, so building the 
> > whitelist might not be completely trivial.
> 
> Can we find out what Windows and OS-X do and copy them?
> 

Windows has a registry and *.ini files which control which HID devices
get power management.

	Regards
		Oliver

