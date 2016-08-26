From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH -next] HID: intel-ish-hid: use module_pci_driver to
 simplify the code
Date: Fri, 26 Aug 2016 12:00:24 -0700
Message-ID: <1472238024.2694.4.camel@linux.intel.com>
References: <1471793316-23880-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60486 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752016AbcHZTA1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Aug 2016 15:00:27 -0400
In-Reply-To: <1471793316-23880-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

On Sun, 2016-08-21 at 15:28 +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Use the module_pci_driver() macro to make the code simpler
> by eliminating module_init and module_exit calls.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index b14d6f4..42f0bee 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -311,18 +311,7 @@ static struct pci_driver ish_driver = {
>  	.driver.pm = ISHTP_ISH_PM_OPS,
>  };
>  
> -static int __init ish_driver_init(void)
> -{
> -	return pci_register_driver(&ish_driver);
> -}
> -
> -static void __exit ish_driver_exit(void)
> -{
> -	pci_unregister_driver(&ish_driver);
> -}
> -
> -module_init(ish_driver_init);
> -module_exit(ish_driver_exit);
> +module_pci_driver(ish_driver);
>  
>  /* Original author */
>  MODULE_AUTHOR("Daniel Drubin <daniel.drubin@intel.com>");
> 
> 
> 
