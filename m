From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch]aggessive autosuspend for HID devices (resent due to
 corruption)
Date: Fri, 31 Oct 2008 00:08:48 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0810310008310.31273@jikos.suse.cz>
References: <200810271042.37365.oliver@neukum.org> <alpine.LNX.1.10.0810291425400.12928@jikos.suse.cz> <200810291625.21763.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:49297 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753495AbYJ3XIt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Oct 2008 19:08:49 -0400
In-Reply-To: <200810291625.21763.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, "Yang, Yi Y" <yi.y.yang@intel.com>, Jiri Slaby <jslaby@suse.cz>

On Wed, 29 Oct 2008, Oliver Neukum wrote:

> As open needs to sleep hidraw was wrong to call it with a spinlock held.
> Furthermore, open can of course fail which needs to be handled.
> So I changed the spinlock into a mutex, adjusted locking accordingly and
> added error checking.

Applied to my tree, thanks for the fix.

-- 
Jiri Kosina
SUSE Labs
