From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 1/3] Input: add STMicroelectronics FingerTip touchscreen
 driver
Date: Tue, 17 Jan 2017 11:32:49 -0300
Message-ID: <fb6ec656-ec3a-b0f3-4c39-56f0825eaf23@osg.samsung.com>
References: <20170117135441.31450-1-andi.shyti@samsung.com>
 <CGME20170117135456epcas5p2e303f0c5fa642b43fde543d5d6098dc2@epcas5p2.samsung.com>
 <20170117135441.31450-2-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117135441.31450-2-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hello Andi,

On 01/17/2017 10:54 AM, Andi Shyti wrote:
> Add binding for the STMicroelectronics FingerTip (stmfts)
> touchscreen driver.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---

The binding looks good to me, I've just a minor nit below.

[snip]

> +
> +i2c@00000000 {
> +
> +	/* ... */
> +
> +	stmfts@49 {

The ePAPR document says:

The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model.

So I think this should be touchscreen@49 instead.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
