From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCHv2] HID: sony: Send FF commands in non-atomic context
Date: Tue, 19 Nov 2013 11:35:27 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1311191133550.6657@pobox.suse.cz>
References: <1384682880-5960-1-git-send-email-sven@narfation.org> <1384717101-7027-1-git-send-email-sven@narfation.org> <alpine.LNX.2.00.1311190938020.6919@pobox.suse.cz> <2436222.LsGn6ZW5hr@bentobox>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49158 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab3KSKfa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Nov 2013 05:35:30 -0500
In-Reply-To: <2436222.LsGn6ZW5hr@bentobox>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sven Eckelmann <sven@narfation.org>
Cc: linux-input@vger.kernel.org, simon@mungewell.org

On Tue, 19 Nov 2013, Sven Eckelmann wrote:

> > Now applied for 3.13. Thanks.
> 
> Ok, but would have been nice when the v3 version have been applied. 

I apparently got confused by this thread, sorry.

> Now I have to resubmit the LED patchset to include the function/variable 
> rename. I will do this tonight or tomorrow.

That'd be nice, thanks. Also I think really only the first patch (atomic 
context fix) is really applicable for this (3.13) merge window.

-- 
Jiri Kosina
SUSE Labs
