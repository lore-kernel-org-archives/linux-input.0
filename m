From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 0/2] hid: sensor-hub: Enhance feature report APIs
Date: Mon, 23 Feb 2015 15:20:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502231520250.19920@pobox.suse.cz>
References: <1424388926-18258-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60738 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbbBWOUf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 09:20:35 -0500
In-Reply-To: <1424388926-18258-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-input@vger.kernel.org

On Thu, 19 Feb 2015, Srinivas Pandruvada wrote:

> Current get and set feature report is enhanced to have multiple
> values in get and set.
> 
> v3
> Removed cast for __s32 *buf32, as suggested by Jonathan
> Added Acked-by/reviewed-by tags as per the reply from Jonathan
> 
> v2
> As suggested by Antonio Borneo, using DIV_ROUND_UP
> 
> v1
> Squashed into two patches one for get and one for set feature report
> for bisectability.
> 
> v0
> Separate patches for each driver/modules
> 
> Srinivas Pandruvada (2):
>   HID: hid-sensor-hub: Enhance get feature report API
>   HID: hid-sensor-hub: Enhance feature report set API

Applied.

> 
>  drivers/hid/hid-sensor-hub.c                       | 37 +++++++++++++++++++---
>  .../iio/common/hid-sensors/hid-sensor-attributes.c | 24 +++++++-------
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    | 13 ++++----
>  include/linux/hid-sensor-hub.h                     | 13 +++++---
>  4 files changed, 60 insertions(+), 27 deletions(-)

-- 
Jiri Kosina
SUSE Labs
