From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: Enable Sunrise Point-H ish driver
Date: Fri, 17 Aug 2018 13:37:59 -0700
Message-ID: <bc6683f383ac4dd120e413f62fce68f0f170d5d8.camel@linux.intel.com>
References: <23171b1a3740407eac5d5c22548ce107d8edde59.camel@linux.intel.com>
         <20180817201614.11971-1-linux@progandy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817201614.11971-1-linux@progandy.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Bosch <linux@progandy.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2018-08-17 at 22:16 +0200, Andreas Bosch wrote:
> Added PCI ID for Sunrise Point-H ISH.
> 
> Signed-off-by: Andreas Bosch <linux@progandy.de>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> I hope this patch arrives correctly.
> ---
>  drivers/hid/intel-ish-hid/ipc/hw-ish.h  | 1 +
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> index 97869b7410eb..da133716bed0 100644
> --- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> +++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> @@ -29,6 +29,7 @@
>  #define CNL_Ax_DEVICE_ID	0x9DFC
>  #define GLK_Ax_DEVICE_ID	0x31A2
>  #define CNL_H_DEVICE_ID		0xA37C
> +#define SPT_H_DEVICE_ID		0xA135
>  
>  #define	REVISION_ID_CHT_A0	0x6
>  #define	REVISION_ID_CHT_Ax_SI	0x0
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index a2c53ea3b5ed..c7b8eb32b1ea 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -38,6 +38,7 @@ static const struct pci_device_id ish_pci_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CNL_Ax_DEVICE_ID)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, GLK_Ax_DEVICE_ID)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CNL_H_DEVICE_ID)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, SPT_H_DEVICE_ID)},
>  	{0, }
>  };
>  MODULE_DEVICE_TABLE(pci, ish_pci_tbl);
