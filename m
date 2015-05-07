From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: make timeout HZ independent
Date: Thu, 7 May 2015 10:33:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505071032570.8186@pobox.suse.cz>
References: <1430582115-22842-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48052 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbbEGIdN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 May 2015 04:33:13 -0400
In-Reply-To: <1430582115-22842-1-git-send-email-hofrat@osadl.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2 May 2015, Nicholas Mc Guire wrote:

> wait_event_interruptible_timeout() expects a timeout in jiffies so the
> numeric constant becomes HZ dependent - put it through msecs_to_jiffies()
> to make it HZ independent.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied to for-4.2/logitech. Thanks,

-- 
Jiri Kosina
SUSE Labs
