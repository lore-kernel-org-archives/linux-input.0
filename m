From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/7] HID: wacom: Move Intuos pad handling code into
 dedicated function
Date: Wed, 2 Dec 2015 21:46:36 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512022145490.32500@cbobk.fhfr.pm>
References: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37715 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbbLBUqh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Dec 2015 15:46:37 -0500
In-Reply-To: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, 30 Nov 2015, Jason Gerecke wrote:

> Begin slimming down the body of 'wacom_intuos_irq' by moving out its
> largest block of code to a dedicated 'wacom_intuos_pad' function.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

I really like the cleanups done by this patchset, thanks. I have applied 
it to for-4.5/wacom branch.

-- 
Jiri Kosina
SUSE Labs

