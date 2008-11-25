From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/4] USBHID: use GFP_KERNEL in hid_alloc_buffers
Date: Tue, 25 Nov 2008 12:53:44 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811251253141.19853@jikos.suse.cz>
References: <1227540009-14209-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:49373 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750828AbYKYLxp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2008 06:53:45 -0500
In-Reply-To: <1227540009-14209-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 24 Nov 2008, Jiri Slaby wrote:

> We might sleep, so no problem to use GFP_KERNEL.
> 
> While at it bring the function to coding style.

Applied, as well as the other three patches in the series. All queued for 
2.6.29.

Thanks!

-- 
Jiri Kosina
SUSE Labs
