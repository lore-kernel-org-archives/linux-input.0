From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: Fix !CONFIG_PM build warning
Date: Sat, 29 Oct 2016 08:49:23 -0700
Message-ID: <1477756163.8025.0.camel@linux.intel.com>
References: <20161029111740.741-1-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161029111740.741-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 2016-10-29 at 13:17 +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Fix
> 
>   drivers/hid/intel-ish-hid/ipc/pci-ish.c:247:12: warning:
> ‘ish_suspend’ defined but not used [-Wunused-function]
>    static int ish_suspend(struct device *device)
>               ^
>   drivers/hid/intel-ish-hid/ipc/pci-ish.c:282:12: warning:
> ‘ish_resume’ defined but not used [-Wunused-function]
>    static int ish_resume(struct device *device)
>             ^
> by sticking them in the CONFIG_PM range too.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>
> Cc: linux-input@vger.kernel.org

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>-

> ---
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index 42f0beeb09fd..7e3622a724aa 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -202,6 +202,7 @@ static void ish_remove(struct pci_dev *pdev)
>  	kfree(ishtp_dev);
>  }
>  
> +#ifdef CONFIG_PM
>  static struct device *ish_resume_device;
>  
>  /**
> @@ -293,7 +294,6 @@ static int ish_resume(struct device *device)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
>  static const struct dev_pm_ops ish_pm_ops = {
>  	.suspend = ish_suspend,
>  	.resume = ish_resume,
> @@ -301,7 +301,7 @@ static const struct dev_pm_ops ish_pm_ops = {
>  #define ISHTP_ISH_PM_OPS	(&ish_pm_ops)
>  #else
>  #define ISHTP_ISH_PM_OPS	NULL
> -#endif
> +#endif /* CONFIG_PM */
>  
>  static struct pci_driver ish_driver = {
>  	.name = KBUILD_MODNAME,
