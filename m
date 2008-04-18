From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC 7/8] HID: move apple quirks
Date: Fri, 18 Apr 2008 13:33:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804181332040.12972@jikos.suse.cz>
References: <1207341357-17792-1-git-send-email-jirislaby@gmail.com>
 <1207341357-17792-8-git-send-email-jirislaby@gmail.com>
 <Pine.LNX.4.64.0804161544490.12972@jikos.suse.cz> <48061042.6030005@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:40866 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751013AbYDRLdI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Apr 2008 07:33:08 -0400
In-Reply-To: <48061042.6030005@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, marcel@holtmann.org, dmitry.torokhov@gmail.com, Jiri Slaby <jslaby@suse.cz>

On Wed, 16 Apr 2008, Jiri Slaby wrote:

> Since the apple mightymouse is only quirked bluetooth device. Do you 
> want me to split it to 2 patches -- an usb part and a BT part? (Or note 
> this in changelog?)

I think this is up to Marcel -- if he is OK with me taking this through my 
tree eventually, just Acked-by is OK. If he wants to take it through 
his/Davem's tree, a separate patch will be probably needed.

Thanks,

-- 
Jiri Kosina
SUSE Labs
