From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 07/11] Input: synaptics-rmi4 - f11: fix bitmap irq check
Date: Thu, 2 Jul 2015 10:50:50 -0700
Message-ID: <559579FA.2080601@synaptics.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com> <1435087050-11444-8-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [192.147.44.131] ([192.147.44.131]:51242 "EHLO
	us-mx1.synaptics.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754141AbbGBRvL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jul 2015 13:51:11 -0400
In-Reply-To: <1435087050-11444-8-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>
Cc: Stephen Chandler Paul <cpaul@redhat.com>, benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Huang <vincent.huang@tw.synaptics.com>

On 06/23/2015 12:17 PM, Benjamin Tissoires wrote:
> num_irq_regs is the count of registers of 1 bytes that we use to check
> the irqs. bitmap_and() expects the number of bits.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

>   drivers/input/rmi4/rmi_f11.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index 99d6181..c3b757b 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -726,12 +726,12 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
>   		}
>   
>   		abs_bits = bitmap_and(f11->result_bits, irq_bits, f11->abs_mask,
> -				      num_irq_regs);
> +				      num_irq_regs * 8);
>   		if (abs_bits)
>   			rmi_f11_abs_pos_report(f11, sensor, finger_state, i);
>   
>   		rel_bits = bitmap_and(f11->result_bits, irq_bits, f11->rel_mask,
> -				      num_irq_regs);
> +				      num_irq_regs * 8);
>   		if (rel_bits)
>   			rmi_f11_rel_pos_report(sensor, i);
>   	}

