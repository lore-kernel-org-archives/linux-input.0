From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] Input: elan_i2c - add Host Notify support
Date: Fri, 30 Sep 2016 16:57:44 -0700
Message-ID: <20160930235744.GB1680@dtor-ws>
References: <1475073244-23068-1-git-send-email-benjamin.tissoires@redhat.com>
 <1475073244-23068-4-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35981 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbcI3X54 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Sep 2016 19:57:56 -0400
Content-Disposition: inline
In-Reply-To: <1475073244-23068-4-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Adrian Alves <aalves@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 28, 2016 at 04:34:03PM +0200, Benjamin Tissoires wrote:
> The Thinkpad series 13 uses Host Notify to report the interrupt.
> Add elan_smb_alert() to handle those interrupts and disable the irq
> handling on this case.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 100 ++++++++++++++++++++++++++++--------
>  1 file changed, 78 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 2de1f75..11671c7 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -96,6 +96,34 @@ struct elan_tp_data {
>  	bool			baseline_ready;
>  };
>  
> +static inline void elan_enable_irq(struct elan_tp_data *tp)
> +{
> +	if (tp->client->irq)
> +		enable_irq(tp->client->irq);

Hmm, so I wonder, why alert is not implemented as irqchip? Then clients
would not need to be bothered with these details, they'd simply requster
and manipulate irqs.

Thanks.

-- 
Dmitry
