From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-sensor-hub: fix attribute read for logical
 usage id
Date: Mon, 16 Mar 2015 16:22:13 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503161622050.25438@pobox.suse.cz>
References: <1424919387-19136-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48364 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933670AbbCPPWQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 11:22:16 -0400
In-Reply-To: <1424919387-19136-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-input@vger.kernel.org

On Wed, 25 Feb 2015, Srinivas Pandruvada wrote:

> For defining enumeration values like report or power status events,
> the enumeration usage ids are enclosed in a logical collection.
> In this case we need to match logical usage id for pending read
> on this usage id. For example, in the below field, when
> read is requested for 0319, the report will contain one of the
> status usages like 850, 851 etc. In this case the raw event will
> not match 0319. So when logical collection matches, then
> wake up the pending thread.
> 
>       Physical(Sensor.OtherCustom)
>       Logical(Sensor.0319)
>       Application(Sensor.Sensor)
>       Usage(6)
>         Sensor.0850
>         Sensor.0851
>         Sensor.0852
>         Sensor.0853
>         Sensor.0854
>         Sensor.0855
>       Logical Minimum(1)
>       Logical Maximum(5)
>       Report Size(8)
>       Report Count(1)
>       Report Offset(24)
>       Flags( Array Absolute )
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied to for-4.1/sensor-hub.

-- 
Jiri Kosina
SUSE Labs
