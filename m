From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: call _query_tablet_data() for BAMBOO_TOUCH
Date: Thu, 30 Mar 2017 11:31:08 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1703301130550.31814@cbobk.fhfr.pm>
References: <1490812888-31078-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37859 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752667AbdC3JbM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Mar 2017 05:31:12 -0400
In-Reply-To: <1490812888-31078-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, killertofu@gmail.com, benjamin.tissoires@redhat.com, Aaron Armstrong Skomra <aaron.skomra@wacom.com>

On Wed, 29 Mar 2017, Aaron Armstrong Skomra wrote:

> Commit a544c619a54b ("HID: wacom: do not attempt to switch mode
> while in probe") introduces delayed work for querying (setting the
> mode) on all tablets. Bamboo Touch (056a:00d0) has a ghost
> interface which claims to be a pen device. Though this device can
> be removed, we have to set the mode on the ghost pen interface
> before we remove it. After the aforementioned delay was introduced
> the device was being removed before the mode setting could be
> executed.
> 
> Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>

Applied to for-4.11/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

