From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 6/6] Input: elantech - add v3 hardware support
Date: Thu, 18 Aug 2011 11:30:32 +0800
Message-ID: <4E4C8758.4020205@cn.fujitsu.com>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:63542 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752706Ab1HRDbe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 23:31:34 -0400
In-Reply-To: <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

On 08/18/2011 09:57 AM, JJ Ding wrote:
> v3 hardware's packet format is almost identical to v2 (one/three finger touch),
> except when sensing two finger touch, the hardware sends 12 bytes of data.
>
> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
> ---
>   Documentation/input/elantech.txt |  104 ++++++++++++++++--
>   drivers/input/mouse/elantech.c   |  218 ++++++++++++++++++++++++++++++++++---
>   drivers/input/mouse/elantech.h   |   11 ++
>   3 files changed, 303 insertions(+), 30 deletions(-)

> +The packet format is exactly the same for two finger touch, except the hardware
> +sends two 6 byte packets. The first packet contains data for the first finger,
> +the second packet has data for the second finger. So for two finger touch a
> +total of 12 bytes are sent.
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index ddd40eb..e13a719 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -108,6 +108,16 @@ static int elantech_read_reg(struct psmouse *psmouse, unsigned char reg,
>   			rc = -1;
>   		}
>   		break;
> +
> +	case 3:
> +		if (elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
> +		    elantech_ps2_command(psmouse, NULL, ETP_REGISTER_READWRITE) ||
> +		    elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
> +		    elantech_ps2_command(psmouse, NULL, reg) ||
> +		    elantech_ps2_command(psmouse, param, PSMOUSE_CMD_GETINFO)) {
> +			rc = -1;
> +		}
Prefer to remove these big brace ?
also with "case 1, case 2 "?
> +		break;
>   	}
>
>   	if (rc)
> @@ -154,6 +164,18 @@ static int elantech_write_reg(struct psmouse *psmouse, unsigned char reg,
>   			rc = -1;
>   		}
>   		break;
> +
> +	case 3:
> +		if (elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
> +		    elantech_ps2_command(psmouse, NULL, ETP_REGISTER_READWRITE) ||
> +		    elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
> +		    elantech_ps2_command(psmouse, NULL, reg) ||
> +		    elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
> +		    elantech_ps2_command(psmouse, NULL, val) ||
> +		    elantech_ps2_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11)) {
> +			rc = -1;
> +		}
ditto

--
Thanks
Wanlong Gao
