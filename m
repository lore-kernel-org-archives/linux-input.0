From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] drivers: hid: Add a module description line to the
 hid_hyperv driver
Date: Sat, 1 Jun 2019 00:19:11 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1906010018310.1962@cbobk.fhfr.pm>
References: <20190530173720.17994-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530173720.17994-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Joseph Salisbury <Joseph.Salisbury@microsoft.com>
List-Id: linux-input@vger.kernel.org

On Thu, 30 May 2019, Sasha Levin wrote:

> From: Joseph Salisbury <Joseph.Salisbury@microsoft.com>
> 
> This patch only adds a MODULE_DESCRIPTION statement to the driver.
> This change is only cosmetic, so there should be no runtime impact.
> 
> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/hid/hid-hyperv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index 704049e62d58a..d3311d714d359 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -614,5 +614,7 @@ static void __exit mousevsc_exit(void)
>  }
>  
>  MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Microsoft Hyper-V Synthetic HID Driver");
> +

Is there a reason why you didn't CC Joseph on this submission?

CCing Joseph and applying. Thanks,

-- 
Jiri Kosina
SUSE Labs
