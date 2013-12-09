From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] Input: samsung-keypad - favor platform data if present
Date: Mon, 09 Dec 2013 17:04:14 +0900
Message-ID: <001101cef4b5$4072b400$c1581c00$%han@samsung.com>
References: <20131206100215.GA27763@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:48464 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab3LIIEQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Dec 2013 03:04:16 -0500
In-reply-to: <20131206100215.GA27763@core.coreip.homeip.net>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Joonyoung Shim' <jy0922.shim@samsung.com>, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Friday, December 06, 2013 7:02 PM, Dmitry Torokhov wrote:
> 
> We should be able to override firmware-provided parameters with in-kernel
> data, if needed. To that effect favor platform data, if present, over
> devicetree data.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

It looks good.

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/input/keyboard/samsung-keypad.c | 36 +++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 15 deletions(-)


