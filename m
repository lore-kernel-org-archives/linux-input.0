From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: hidraw: open count should not increase if
 error
Date: Tue, 27 Sep 2011 18:43:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1109271843030.24692@pobox.suse.cz>
References: <1317145318-19656-1-git-send-email-helloin.amit@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34035 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997Ab1I0QnS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Sep 2011 12:43:18 -0400
In-Reply-To: <1317145318-19656-1-git-send-email-helloin.amit@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Amit Nagal <helloin.amit@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 27 Sep 2011, Amit Nagal wrote:

> In hidraw_open, if hid_hw_power returns with error,
> hidraw device open count should not increase.
> 
> Signed-off-by: Amit Nagal <helloin.amit@gmail.com>
> ---
>  drivers/hid/hidraw.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index c841a8e..09bbcc9 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -271,8 +271,10 @@ static int hidraw_open(struct inode *inode, struct file *file)
>  	dev = hidraw_table[minor];
>  	if (!dev->open++) {
>  		err = hid_hw_power(dev->hid, PM_HINT_FULLON);
> -		if (err < 0)
> +		if (err < 0) {
> +			dev->open--;
>  			goto out_unlock;
> +		}
>  
>  		err = hid_hw_open(dev->hid);
>  		if (err < 0) {

Good catch, thanks. Applied.

-- 
Jiri Kosina
SUSE Labs
