From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 4/6] Input: elantech - work around EC buffer
Date: Thu, 18 Aug 2011 11:07:23 +0800
Message-ID: <4E4C81EB.7040303@cn.fujitsu.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-5-git-send-email-jj_ding@emc.com.tw>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:52693 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752706Ab1HRDI3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 23:08:29 -0400
In-Reply-To: <1313632629-23603-5-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On 08/18/2011 09:57 AM, JJ Ding wrote:
> With some EC chips, when we resync due to bad packets, those bad bytes would
> still remain in EC's buffer area. That makes us always get bad data back,
> no matter what.
>
> So shift packet for 1 byte when encounter bad packet, until we get rid of those
> bytes.
>
> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
> ---
>   drivers/input/mouse/elantech.c |    9 +++++++--
>   1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 032181c..7b9b6e5 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -411,20 +411,25 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
>   	switch (etd->hw_version) {
>   	case 1:
>   		if (etd->paritycheck&&  !elantech_check_parity_v1(psmouse))
> -			return PSMOUSE_BAD_DATA;
> +			goto bad_packet;
>
>   		elantech_report_absolute_v1(psmouse);
>   		break;
>
>   	case 2:
>   		if (etd->paritycheck&&  !packet_simple_check_v2(psmouse))
> -			return PSMOUSE_BAD_DATA;
> +			goto bad_packet;
>
>   		elantech_report_absolute_v2(psmouse);
>   		break;
>   	}
>
>   	return PSMOUSE_FULL_PACKET;
> +
> + bad_packet:
You may introduce space here.
> +	memmove(psmouse->packet, psmouse->packet + 1, psmouse->pktsize - 1);
> +	psmouse->pktcnt--;
> +	return PSMOUSE_GOOD_DATA;
>   }
>
>   /*


-- 
Thanks
Wanlong Gao
