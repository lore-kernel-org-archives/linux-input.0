From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] hid: intel-ish-hid: ipc: check FW status to distinguish
 ISH resume paths
Date: Mon, 06 Feb 2017 17:11:02 -0800
Message-ID: <1486429862.18380.150.camel@linux.intel.com>
References: <1486103093-2375-1-git-send-email-even.xu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55295 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752387AbdBGBLK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Feb 2017 20:11:10 -0500
In-Reply-To: <1486103093-2375-1-git-send-email-even.xu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Even Xu <even.xu@intel.com>, jikos@kernel.org
Cc: linux-input@vger.kernel.org

On Fri, 2017-02-03 at 14:24 +0800, Even Xu wrote:
> For ISH resume, there are two paths, they need different way to
> handle:
> one where ISH is not powered off, in that case a simple resume
> message
> is enough, in other case we need a reset sequence.
> 
> We can use ISH FW status to distinguish those two cases and handle
> them
> properly.
> 
> Signed-off-by: Even Xu <even.xu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Not an urgent fix and can be queued up for 4.11.

Thanks,
Srinivas

> ---
>  drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h |  8 +++++++
>  drivers/hid/intel-ish-hid/ipc/hw-ish.h      | 12 ++++++++++
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c     | 34
> ++++++++++++++++++++---------
>  3 files changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
> b/drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
> index ab68afc..a5897b9 100644
> --- a/drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
> +++ b/drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
> @@ -111,6 +111,14 @@
>  #define IPC_ILUP_BIT			(1<<IPC_ILUP_OFFS)
>  
>  /*
> + * ISH FW status bits in ISH FW Status Register
> + */
> +#define IPC_ISH_FWSTS_SHIFT		12
> +#define IPC_ISH_FWSTS_MASK		GENMASK(15, 12)
> +#define IPC_GET_ISH_FWSTS(status)	\
> +	(((status) & IPC_ISH_FWSTS_MASK) >> IPC_ISH_FWSTS_SHIFT)
> +
> +/*
>   * FW status bits (relevant)
>   */
>  #define	IPC_FWSTS_ILUP		0x1
> diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> index d68cbcb..ddc8263 100644
> --- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> +++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> @@ -62,6 +62,18 @@ struct ish_hw {
>  	void __iomem *mem_addr;
>  };
>  
> +/*
> + * ISH FW status type
> + */
> +enum {
> +	FWSTS_AFTER_RESET		= 0,
> +	FWSTS_WAIT_FOR_HOST		= 4,
> +	FWSTS_START_KERNEL_DMA		= 5,
> +	FWSTS_FW_IS_RUNNING		= 7,
> +	FWSTS_SENSOR_APP_LOADED		= 8,
> +	FWSTS_SENSOR_APP_RUNNING	= 15
> +};
> +
>  #define to_ish_hw(dev) (struct ish_hw *)((dev)->hw)
>  
>  irqreturn_t ish_irq_handler(int irq, void *dev_id);
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index 232c854..5b006f1 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -205,12 +205,15 @@ static void ish_remove(struct pci_dev *pdev)
>  
>  static struct device *ish_resume_device;
>  
> +/* 50ms to get resume response */
> +#define WAIT_FOR_RESUME_ACK_MS		50
> +
>  /**
>   * ish_resume_handler() - Work function to complete resume
>   * @work:	work struct
>   *
>   * The resume work function to complete resume function
> asynchronously.
> - * There are two types of platforms, one where ISH is not powered
> off,
> + * There are two resume paths, one where ISH is not powered off,
>   * in that case a simple resume message is enough, others we need
>   * a reset sequence.
>   */
> @@ -218,20 +221,31 @@ static void ish_resume_handler(struct
> work_struct *work)
>  {
>  	struct pci_dev *pdev = to_pci_dev(ish_resume_device);
>  	struct ishtp_device *dev = pci_get_drvdata(pdev);
> +	uint32_t fwsts;
>  	int ret;
>  
> -	ishtp_send_resume(dev);
> +	/* Get ISH FW status */
> +	fwsts = IPC_GET_ISH_FWSTS(dev->ops->get_fw_status(dev));
>  
> -	/* 50 ms to get resume response */
> -	if (dev->resume_flag)
> -		ret = wait_event_interruptible_timeout(dev-
> >resume_wait,
> -						       !dev-
> >resume_flag,
> -						       msecs_to_jiff
> ies(50));
> +	/*
> +	 * If currently, in ISH FW, sensor app is loaded or beyond
> that,
> +	 * it means ISH isn't powered off, in this case, send a
> resume message.
> +	 */
> +	if (fwsts >= FWSTS_SENSOR_APP_LOADED) {
> +		ishtp_send_resume(dev);
> +
> +		/* Waiting to get resume response */
> +		if (dev->resume_flag)
> +			ret = wait_event_interruptible_timeout(dev-
> >resume_wait,
> +				!dev->resume_flag,
> +				msecs_to_jiffies(WAIT_FOR_RESUME_ACK
> _MS));
> +	}
>  
>  	/*
> -	 * If no resume response. This platform  is not S0ix
> compatible
> -	 * So on resume full reboot of ISH processor will happen, so
> -	 * need to go through init sequence again
> +	 * If in ISH FW, sensor app isn't loaded yet, or no resume
> response.
> +	 * That means this platform is not S0ix compatible, or
> something is
> +	 * wrong with ISH FW. So on resume, full reboot of ISH
> processor will
> +	 * happen, so need to go through init sequence again.
>  	 */
>  	if (dev->resume_flag)
>  		ish_init(dev);
