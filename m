From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/7] input: touchscreen: use to_delayed_work
Date: Sat, 2 Jan 2016 21:07:28 -0800
Message-ID: <20160103050728.GF23680@dtor-ws>
References: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
 <178deb25bed7a09d97a5b37e75fa4db9f3194e1d.1451659910.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35713 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcACFHb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jan 2016 00:07:31 -0500
Content-Disposition: inline
In-Reply-To: <178deb25bed7a09d97a5b37e75fa4db9f3194e1d.1451659910.git.geliangtang@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 01, 2016 at 10:59:08PM +0800, Geliang Tang wrote:
> Use to_delayed_work() instead of open-coding it.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/pcap_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/pcap_ts.c b/drivers/input/touchscreen/pcap_ts.c
> index 23a354a..0e3fc41 100644
> --- a/drivers/input/touchscreen/pcap_ts.c
> +++ b/drivers/input/touchscreen/pcap_ts.c
> @@ -87,7 +87,7 @@ static void pcap_ts_read_xy(void *data, u16 res[2])
>  
>  static void pcap_ts_work(struct work_struct *work)
>  {
> -	struct delayed_work *dw = container_of(work, struct delayed_work, work);
> +	struct delayed_work *dw = to_delayed_work(work);
>  	struct pcap_ts *pcap_ts = container_of(dw, struct pcap_ts, work);
>  	u8 ch[2];
>  
> -- 
> 2.5.0
> 
> 

-- 
Dmitry
