From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: alps: fix stick device not working after resume
Date: Mon, 19 Sep 2016 14:37:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1609191436370.22028@cbobk.fhfr.pm>
References: <20160919074139.2551-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41047 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753895AbcISMhL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Sep 2016 08:37:11 -0400
In-Reply-To: <20160919074139.2551-1-kai.heng.feng@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

On Mon, 19 Sep 2016, Kai-Heng Feng wrote:

> The stick device does not work after resume, add U1_SP_ABS_MODE flag can
> make the device work after resume.

Do you happen to have any more details on why it doesn't work without 
U1_SP_ABS_MODE? Or was this a pure guesswork?

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/hid-alps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
> index 048befd..390f8d3 100644
> --- a/drivers/hid/hid-alps.c
> +++ b/drivers/hid/hid-alps.c
> @@ -244,13 +244,13 @@ static int alps_raw_event(struct hid_device *hdev,
>  static int alps_post_reset(struct hid_device *hdev)
>  {
>  	return u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
> -				NULL, U1_TP_ABS_MODE, false);
> +				NULL, U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
>  }
>  
>  static int alps_post_resume(struct hid_device *hdev)
>  {
>  	return u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
> -				NULL, U1_TP_ABS_MODE, false);
> +				NULL, U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
>  }
>  #endif /* CONFIG_PM */

-- 
Jiri Kosina
SUSE Labs

