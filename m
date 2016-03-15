From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] hid: thingm: reorder calls in thingm_probe
Date: Tue, 15 Mar 2016 15:30:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603151530120.3656@cbobk.fhfr.pm>
References: <56E1D075.1000607@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44933 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755428AbcCOOa2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2016 10:30:28 -0400
In-Reply-To: <56E1D075.1000607@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-input@vger.kernel.org, linux-leds@vger.kernel.org

On Thu, 10 Mar 2016, Heiner Kallweit wrote:

> When reviewing another thingm patch Benjamin Tissoires pointed out
> the following: "The problem here is that hid_hw_start() is called
> before thingm_version() which allows user space to briefly introduce
> races between thingm_version() and any hidraw requests.
> The mutex will not help here as it is initialized after hid_hw_start()
> and only used for protecting the concurrent access of the rgb."
> 
> Avoid this possible issue by calling hid_hw_start() later in the
> probe function.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - make commit message more verbose

Applied to for-4.6/thingm.

-- 
Jiri Kosina
SUSE Labs

