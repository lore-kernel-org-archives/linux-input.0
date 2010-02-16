From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 16 Feb 2010 13:50:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>
References: <4B75E14A.2050602@seas.upenn.edu> <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu> <4B760D60.6020907@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44823 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755632Ab0BPMuO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 07:50:14 -0500
In-Reply-To: <4B760D60.6020907@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr, rydberg@euromail.se

On Fri, 12 Feb 2010, Rafi Rubin wrote:

> This patch builds on the second of the 4 previous patches.  The latter 2 should
> be ignored for now.
> 
> This cleans up the behavior particularly for the latest firmware.  That firmware
> really doesn't work well with the version of the driver in the linus tree, hence
> my push to fix that and more.
> 
> I will leave the more aggressive alterations until we get some feedback on
> proper handling of multitouch and the question of redirecting single touch to a
> separate device.
> 
> In this form, when multitouch is active, both mt and st events will come out of
> the "N-Trig MultiTouch" device.  And when its not st events will come out of
> "N-Trig Touchscreen".

Thanks for clarification. I have updated the changelog to provide a little 
bit more reasoning for the changes being made, and applied the patch.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
