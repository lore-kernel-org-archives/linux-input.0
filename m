From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch for 2.6.28]open refcount issue in hidraw
Date: Mon, 15 Dec 2008 13:13:11 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0812151312530.21089@jikos.suse.cz>
References: <200812151304.45996.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:34397 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750749AbYLOMNO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Dec 2008 07:13:14 -0500
In-Reply-To: <200812151304.45996.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org

On Mon, 15 Dec 2008, Oliver Neukum wrote:

> The hidraw subsystem has a bug that prevents the close syscall from ever
> reaching the low level driver, leading to a resource leak. Fix by replacing
> postdecrement with predecrement.

Good catch, applied, thanks.

-- 
Jiri Kosina
SUSE Labs
