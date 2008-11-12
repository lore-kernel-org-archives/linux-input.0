From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch]fix memleak in error case of hiddev
Date: Wed, 12 Nov 2008 15:55:47 +0100
Message-ID: <200811121555.48488.oliver@neukum.org>
References: <200810311031.39083.oliver@neukum.org> <200810311610.11604.oliver@neukum.org> <alpine.LNX.1.10.0811121547400.32143@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:49842 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbYKLOzS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2008 09:55:18 -0500
In-Reply-To: <alpine.LNX.1.10.0811121547400.32143@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Kosina <jikos@jikos.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Am Mittwoch, 12. November 2008 15:48:38 schrieb Jiri Kosina:
> On Fri, 31 Oct 2008, Oliver Neukum wrote:
> 
> > > Now, you are right that hiddev_open() doesn't handle error condition from 
> > > usbhid_open(), and that should be fixed. But that doesn't seem to be 
> > > addressed by your patch at all ... ?
> > Very well, this is what I've found in hiddev (with the autosuspend patch).
> > I am porting this to the vanilla and the stable tree.
> > - failure to test for lower range of minors
> > - addition to list before open finishes
> > - failure to handle errors from usbhid_open()
> > - possibility to miss a wakeup in hiddev_read
> > - open() races with hiddev_connect()
> > Note that this is untested and should be tested.
> 
> Does the patch below look OK to you? I have removed the dependency on 
> autosuspend code for now.

No, it doesn't look good.

> +	if (!list->hiddev->open++) {
> +		if (list->hiddev->exist) {

The order of checks is inverted. If the device no longer exists
opening should fail, even if the device is already opened.
Didn't I post a patch that does this? My memory is a bit clouded.

	Regards
		Oliver
