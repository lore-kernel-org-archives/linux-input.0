From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: add missing \n to end of dev_warn messages
Date: Wed, 28 Sep 2016 20:39:54 +0200
Message-ID: <20160928183954.GJ19261@mail.corp.redhat.com>
References: <20160927185844.14659-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752567AbcI1TBK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Sep 2016 15:01:10 -0400
Content-Disposition: inline
In-Reply-To: <20160927185844.14659-1-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sep 27 2016 or thereabouts, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trival fix, dev_warn messages are missing a \n, so add it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

> ---
>  include/linux/hid.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 75b66ec..b2ec827 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -837,7 +837,7 @@ __u32 hid_field_extract(const struct hid_device *hid, __u8 *report,
>   */
>  static inline void hid_device_io_start(struct hid_device *hid) {
>  	if (hid->io_started) {
> -		dev_warn(&hid->dev, "io already started");
> +		dev_warn(&hid->dev, "io already started\n");
>  		return;
>  	}
>  	hid->io_started = true;
> @@ -857,7 +857,7 @@ static inline void hid_device_io_start(struct hid_device *hid) {
>   */
>  static inline void hid_device_io_stop(struct hid_device *hid) {
>  	if (!hid->io_started) {
> -		dev_warn(&hid->dev, "io already stopped");
> +		dev_warn(&hid->dev, "io already stopped\n");
>  		return;
>  	}
>  	hid->io_started = false;
> -- 
> 2.9.3
> 
