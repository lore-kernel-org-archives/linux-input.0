From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] hid-ntrig.c Split multi and single touch.
Date: Fri, 12 Feb 2010 00:13:50 -0800
Message-ID: <20100212081350.GB7777@core.coreip.homeip.net>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu>
 <1265944448-23436-1-git-send-email-rafi@seas.upenn.edu>
 <1265944448-23436-2-git-send-email-rafi@seas.upenn.edu>
 <1265944448-23436-3-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f196.google.com ([209.85.210.196]:46906 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062Ab0BLINz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2010 03:13:55 -0500
Received: by yxe34 with SMTP id 34so369565yxe.15
        for <linux-input@vger.kernel.org>; Fri, 12 Feb 2010 00:13:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1265944448-23436-3-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr

On Thu, Feb 11, 2010 at 10:14:07PM -0500, Rafi Rubin wrote:
> +
> +	/* options */
> +	enum ntrig_mt_emit_ghosts emit_ghosts;

How can user change this option? Why would he want to do it?

> +	nd->emit_ghosts = 0;

That should be "nd->emit_ghosts = NTRIG_MT_EMIT_GHOSTS_NONE;"

The same goes for your other patch comparing emit_ghosts with 2.

-- 
Dmitry
