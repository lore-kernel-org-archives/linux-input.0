From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: sony: Correct Sixaxis battery reporting
Date: Mon, 17 Feb 2014 23:18:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402172318230.1192@pobox.suse.cz>
References: <1392489342-5401-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50685 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbaBQWSj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 17:18:39 -0500
In-Reply-To: <1392489342-5401-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org

On Sat, 15 Feb 2014, Frank Praznik wrote:

> The battery_charging and cable_state flags were backwards on the Sixaxis.
> The low bit of report byte 30 is 0 when charging and 1 when not.
> Bit 5 of byte 31 is 0 when a USB cable is connected and 1 when not.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

Applied, thanks Frank.

-- 
Jiri Kosina
SUSE Labs
