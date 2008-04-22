From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID bus
Date: Tue, 22 Apr 2008 02:00:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804220158560.12972@jikos.suse.cz>
References: <Pine.LNX.4.64.0804181333180.12972@jikos.suse.cz>
 <1208644696-29129-1-git-send-email-jirislaby@gmail.com> <480B2F9A.3020104@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:50227 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755107AbYDVAAN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 20:00:13 -0400
In-Reply-To: <480B2F9A.3020104@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, mit-devel@lists.printk.net, linux-kernel@vger.kernel.org

On Sun, 20 Apr 2008, Jiri Slaby wrote:

> So I suppose we still need the option to let users compile all the 
> chosen drivers into hid.

Another possible workaround is to introduce dummy "hid" module, that will 
just depend on all other drivers with a reference to certail symbol (and 
this could of course be optional as CONFIG_HID_COMPAT, or whatever).

Thanks,

-- 
Jiri Kosina
SUSE Labs
