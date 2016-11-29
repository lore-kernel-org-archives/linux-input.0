From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 0/2] Input: drv266x: Fix misuse of regmap_update_bits
Date: Tue, 29 Nov 2016 11:10:59 -0600
Message-ID: <583DB6A3.8070305@ti.com>
References: <1480438754-14794-1-git-send-email-florian.vaussard@heig-vd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:61300 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbcK2RKn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 12:10:43 -0500
In-Reply-To: <1480438754-14794-1-git-send-email-florian.vaussard@heig-vd.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Vaussard <florian.vaussard@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>

Florian

On 11/29/2016 10:59 AM, Florian Vaussard wrote:
> Hello,
>
> This series fixes similar misues of the regmap_update_bits() API found
> inside the drv2665.c and drv2667.c drivers. More details can be found
> in the message of each patch.
>
> Theses changes are not tested as I do not have the required hardware,
> but the calls to regmap_update_bits() are clearly wrong in the current
> code and the fix seems obvious. Any tests are warmly welcome.
>
> Best regards,
> Florian
>
> Florian Vaussard (2):
>   Input: drv2665: Fix misuse of regmap_update_bits
>   Input: drv2667: Fix misuse of regmap_update_bits

Thanks for the patches what about the drv260x.c?

Dan

>  drivers/input/misc/drv2665.c | 5 +++--
>  drivers/input/misc/drv2667.c | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
>


-- 
------------------
Dan Murphy

