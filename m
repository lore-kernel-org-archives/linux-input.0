From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS: fix protcol -> protocol
Date: Mon, 12 Dec 2016 10:56:08 +0100
Message-ID: <20161212095608.GA18387@pali>
References: <20161212095442.2391-1-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35437 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750712AbcLLJ4T (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Dec 2016 04:56:19 -0500
Content-Disposition: inline
In-Reply-To: <20161212095442.2391-1-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 12 December 2016 07:53:54 Marcos Paulo de Souza wrote:
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
>  drivers/input/mouse/alps.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
> index b9417e2..50f05a7 100644
> --- a/drivers/input/mouse/alps.h
> +++ b/drivers/input/mouse/alps.h
> @@ -146,7 +146,7 @@ struct alps_protocol_info {
>   *   (aka command mode response) identifies the firmware minor version.  This
>   *   can be used to distinguish different hardware models which are not
>   *   uniquely identifiable through their E7 responses.
> - * @protocol_info: information about protcol used by the device.
> + * @protocol_info: information about protocol used by the device.
>   *
>   * Many (but not all) ALPS touchpads can be identified by looking at the
>   * values returned in the "E7 report" and/or the "EC report."  This table

Thanks! Add my Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

-- 
Pali Rohár
pali.rohar@gmail.com
