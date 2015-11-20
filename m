From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] usbhid: discarded events don't abort idleness
Date: Fri, 20 Nov 2015 11:00:37 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511201059520.20111@pobox.suse.cz>
References: <1446724527-27736-1-git-send-email-oneukum@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54221 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbbKTKAj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2015 05:00:39 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 3679EAAC4
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2015 10:00:11 +0000 (UTC)
In-Reply-To: <1446724527-27736-1-git-send-email-oneukum@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-input@vger.kernel.org

On Thu, 5 Nov 2015, Oliver Neukum wrote:

> If an event is discarded the device stays idle.
> Just reverse the order of check and marking busy.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Hi Oliver,

thanks for the fix. This is a real bug, so I am wondering whether you have 
seen causing it real problems (and hence it should be merged for 4.4), or 
if you found it just by code inspection (and therefore it should be fine 
to merge it for 4.5).

Thanks,

-- 
Jiri Kosina
SUSE Labs

