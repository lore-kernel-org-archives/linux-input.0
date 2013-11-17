From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCHv2] HID: sony: Send FF commands in non-atomic context
Date: Sun, 17 Nov 2013 20:51:09 +0100
Message-ID: <2281545.UHfeV6KrOG@sven-edge>
References: <1384682880-5960-1-git-send-email-sven@narfation.org> <1384717101-7027-1-git-send-email-sven@narfation.org> <b5aa869c12a432d275c51f9130ba697b.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42100 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936Ab3KQTwJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 14:52:09 -0500
In-Reply-To: <b5aa869c12a432d275c51f9130ba697b.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Sunday 17 November 2013 14:46:32 simon@mungewell.org wrote:
> >  drivers/hid/hid-sony.c | 53
> > 
> > +++++++++++++++++++++++++++++++++++++++-----------
> > 
> >  1 file changed, 42 insertions(+), 11 deletions(-)
> 
> Doesn't this miss patching Kconfig (previous changes were reverted).
> Simon

This was meant as a "replacement"/v2 of the revert patch as said earlier 
(directly bellow the commit message):

> > This patch can replace
> > 'Revert "HID: sony: Add force feedback support for Dualshock3 USB"'

And if the maintainer doesn't like the work_queue workaround then he can still 
apply the revert patch or discuss/propose a different approach.

Kind regards,
	Sven
