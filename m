From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] USBHID: correct start/stop cycle
Date: Tue, 11 Nov 2008 23:52:51 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811112352390.24889@jikos.suse.cz>
References: <1225579306-28524-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:42455 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750757AbYKKWww (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 17:52:52 -0500
In-Reply-To: <1225579306-28524-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 1 Nov 2008, Jiri Slaby wrote:

> `stop' left out usbhid->urb* pointers and so the next `start' thought
> it needs to allocate nothing and used the memory pointers previously
> pointed to. This led to memory corruption and device malfunction.
> 
> Also don't forget to clear disconnect flag on start which was left set
> by the previous `stop'.

Applied, thanks Jiri.

-- 
Jiri Kosina
SUSE Labs
