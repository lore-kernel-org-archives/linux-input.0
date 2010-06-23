From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] INPUT: tps6507x-ts, remove unneeded NULL test
Date: Tue, 22 Jun 2010 23:23:41 -0700
Message-ID: <20100623062341.GA8963@core.coreip.homeip.net>
References: <1277206862-27146-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62568 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab0FWGXq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jun 2010 02:23:46 -0400
Content-Disposition: inline
In-Reply-To: <1277206862-27146-1-git-send-email-jslaby@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, jirislaby@gmail.com, Todd Fischer <todd.fischer@ridgerun.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org

On Tue, Jun 22, 2010 at 01:41:02PM +0200, Jiri Slaby wrote:
> Stanse found that tsc is dereferenced earlier than checked for being
> NULL in tps6507x_ts_remove. Remove the test because I see no way, how
> tsc can be NULL there.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Todd Fischer <todd.fischer@ridgerun.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: linux-input@vger.kernel.org

Applied, thanks Jiri.

-- 
Dmitry
