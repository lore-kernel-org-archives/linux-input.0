From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: synaptics - initialize pointer emulation usage
Date: Fri, 15 Feb 2013 18:54:22 -0800
Message-ID: <20130216025422.GC25913@core.coreip.homeip.net>
References: <1360956981-1112-1-git-send-email-rydberg@euromail.se>
 <1360956981-1112-2-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:57414 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3BPCyY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Feb 2013 21:54:24 -0500
Content-Disposition: inline
In-Reply-To: <1360956981-1112-2-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Daniel Kurtz <djkurtz@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 15, 2013 at 08:36:21PM +0100, Henrik Rydberg wrote:
> To properly setup event parameters for emulated events, pass
> the appropriate flag to the slot initialization function. Also,
> all MT-related events should be setup before initialization.
> 
> Incidentally, this solves the issue of doubly filtered pointer
> events.
> 
> Reported-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Applied both, thank you Henrik.

-- 
Dmitry
