From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] HID: use BIT macro instead of plain integers for
 flags
Date: Fri, 8 Dec 2017 11:30:15 -0800
Message-ID: <20171208193015.mhkvpws66vmg37bc@dtor-ws>
References: <20171208142818.15156-1-benjamin.tissoires@redhat.com>
 <20171208142818.15156-2-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:45195 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbdLHTaT (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Dec 2017 14:30:19 -0500
Content-Disposition: inline
In-Reply-To: <20171208142818.15156-2-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 08, 2017 at 03:28:17PM +0100, Benjamin Tissoires wrote:
> This can lead to some hairy situation with the developer losing
> a day or two realizing that 4 should be after 2, not 3.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

Please add

#include <linux/bitops.h>

to make sure we have definition if BIT(), otherwise

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks!

> 
> new in v2
> 
>  include/linux/hid.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index a62ee4a609ac..421b62b77c69 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -494,13 +494,13 @@ struct hid_output_fifo {
>  	char *raw_report;
>  };
>  
> -#define HID_CLAIMED_INPUT	1
> -#define HID_CLAIMED_HIDDEV	2
> -#define HID_CLAIMED_HIDRAW	4
> -#define HID_CLAIMED_DRIVER	8
> +#define HID_CLAIMED_INPUT	BIT(0)
> +#define HID_CLAIMED_HIDDEV	BIT(1)
> +#define HID_CLAIMED_HIDRAW	BIT(2)
> +#define HID_CLAIMED_DRIVER	BIT(3)
>  
> -#define HID_STAT_ADDED		1
> -#define HID_STAT_PARSED		2
> +#define HID_STAT_ADDED		BIT(0)
> +#define HID_STAT_PARSED		BIT(1)
>  
>  struct hid_input {
>  	struct list_head list;
> -- 
> 2.14.3
> 

-- 
Dmitry
