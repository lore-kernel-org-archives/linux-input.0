From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 3/5] HID: sony: Perform CRC check on bluetooth input
 packets
Date: Wed, 5 Oct 2016 10:24:46 +0200
Message-ID: <20161005082446.GA19261@mail.corp.redhat.com>
References: <1475636338-3779-1-git-send-email-roderick@gaikai.com>
 <1475636338-3779-4-git-send-email-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbcJEIYv (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 5 Oct 2016 04:24:51 -0400
Content-Disposition: inline
In-Reply-To: <1475636338-3779-4-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

Hi Roderick,

Thanks for the fast respin.

On Oct 04 2016 or thereabouts, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> ---
>  drivers/hid/hid-sony.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 43bb24c..34988ce 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -36,6 +36,8 @@
>  #include <linux/list.h>
>  #include <linux/idr.h>
>  #include <linux/input/mt.h>
> +#include <linux/crc32.h>
> +#include <asm/unaligned.h>
>  
>  #include "hid-ids.h"
>  
> @@ -1021,6 +1023,7 @@ struct motion_output_report_02 {
>  
>  #define DS4_FEATURE_REPORT_0x02_SIZE 37
>  #define DS4_FEATURE_REPORT_0x81_SIZE 7
> +#define DS4_INPUT_REPORT_0x11_SIZE 78

Just nitpicking, keeping the old define would have not changed a bit,
given that input and output reports on 0x11 are the same :)

Anyway, the 3 first patches are:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

(you can add this to the patches in case of a resubmission, that's
easier to track which patches are reviewed and which are not).

I have a few comments on the 2 next.

Cheers,
Benjamin

>  #define DS4_OUTPUT_REPORT_0x05_SIZE 32
>  #define DS4_OUTPUT_REPORT_0x11_SIZE 78
>  #define SIXAXIS_REPORT_0xF2_SIZE 17
> @@ -1324,6 +1327,21 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
>  	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
>  			size == 64) || ((sc->quirks & DUALSHOCK4_CONTROLLER_BT)
>  			&& rd[0] == 0x11 && size == 78)) {
> +		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
> +			/* CRC check */
> +			u8 bthdr = 0xA1;
> +			u32 crc;
> +			u32 report_crc;
> +
> +			crc = crc32_le(0xFFFFFFFF, &bthdr, 1);
> +			crc = ~crc32_le(crc, rd, DS4_INPUT_REPORT_0x11_SIZE-4);
> +			report_crc = get_unaligned_le32(&rd[DS4_INPUT_REPORT_0x11_SIZE-4]);
> +			if (crc != report_crc) {
> +				hid_dbg(sc->hdev, "DualShock 4 input report's CRC check failed, received crc 0x%0x != 0x%0x\n",
> +					report_crc, crc);
> +				return -EILSEQ;
> +			}
> +		}
>  		dualshock4_parse_report(sc, rd, size);
>  	}
>  
> -- 
> 2.7.4
> 
