From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch]fix memleak in error case of hiddev
Date: Fri, 31 Oct 2008 15:42:52 +0100
Message-ID: <200810311542.53264.oliver@neukum.org>
References: <200810311031.39083.oliver@neukum.org> <alpine.LNX.1.10.0810311507070.31273@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:52968 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbYJaOmu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2008 10:42:50 -0400
In-Reply-To: <alpine.LNX.1.10.0810311507070.31273@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Kosina <jikos@jikos.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org


> Hmm, this is probably based on not-yet-merged usbhid autosuspend patchset, 
> right?

Yes, that's right. I looked at the wrong tree.
 
> Now, you are right that hiddev_open() doesn't handle error condition from 
> usbhid_open(), and that should be fixed. But that doesn't seem to be 
> addressed by your patch at all ... ?

Yes I am looking at hiddev currently and have found several errors.
I'll make patches for the appropriate trees.

	Regards
		Oliver
