From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] hid: Fix boot delay for Creative SB Omni Surround
 5.1 with quirk
Date: Mon, 25 Apr 2016 16:42:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1604251641340.27368@cbobk.fhfr.pm>
References: <7b30aa00-7085-1f6f-7bad-ac19532cc611@mokrynskyi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46864 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbcDYOm3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Apr 2016 10:42:29 -0400
In-Reply-To: <7b30aa00-7085-1f6f-7bad-ac19532cc611@mokrynskyi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nazar Mokrynskyi <nazar@mokrynskyi.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 25 Apr 2016, Nazar Mokrynskyi wrote:

> Needed for v2 of the device firmware, otherwise kernel will stuck for few
> seconds and throw "usb_submit_urb(ctrl) failed: -1" early on system boot.
> 
> Signed-off-by: Nazar Mokrynskyi <nazar@mokrynskyi.com>
> ---
> No changes, just resubmission to ensure absence of undesired line breaks

Line breaks are OK, but still your mailer converted tabs to space, which 
equally breaks the application process.

I've fixed that up manually and applied, but please look into 
reconfiguring your MUA for any future submissions.

Thanks,

-- 
Jiri Kosina
SUSE Labs

