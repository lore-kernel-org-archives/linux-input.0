From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] Input: samsung-keypad - favor platform data if present
Date: Fri, 06 Dec 2013 19:33:06 +0900
Message-ID: <52A1A7E2.2090304@samsung.com>
References: <20131206100215.GA27763@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54383 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab3LFKcd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Dec 2013 05:32:33 -0500
In-reply-to: <20131206100215.GA27763@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Sachin Kamat <sachin.kamat@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, linux-kernel@vger.kernel.org

Hi,

On 12/06/2013 07:02 PM, Dmitry Torokhov wrote:
> We should be able to override firmware-provided parameters with in-kernel
> data, if needed. To that effect favor platform data, if present, over
> devicetree data.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>   drivers/input/keyboard/samsung-keypad.c | 36 +++++++++++++++++++--------------
>   1 file changed, 21 insertions(+), 15 deletions(-)

Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>

Thanks.
