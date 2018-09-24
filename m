From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: logitech: fix a used uninitialized GCC warning
Date: Mon, 24 Sep 2018 11:31:45 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1809241131230.15880@cbobk.fhfr.pm>
References: <1536824470-36659-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536824470-36659-1-git-send-email-zhongjiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhong jiang <zhongjiang@huawei.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 13 Sep 2018, zhong jiang wrote:

> Fix the following compile warning:
> 
> drivers/hid/hid-logitech-hidpp.c: In function 'hi_res_scroll_enable':
> drivers/hid/hid-logitech-hidpp.c:2714:54: warning: 'multiplier' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   hidpp->vertical_wheel_counter.resolution_multiplier = multiplier;
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
> v1->v2:
>      According to Benjamin's suggestion, To initialize the value
> and remove the duplicated assignement. 

Applied to for-4.20/logitech-highres. Thanks,

-- 
Jiri Kosina
SUSE Labs
