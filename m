From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] HID: sony: Enable LED controls and rumble for the
 Sixaxis on Bluetooth.
Date: Thu, 20 Feb 2014 14:10:39 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402201410270.1192@pobox.suse.cz>
References: <1392762123-17725-1-git-send-email-frank.praznik@oh.rr.com> <1392762123-17725-2-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52165 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939AbaBTNKo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 08:10:44 -0500
In-Reply-To: <1392762123-17725-2-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, dh.herrmann@gmail.com

On Tue, 18 Feb 2014, Frank Praznik wrote:

> Add a SIXAXIS_CONTROLLER macro to simplify conditionals where the
> connection type is irrelevant.
> 
> Enable the LED and force feedback controls for Sixaxis controllers connected via
> Bluetooth.
> 
> Send Sixaxis Bluetooth output reports on the control channel.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

Queued for 3.15, thanks.

-- 
Jiri Kosina
SUSE Labs
