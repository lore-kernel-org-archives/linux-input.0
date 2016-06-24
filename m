From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Validate num_values for HIDIOCGUSAGES, HIDIOCSUSAGES
 commands.
Date: Fri, 24 Jun 2016 10:22:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606241021490.6874@cbobk.fhfr.pm>
References: <1466693987-15363-1-git-send-email-sbauer@plzdonthack.me>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57563 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbcFXIWd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2016 04:22:33 -0400
In-Reply-To: <1466693987-15363-1-git-send-email-sbauer@plzdonthack.me>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Scott Bauer <sbauer@plzdonthack.me>
Cc: benjamin.tissoires@redhat.com, wmealing@redhat.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Thu, 23 Jun 2016, Scott Bauer wrote:

> This patch validates the num_values parameter from userland during
> the HIDIOCGUSAGES and HIDIOCSUSAGES commands. Previously, if the
> report id was set to HID_REPORT_ID_UNKNOWN, we would fail to
> validate the num_values parameter leading to a heap overflow.

Thanks for the fix. I've added Cc: stable, applied it to 
for-4.7/upstream-fixes branch, and will be including it in a pull request 
to Linus shortly.

-- 
Jiri Kosina
SUSE Labs

