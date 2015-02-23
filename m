From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] Asynchronous attribute reads
Date: Mon, 23 Feb 2015 15:17:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502231517160.19920@pobox.suse.cz>
References: <1424388836-18193-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60520 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343AbbBWORZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 09:17:25 -0500
In-Reply-To: <1424388836-18193-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-input@vger.kernel.org

On Thu, 19 Feb 2015, Srinivas Pandruvada wrote:

> v2
> As suggested by Jonathan reversed the logic for sync/async and
> moved sensor_hub_report to begining of the function
> 
> v1
> Squashed into a single patch for bisectability.
> 
> v0
> Separate patches for each driver/module

Applied.

> 
> 
> Srinivas Pandruvada (1):
>   HID: hid-sensor-hub: Extend API for async reads
> 
>  drivers/hid/hid-sensor-hub.c                  | 65 ++++++++++++++-------------
>  drivers/iio/accel/hid-sensor-accel-3d.c       |  3 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         |  3 +-
>  drivers/iio/light/hid-sensor-als.c            |  3 +-
>  drivers/iio/light/hid-sensor-prox.c           |  3 +-
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c |  3 +-
>  drivers/iio/orientation/hid-sensor-incl-3d.c  |  3 +-
>  drivers/iio/pressure/hid-sensor-press.c       |  3 +-
>  drivers/rtc/rtc-hid-sensor-time.c             |  2 +-
>  include/linux/hid-sensor-hub.h                | 19 +++++---
>  10 files changed, 63 insertions(+), 44 deletions(-)

-- 
Jiri Kosina
SUSE Labs
