From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: Enable Cannon Lake and Coffee Lake
 laptop/desktop
Date: Mon, 08 Jan 2018 14:12:53 -0800
Message-ID: <1515449573.585.18.camel@linux.intel.com>
References: <20171220192410.87748-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171220192410.87748-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jiri,

Hope this fine to queue this for 4.16.

Thanks,
Srinivas

On Wed, 2017-12-20 at 11:24 -0800, Srinivas Pandruvada wrote:
> Added PCI ID for Cannon Lake and Coffee Lake laptop/desktop skews.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c
> om>
> ---
>  drivers/hid/intel-ish-hid/ipc/hw-ish.h  | 1 +
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> index 2aac097c3f70..97869b7410eb 100644
> --- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> +++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> @@ -28,6 +28,7 @@
>  #define SPT_Ax_DEVICE_ID	0x9D35
>  #define CNL_Ax_DEVICE_ID	0x9DFC
>  #define GLK_Ax_DEVICE_ID	0x31A2
> +#define CNL_H_DEVICE_ID		0xA37C
>  
>  #define	REVISION_ID_CHT_A0	0x6
>  #define	REVISION_ID_CHT_Ax_SI	0x0
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index 20d824f74f99..582e449be9fe 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -37,6 +37,7 @@ static const struct pci_device_id ish_pci_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, SPT_Ax_DEVICE_ID)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CNL_Ax_DEVICE_ID)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, GLK_Ax_DEVICE_ID)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CNL_H_DEVICE_ID)},
>  	{0, }
>  };
>  MODULE_DEVICE_TABLE(pci, ish_pci_tbl);
