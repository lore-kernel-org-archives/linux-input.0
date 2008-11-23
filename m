From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] USBHID: remove setup mutex
Date: Sun, 23 Nov 2008 12:05:01 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811231204150.19853@jikos.suse.cz>
References: <Pine.LNX.4.44L0.0811121650090.2186-100000@iolanthe.rowland.org> <1227347799-24137-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:38955 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756725AbYKWLFE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Nov 2008 06:05:04 -0500
In-Reply-To: <1227347799-24137-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: stern@rowland.harvard.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 22 Nov 2008, Jiri Slaby wrote:

> It causes recursive locking warning and is unneeded after
> introduction of STARTED flag.
> 
> * Resume vs. stop is effectively solved by DISCONNECT flag.
> * No problem in suspend vs. start -- urb is submitted even after open
>   which is possible after connect which is called after start.
> * Resume vs. start solved by STARTED flag.
> * Suspend vs. stop -- no problem in killing urb and timer twice.

Yes, this was exactly point of my original question, thanks a lot for 
doublechecking. Applied.

Thanks,

-- 
Jiri Kosina
SUSE Labs
