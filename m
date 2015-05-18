From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] HID: rmi: fix some harmless BIT() mistakes
Date: Mon, 18 May 2015 11:24:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505181123570.8186@pobox.suse.cz>
References: <20150514083256.GA1665@mwanda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20150514083256.GA1665@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>
List-Id: linux-input@vger.kernel.org

On Thu, 14 May 2015, Dan Carpenter wrote:

> These defines are used like this:
> 
> 	if (!(test_bit(RMI_STARTED, &hdata->flags)))
> 
> So the intent was to use bits 0, 1 and 2 but because of the extra BIT()
> shifts we're actually using 1, 2 and 4.  It's harmless because it's done
> consistently but static checkers will complain.
> 
> Fixes: 9fb6bf02e3ad ('HID: rmi: introduce RMI driver for Synaptics touchpads')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 368ffdf..2f3e51d 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -29,9 +29,9 @@
>  #define RMI_SET_RMI_MODE_REPORT_ID	0x0f /* Feature Report */
>  
>  /* flags */
> -#define RMI_READ_REQUEST_PENDING	BIT(0)
> -#define RMI_READ_DATA_PENDING		BIT(1)
> -#define RMI_STARTED			BIT(2)
> +#define RMI_READ_REQUEST_PENDING	0
> +#define RMI_READ_DATA_PENDING		1
> +#define RMI_STARTED			2

Applied to for-4.2/upstream, thanks.

-- 
Jiri Kosina
SUSE Labs
