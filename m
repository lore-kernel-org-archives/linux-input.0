From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v2 2/3] Input: add support for the STMicroelectronics
 FingerTip touchscreen
Date: Thu, 16 Mar 2017 09:22:16 +0100
Message-ID: <a78e77c3-7bc5-95a8-fbf9-31baf91cdd56@samsung.com>
References: <20170210021721.12218-1-andi.shyti@samsung.com>
 <CGME20170210021729epcas1p3e11cade2daa21d2dd23839975e29acb6@epcas1p3.samsung.com>
 <20170210021721.12218-3-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:33732 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdCPIdX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Mar 2017 04:33:23 -0400
In-reply-to: <20170210021721.12218-3-andi.shyti@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>

Hi Andi,

On 10.02.2017 03:17, Andi Shyti wrote:
(...)
> +
> +	err = devm_request_threaded_irq(&client->dev, client->irq,
> +					NULL, stmfts_irq_handler,
> +					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +					"stmfts_irq", sdata);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Disable irq they, they are not needed at this stage.
> +	 * One possible case when an IRQ can be already rased is e.g. if the
> +	 * regulator is set as always on and the stmfts device sends an IRQ as
> +	 * soon as it gets powered, de-synchronizing the power on sequence.
> +	 * During power on, the device will be reset and all the initialization
> +	 * IRQ will be resent.
> +	 */
> +	disable_irq(sdata->client->irq);

It is safer to set:
    irq_set_status_flags(client->irq, IRQ_NOAUTOEN);
before devm_request_threaded_irq

Regards
Andrzej

