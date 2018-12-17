From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: intel-ish-hid: fixes incorrect error handling
Date: Mon, 17 Dec 2018 15:05:20 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1812171505100.17216@cbobk.fhfr.pm>
References: <1542847953-127599-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542847953-127599-1-git-send-email-bianpan2016@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Bian <bianpan2016@163.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 22 Nov 2018, Pan Bian wrote:

> The memory chunk allocated by hid_allocate_device() should be released
> by hid_destroy_device(), not kfree().
> 
> Fixes: 0b28cb4bcb1("HID: intel-ish-hid: ISH HID client driver")
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/hid/intel-ish-hid/ishtp-hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
> index cd23903..e918d78 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
> @@ -222,7 +222,7 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
>  err_hid_device:
>  	kfree(hid_data);
>  err_hid_data:
> -	kfree(hid);
> +	hid_destroy_device(hid);
>  	return rv;

Applied to for-4.20/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
