From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 3/6] Input: elantech - packet checking for v2 hardware
Date: Thu, 18 Aug 2011 10:49:29 +0800
Message-ID: <CAGS+omA0=Ypm0vRbBkSiGYc_NBf4adCBhPhpbrhineXe1+hcrw@mail.gmail.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-4-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:36752 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab1HRCtw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 22:49:52 -0400
Received: from hpaq3.eem.corp.google.com (hpaq3.eem.corp.google.com [172.25.149.3])
	by smtp-out.google.com with ESMTP id p7I2noPS010276
	for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 19:49:51 -0700
Received: from qwa26 (qwa26.prod.google.com [10.241.193.26])
	by hpaq3.eem.corp.google.com with ESMTP id p7I2nX4M023195
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 19:49:49 -0700
Received: by qwa26 with SMTP id 26so1209993qwa.0
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 19:49:49 -0700 (PDT)
In-Reply-To: <1313632629-23603-4-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On Thu, Aug 18, 2011 at 9:57 AM, JJ Ding <jj_ding@emc.com.tw> wrote:
> For v2 hardware, there is no real parity check, but we can still check
> some constant bits for data integrity.
>
> Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
> ---
>  drivers/input/mouse/elantech.c |   26 +++++++++++++++++++++++---
>  1 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index cf41f23..032181c 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -376,6 +376,25 @@ static int elantech_check_parity_v1(struct psmouse *psmouse)
>               etd->parity[packet[3]] == p3;
>  }
>
> +static int packet_simple_check_v2(struct psmouse *psmouse)
> +{
> +       struct elantech_data *etd = psmouse->private;
> +       unsigned char *packet = psmouse->packet;
> +
> +       if (etd->reports_pressure)
> +               return (packet[0] & 0x0c) == 0x04 &&
> +                      (packet[3] & 0x0f) == 0x02;
> +
> +       if ((packet[0] & 0xc0) == 0x80)
> +               return (packet[0] & 0x0c) == 0x0c &&
> +                      (packet[3] & 0x0e) == 0x08;
> +
> +       return (packet[0] & 0x3c) == 0x3c &&
> +              (packet[1] & 0xf0) == 0x00 &&
> +              (packet[3] & 0x3e) == 0x38 &&
> +              (packet[4] & 0xf0) == 0x00;
> +}
> +
>  /*
>  * Process byte stream from mouse and handle complete packets
>  */
> @@ -398,7 +417,9 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
>                break;
>
>        case 2:
> -               /* We don't know how to check parity in protocol v2 */
> +               if (etd->paritycheck && !packet_simple_check_v2(psmouse))
> +                       return PSMOUSE_BAD_DATA;
> +
>                elantech_report_absolute_v2(psmouse);
>                break;
>        }
> @@ -799,8 +820,7 @@ int elantech_init(struct psmouse *psmouse)
>                etd->hw_version = 2;
>                /* For now show extra debug information */
>                etd->debug = 1;
> -               /* Don't know how to do parity checking for version 2 */
> -               etd->paritycheck = 0;
> +               etd->paritycheck = 1;

If we always do some sort of check, can we just remove etd->paritycheck now?

>
>                if (etd->fw_version >= 0x020800)
>                        etd->reports_pressure = true;
> --
> 1.7.4.1
>
>
