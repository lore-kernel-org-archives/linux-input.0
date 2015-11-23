From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] usbhid: discarded events don't abort idleness
Date: Mon, 23 Nov 2015 10:17:00 +0100
Message-ID: <1448270220.29691.6.camel@suse.com>
References: <1446724527-27736-1-git-send-email-oneukum@suse.com>
	 <alpine.LNX.2.00.1511201059520.20111@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38299 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbbKWJSu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2015 04:18:50 -0500
In-Reply-To: <alpine.LNX.2.00.1511201059520.20111@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org

On Fri, 2015-11-20 at 11:00 +0100, Jiri Kosina wrote:
> On Thu, 5 Nov 2015, Oliver Neukum wrote:
> 
> > If an event is discarded the device stays idle.
> > Just reverse the order of check and marking busy.
> > 
> > Signed-off-by: Oliver Neukum <oneukum@suse.com>
> 
> Hi Oliver,
> 
> thanks for the fix. This is a real bug, so I am wondering whether you have 
> seen causing it real problems (and hence it should be merged for 4.4), or 
> if you found it just by code inspection (and therefore it should be fine 
> to merge it for 4.5).

Hi,

I was looking for another bug. So code inspection.

	HTH
		Oliver



