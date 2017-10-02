From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: add comment for power callback in struct
 hid_ll_driver
Date: Mon, 2 Oct 2017 12:47:33 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710021247270.17517@jbgna.fhfr.qr>
References: <1505900436-31183-1-git-send-email-climbbb.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750984AbdJBKre (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Oct 2017 06:47:34 -0400
In-Reply-To: <1505900436-31183-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaejoong Kim <climbbb.kim@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org

On Wed, 20 Sep 2017, Jaejoong Kim wrote:

> There is a missing comment in struct hid_ll_driver. So, add it.
> 
> Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
> ---
>  include/linux/hid.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index ab05a86..7c3d4a1 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -753,6 +753,7 @@ struct hid_driver {
>   * @stop: called on remove
>   * @open: called by input layer on open
>   * @close: called by input layer on close
> + * @power: request underlying hardware to enter requested power mode
>   * @parse: this method is called only once to parse the device data,
>   *	   shouldn't allocate anything to not leak memory
>   * @request: send report request to device (e.g. feature report)

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

