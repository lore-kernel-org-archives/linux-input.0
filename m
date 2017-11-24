From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/1] Input: ims-pcu - fix typo in an error log
Date: Thu, 23 Nov 2017 23:17:03 -0800
Message-ID: <1511507823.8230.8.camel@perches.com>
References: <1511506772-21412-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511506772-21412-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-input@vger.kernel.org

On Fri, 2017-11-24 at 14:59 +0800, Zhen Lei wrote:
> Tiny typo fixed in an error log.
> 
> I found this when I backported the CVE-2017-16645 patch:
> ea04efee7635 ("Input: ims-psu - check if CDC union descriptor is sane")
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/input/misc/ims-pcu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
[]
> @@ -1651,7 +1651,7 @@ static void ims_pcu_buffers_free(struct ims_pcu *pcu)
>  				return union_desc;
> 
>  			dev_err(&intf->dev,
> -				"Union descriptor to short (%d vs %zd\n)",
> +				"Union descriptor too short (%d vs %zd\n)",

And this format is incorrect too.  It should be:

+				"Union descriptor too short (%d vs %zd)\n",

with the close parenthesis before the newline, not after.
