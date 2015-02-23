From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v1 0/2] Core driver enhancements
Date: Mon, 23 Feb 2015 15:12:35 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502231512250.19920@pobox.suse.cz>
References: <1424388686-18125-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60192 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbbBWOMh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 09:12:37 -0500
In-Reply-To: <1424388686-18125-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-input@vger.kernel.org

On Thu, 19 Feb 2015, Srinivas Pandruvada wrote:

> Enhance core to support next generation of hub devices for fast response
> and application collection.
> 
> v1
> Added acked by tag for parallel read patch
> For collection support, changed the commit message and relying on FW to explicitlty
> define a collection, then only create a collection and allow callback registration
> 
> v0
> Base version
> 
> Srinivas Pandruvada (2):
>   HID: hid-sensor-hub: Allow parallel synchronous reads
>   HID: hid-sensor-hub: Add support for application collection
> 
>  drivers/hid/hid-sensor-hub.c   | 120 +++++++++++++++++++++++------------------
>  include/linux/hid-sensor-hub.h |  24 +++++++++
>  include/linux/hid-sensor-ids.h |   2 +
>  3 files changed, 93 insertions(+), 53 deletions(-)

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
