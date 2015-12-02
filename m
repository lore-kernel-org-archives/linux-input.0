From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/7] HID: wacom: Move Intuos pad handling code into
 dedicated function
Date: Wed, 2 Dec 2015 16:22:46 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512021622230.32500@pobox.suse.cz>
References: <1448932432-10115-1-git-send-email-killertofu@gmail.com> <alpine.LNX.2.00.1512021620100.32500@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45186 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494AbbLBPWr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Dec 2015 10:22:47 -0500
In-Reply-To: <alpine.LNX.2.00.1512021620100.32500@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Wed, 2 Dec 2015, Jiri Kosina wrote:

> I know that this code (and other instances of similar spaghetti) has been 
> there before already and you are just moving it around, but isn't this the 
> proper time to clean it up a bit?
> 
> Like change it to a for-loop that'd use BTN_ as an array index to compute 
> the position in the data bitstream and call input_report_key()?

Okay, scratch that, I see now that this ugliness is being dealt with later 
in the series. Sorry for the noise.

-- 
Jiri Kosina
SUSE Labs

