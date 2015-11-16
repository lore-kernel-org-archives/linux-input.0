From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH v2] hid: enable hid device to suspend/resume asynchronously
Date: Mon, 16 Nov 2015 23:17:55 +0800
Message-ID: <5649F3A3.8080007@linux.intel.com>
References: <560392E7.1030207@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54839 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbbKPPSR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 10:18:17 -0500
In-Reply-To: <560392E7.1030207@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.com, jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


Hi Jiri,

Any comments about this patch?

After enabling the HID devices suspend/resume asynchronously on ASUS T100TA(Baytrail-T platform), the system suspend-to-idle/resume time is reduced about 20ms. Although this improvement is not very significant. But, if the suspend/resume operation of HID devices is very time-consuming on some other platforms, this patch can improve significantly system suspend/resume speed on these platforms. 



Thanks,
Zhonghui 



On 9/24/2015 2:06 PM, Fu, Zhonghui wrote:
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
>  
>  	hid_close_report(hdev);
>  
> -- 1.7.1
>

