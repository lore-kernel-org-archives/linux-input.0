From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/2] hid-ntrig.c tipswitch and cleanup
Date: Mon, 3 May 2010 15:23:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005031523200.9849@pobox.suse.cz>
References: <1272877710-25431-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54082 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759260Ab0ECNXn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 May 2010 09:23:43 -0400
In-Reply-To: <1272877710-25431-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, chatty@enac.fr, dmitry.torokhov@gmail.com, micki@n-trig.com, linux-kernel@vger.kernel.org

On Mon, 3 May 2010, Rafi Rubin wrote:

> 
> [PATCH 1/2] TipSwitch for single touch mode touch.
> This patch is a resubmit of a recent patch which might have been lost due
> to the discussion of a distasteful comment (which has been sanitized).  Note
> this does not increase the use of TAP events in the driver, though it also does
> not remove them.
> 
> 
> [PATCH 2/2] Remove unused macro, TripleTap and QuadTap
> This patch marks the start of the removal of TAP events from hid-ntrig.  I will
> remove DoubleTap when the wacom X driver is capable of interpreting MT events,
> which is currently a work in progress.

I have applied both patches, thanks Rafi.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
