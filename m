From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: USB HID Telephony page causes odd mouse behavior
Date: Mon, 13 Oct 2014 11:43:57 -0700
Message-ID: <20141013184357.GB35440@dtor-ws>
References: <2b737611d4ef4409993f72bb4dc921c9@usscmb04.plt.plantronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:43591 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418AbaJMSoD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Oct 2014 14:44:03 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so6088162pdb.3
        for <linux-input@vger.kernel.org>; Mon, 13 Oct 2014 11:44:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2b737611d4ef4409993f72bb4dc921c9@usscmb04.plt.plantronics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Cole, JD" <JD.Cole@plantronics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Junge, Terry" <Terry.Junge@plantronics.com>, Jiri Kosina <jkosina@suse.cz>

Adding Jiri...

On Mon, Oct 13, 2014 at 03:43:26PM +0000, Cole, JD wrote:
> Hi All,
> 
> We have received multiple bug reports that Plantronics headsets are causing or interfering with mouse events. We've identified the root cause of this in hid-input.c, where un-handled usages (from any usage page) will be mapped to miscellaneous LEDs, buttons, or movements. In short, press a USB equipped volume, mute, or hang-up button and get a random mouse event.
> 
> This intermittent behavior isn't consistent across all headsets since with similar capabilities as usages marked 'constant' are ignored early on in 'hidinput_configure_usage'. While interpretation of the correct use of 'constant usages' is left to the individual vendors, we still feel that the HID input driver should not be mapping otherwise unhandled usages to LED_/BIN_/REL_/ABS_MISC usages events.
> 
> Solving this issue is a larger effort and it's hard for us to comment on the needs of other manufacturers. That said, we would like to propose the attached interim fix which assumes mouse events don't come from the Telephony page.
> 
> jd
> 
> ------------------ snip --------------------
> From 647545b985b75434609c58dda2ef6612e231a44e Mon Sep 17 00:00:00 2001
> From: JD Cole <jd.cole@plantronics.com>
> Date: Fri, 10 Oct 2014 17:41:27 -0400
> Subject: [PATCH] Prevent HID Telephony page events from being mapped to
>  miscellaneous buttons.
> 
> The hid-input previously interpreted un-mapped telephony page usages, incorrectly,
> to misc mouse, button, or LED messages. Exhibited most commonly as an USB telephony
> headsets causing intermittent or "random" mouse behavior.
> 
> Signed-off-by: JD Cole <jd.cole@plantronics.com>
> ---
>  drivers/hid/hid-input.c | 3 +++
>  include/linux/hid.h     | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 012880a..1e9ef8e 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -895,6 +895,9 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>                 }
>                 break;
> 
> +       case HID_UP_TELEPHONY:
> +               goto ignore;
> +
>         default:
>         unknown:
>                 if (field->report_size == 1) {
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 4f8aa47..6489a93 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -159,6 +159,7 @@ struct hid_item {
>  #define HID_UP_LED             0x00080000
>  #define HID_UP_BUTTON          0x00090000
>  #define HID_UP_ORDINAL         0x000a0000
> +#define HID_UP_TELEPHONY               0x000b0000
>  #define HID_UP_CONSUMER                0x000c0000
>  #define HID_UP_DIGITIZER       0x000d0000
>  #define HID_UP_PID             0x000f0000
> --
> 1.8.3.1
> 
> 
> ________________________________
> 
> CONFIDENTIALITY NOTICE: This e-mail transmission, and any documents, files or previous e-mail messages attached to it, may contain information that is confidential and/or legally privileged. If you are not the intended recipient, or a person responsible for delivering it to the intended recipient, please DO NOT disclose the contents to another person, store or copy the information in any medium, or use any of the information contained in or attached to this transmission for any purpose. If you have received this transmission in error, please immediately notify the sender by reply email or at privacy@plantronics.com, and destroy the original transmission and its attachments without reading or saving in any manner.
> 
> For further information about Plantronics - the Company, its products, brands, partners, please visit our website www.plantronics.com.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
