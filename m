From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: mt: Initialize slots to unused
Date: Sat, 28 Aug 2010 22:58:41 -0700
Message-ID: <20100829055840.GD15369@core.coreip.homeip.net>
References: <1282484809-8554-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49111 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab0H2F6r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Aug 2010 01:58:47 -0400
Content-Disposition: inline
In-Reply-To: <1282484809-8554-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Aug 22, 2010 at 03:46:49PM +0200, Henrik Rydberg wrote:
> For MT slots, the ABS_MT_TRACKING_ID determines whether a slot is in use,
> but currently leaves initialization up to the drivers. This patch sets the
> slot state to unused upon creation.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Applied (which change to for() loop - I prefer not change passed
arguments), thanks Henrik.

-- 
Dmitry
