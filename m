From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH trivial 1/4] HID: picoLCD: Spelling
 s/REPORT_WRTIE_MEMORY/REPORT_WRITE_MEMORY/
Date: Sat, 18 Feb 2017 10:24:20 +0100
Message-ID: <20170218102420.31f1b8ca@uranus>
References: <1487345799-1638-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:43917 "EHLO
        hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdBRJeq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Feb 2017 04:34:46 -0500
In-Reply-To: <1487345799-1638-1-git-send-email-geert+renesas@glider.be>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Geert, Jiri,

Fine with me,
Acked-by: Bruno Prémont <bonbons@linux-vserver.org>

On Fri, 17 Feb 2017 16:36:36 Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Bruno Prémont <bonbons@linux-vserver.org>
> Cc: linux-input@vger.kernel.org
> ---
>  drivers/hid/hid-picolcd_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
> index 3c13af6844108f97..3e0feb4bb5380978 100644
> --- a/drivers/hid/hid-picolcd_debugfs.c
> +++ b/drivers/hid/hid-picolcd_debugfs.c
> @@ -736,7 +736,7 @@ void picolcd_debug_raw_event(struct picolcd_data *data,
>  		}
>  		break;
>  	case REPORT_MEMORY:
> -		/* Data buffer in response to REPORT_READ_MEMORY or REPORT_WRTIE_MEMORY */
> +		/* Data buffer in response to REPORT_READ_MEMORY or REPORT_WRITE_MEMORY */
>  		snprintf(buff, BUFF_SZ, "report %s (%d, size=%d)\n",
>  			"REPORT_MEMORY", report->id, size-1);
>  		hid_debug_event(hdev, buff);

