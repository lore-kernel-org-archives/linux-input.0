From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH v5 1/2] input: add support for Nomadik SKE keypad controller
Date: Wed, 15 Sep 2010 13:03:14 +0530
Message-ID: <4C9076BA.80106@codeaurora.org>
References: <1284535498-9954-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:37162 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0IOHdT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 03:33:19 -0400
In-Reply-To: <1284535498-9954-1-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Kwangwoo LEE <kwangwoo.lee@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

Hi Sundar,

On 9/15/2010 12:54 PM, Sundar Iyer wrote:
> Add support for the keypad controller in the Scroll Key Encoder (SKE)
> module on the Nomadik family and the DB8500 SoC.
> 
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
> ---
> Thanx a bunch to Dmitry for being such a nice and persistent help :)
> 
> v4:
>  - IRQ handler is no longer threaded
>  - incorporated Dmitry's comments to make sure multikey is working
>  - assorted comments from Trilok
>  - pin configuration mistake pointed out thanx to Kwangwoo LEE

Looks good to me. Thanks.

Acked-by: Trilok Soni <tsoni@codeaurora.org>

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
