From: "Ooi, Joyce" <joyce.ooi@intel.com>
Subject: RE: [PATCH 3/4] hid: intel-ish-hid: ipc: Fix driver reinit failure
Date: Wed, 19 Oct 2016 09:58:31 +0000
Message-ID: <D53702B8F0ACD34B9B1D7D82EE03C04501273950@PGSMSX101.gar.corp.intel.com>
References: <1476548564-20202-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1476548564-20202-4-git-send-email-srinivas.pandruvada@linux.intel.com>
 <9577C59DB499174B9340876B077C2E9566FF6E12@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21128 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941389AbcJSOZD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Oct 2016 10:25:03 -0400
In-Reply-To: <9577C59DB499174B9340876B077C2E9566FF6E12@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jikos@kernel.org" <jikos@kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Xu, Even" <even.xu@intel.com>, "Ooi, Joyce" <joyce.ooi@intel.com>, "Ong, Boon Leong" <boon.leong.ong@intel.com>, "Kweh, Hock Leong" <hock.leong.kweh@intel.com>

> -----Original Message-----
> From: Srinivas Pandruvada [mailto:srinivas.pandruvada@linux.intel.com]
> Sent: Sunday, October 16, 2016 12:23 AM
> To: jikos@kernel.org
> Cc: linux-input@vger.kernel.org; Xu, Even <even.xu@intel.com>
> Subject: [PATCH 3/4] hid: intel-ish-hid: ipc: Fix driver reinit failure
> 
> From: Even Xu <even.xu@intel.com>
> 
> When built as a module, modprobe followed by rmmod can fail because DMA
> was still active. So to fix this, DMA needs to be disabled during module exit.
> 
> This change disables DMA during modules exit and change the ISH PCI device
> status to D3.
> 
> Signed-off-by: Even Xu <even.xu@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/hid/intel-ish-hid/ipc/ipc.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
> index 0e0dfa6..66c6755 100644
> --- a/drivers/hid/intel-ish-hid/ipc/ipc.c
> +++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
> @@ -905,6 +905,26 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
>   */
>  void	ish_device_disable(struct ishtp_device *dev)
>  {
> +	struct pci_dev *pdev = dev->pdev;
> +	uint16_t csr;
> +
> +	if (!pdev)
> +		return;
> +
> +	/* Disable dma communication between FW and host */
> +	if (ish_disable_dma(dev)) {
> +		dev_err(&pdev->dev,
> +			"Can't reset - stuck with DMA in-progress\n");
> +		return;
> +	}
> +

> +	/* Put ISH to D3 state for power saving */
> +	pci_read_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL, &csr);
> +
> +	csr &= ~PCI_PM_CTRL_STATE_MASK;
> +	csr |= PCI_D3hot;
> +	pci_write_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL, csr);
> +

Do you think it would be cleaner if we use pci_set_power_state() ?
http://lxr.free-electrons.com/source/drivers/pci/pci.c#L877

>  	dev->dev_state = ISHTP_DEV_DISABLED;
>  	ish_clr_host_rdy(dev);
>  }
> --
> 2.7.4

