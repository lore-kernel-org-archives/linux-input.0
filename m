From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] hid: enable hid device to suspend/resume
 asynchronously
Date: Thu, 3 Dec 2015 09:53:46 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512030953300.32500@cbobk.fhfr.pm>
References: <560392E7.1030207@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59838 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759000AbbLCIxs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Dec 2015 03:53:48 -0500
In-Reply-To: <560392E7.1030207@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 24 Sep 2015, Fu, Zhonghui wrote:

> Now, PM core supports asynchronous suspend/resume mode for devices
> during system suspend/resume, and the power state transition of one
> device may be completed in separate kernel thread. PM core ensures
> all power state transition timing dependency between devices. This
> patch enables hid devices to suspend/resume asynchronously. This
> will take advantage of multicore and improve system suspend/resume
> speed.
> 
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
> Changes in v2:
> - Amend commit message.
> 
>  drivers/hid/hid-core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 70a11ac..357f3a3 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2652,6 +2652,7 @@ struct hid_device *hid_allocate_device(void)
>  	device_initialize(&hdev->dev);
>  	hdev->dev.release = hid_device_release;
>  	hdev->dev.bus = &hid_bus_type;
> +	device_enable_async_suspend(&hdev->dev);

Applied to for-4.5/async-suspend branch.

-- 
Jiri Kosina
SUSE Labs

