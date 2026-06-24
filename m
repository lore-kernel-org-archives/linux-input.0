Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D334753B
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 04:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274477; cv=none; b=RxldEOKqFf3yGPtQexrNRwBcFmDnruk9TbbQmp6i0YEqijxIR82fEBojcZP6CUMD+HWENuDBnlvRb3VrtV6qpejzqquQxPOMLac59dftmnJT0E4WUdsMpz1Et1t+8o6SUMHrh3iQfgc1uYmK28MVDN5tH2oCOqPu6ZuuG/TWJcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274477; c=relaxed/simple;
	bh=F64ZVJVMK5lCsBFog81Qx1aMpxm/GHjOMlsLOnzQQqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPLgOE1E+OGAKDWZjYk5XGGVPlxyAkqsi9jYkjIRKgX+4POERvAKuvlMmjWSE762uTF437icGvLvYzp0GarqSCEWSNosjgAbH6T9vxr8OCpqpjlSV4VZzNYX1b7NNh3nws1CErb6NnSxJDd2AegJJongip1AaGlnDy10hPpWDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOJsNLtu; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOJsNLtu"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-139986373b8so794638c88.0
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782274476; x=1782879276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vKtWlzZGcSqpr4oYtvBHGz8mTHnWwBOUsRR1pMRsq7A=;
        b=VOJsNLtubLiIPLIseXckT4SbZcCwJDwxC8TCOtv5KVcTPzwz/LLjFKEa5kUEB3CzCa
         5+AK24KW+lJ95Ch4lF2Gm82842IKu9P40XGOv7t5gsZcm9E4OI/pkgvrzThlO/OpuzLF
         zOFz8Tdmb05Idg6EOEBt2Z7HILo7h9g55qnYe/WifeJYOmSHeLo70VulrB9Y97L48FE/
         SVcN5Whp4dxNdQxXxbg9dDtEnnyLgUl3/dZLEKkbtqa9VJShuXoRpTsruNXYlHmUy36L
         BrOszkiPj9IFshUszebcD/b1HW6p5zWyzFRcUUqqpun6E+xS+SJZlVrUAI382k0tosi6
         Tz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782274476; x=1782879276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKtWlzZGcSqpr4oYtvBHGz8mTHnWwBOUsRR1pMRsq7A=;
        b=FCnFHvcWhJeyYu1V653h8P2B7NPzRPzeqqz7BRf1ph6mrl1d/zMu+3WKnR8hGAkCgB
         zRg7SoRqmCO6dS+qDHXg6H5y42WcGEvoNn1eXO/oZsSfxd8gckYADYOvjPjTYl0pywBm
         gzo3Af/CoqQFAcyhgN59M75jVsKu+1n2Hw/07AHfQ6QHQssFoyEW2vZwcnEC6Z4voOn3
         idF1dEZ1dGcbqJbhTAzrQgUB9HbQjX8mPZ5QzgoVcmnCv6nPhuILbwvRUQ681clCQIiA
         bkU+ibkuv45Fbul3obdktuTYNEspd5oxhrymUwACdnJbEuoAf6uYAZDPZMKttM8UJvcV
         R3sQ==
X-Gm-Message-State: AOJu0YzlZDMsYIkZVWu18SkDnZcUzs+4WkSq7Yij/B7iAxlc7FbpKzJ1
	q/Yl7v+FWZ/oPKAGEAl9brz4LIRqANMK4EnnTOYcV/tlIllBXo8IAgUJ
X-Gm-Gg: AfdE7ckxW28z6XdwHw4Ga6Q96OJOhK4noRlG4F5lwkrWDn28l9t9E9blVpXmiZPOen8
	Nn+ybbgc6ADnWIlbjXy7JR9UU10J1JaKZK2xDgohvrnaFXI0Banv7AokKWVc69p2ZTGo7mESzAL
	NfEfFJvD9gyd+yoGqM0S1BWMNh4dxJnzFSg3X0TpOgeLAvVOQEhJBtfIN0OBqe7J9MotPfevw6o
	IRTGWLRATXNMUmGXt1w6HxUUTex7qJssLWe3kqf/mysF65TaCiE9ttoHL+O1zlctR7aWiVWZYBU
	WnSp/lenCiNPXAkYYKo03TS9T1dVwlcz4MqPYiJj7Jv89uYvux3Rxl8FyugHSE6tnHga6dEFUv5
	Ruzz0w+Hc+dBTBeYeYGFX591KQsRNGfGaBEL9CJLcMQQFGCKrWHTlmdbhOn82xiVez42WQptb9V
	4PQlGET+9K3LrEBjFUXKJ1cxHT7hI862Y4GVNaXZXCv1cnW0poFRPQWw==
X-Received: by 2002:a05:7022:128f:b0:138:5049:cb7c with SMTP id a92af1059eb24-139d0cd9467mr1322277c88.36.1782274475590;
        Tue, 23 Jun 2026 21:14:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6026:1e6d:4a80:9bd0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bd8d6edsm20547205eec.14.2026.06.23.21.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 21:14:34 -0700 (PDT)
Date: Tue, 23 Jun 2026 21:14:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] Input: mtk-pmic-keys: Count available keys during probe
 instead of pre-counting
Message-ID: <ajtX-cVWFmmkVO7M@google.com>
References: <20260528235600.312045-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528235600.312045-1-rosenp@gmail.com>

Hi Rosen,

On Thu, May 28, 2026 at 04:56:00PM -0700, Rosen Penev wrote:
> Replace the separate of_get_available_child_count() pre-count and
> validation step with a single pass through for_each_child_of_node_scoped().
> Skip unavailable child nodes and bail out if more than
> MTK_PMIC_MAX_KEY_COUNT available keys are found. Set nkeys after the
> loop so suspend/resume iterate only over initialized entries.
> 
> Also use a key variable in the loop for clarity.
> 
> Use of_device_get_match_data() to fetch the PMIC key register data directly
> instead of open-coding an of_match_device() lookup.

Please split this out into a separate patch.

> 
> This also lets the driver drop the of_device.h include.
> 
> Assisted-by: OpenCode:BigPickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 53 ++++++++++++--------------
>  1 file changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index c78d9f6d97c4..e34856693ee2 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -16,7 +16,6 @@
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6397/registers.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -147,6 +146,7 @@ struct mtk_pmic_keys {
>  	struct input_dev *input_dev;
>  	struct device *dev;
>  	struct regmap *regmap;
> +	unsigned int nkeys;
>  	struct mtk_pmic_keys_info keys[MTK_PMIC_MAX_KEY_COUNT];
>  };
>  
> @@ -267,7 +267,7 @@ static int mtk_pmic_keys_suspend(struct device *dev)
>  	struct mtk_pmic_keys *keys = dev_get_drvdata(dev);
>  	int index;
>  
> -	for (index = 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
> +	for (index = 0; index < keys->nkeys; index++) {
>  		if (keys->keys[index].wakeup) {
>  			enable_irq_wake(keys->keys[index].irq);
>  			if (keys->keys[index].irq_r > 0)
> @@ -283,7 +283,7 @@ static int mtk_pmic_keys_resume(struct device *dev)
>  	struct mtk_pmic_keys *keys = dev_get_drvdata(dev);
>  	int index;
>  
> -	for (index = 0; index < MTK_PMIC_MAX_KEY_COUNT; index++) {
> +	for (index = 0; index < keys->nkeys; index++) {
>  		if (keys->keys[index].wakeup) {
>  			disable_irq_wake(keys->keys[index].irq);
>  			if (keys->keys[index].irq_r > 0)
> @@ -325,24 +325,23 @@ MODULE_DEVICE_TABLE(of, of_mtk_pmic_keys_match_tbl);
>  static int mtk_pmic_keys_probe(struct platform_device *pdev)
>  {
>  	int error, index = 0;
> -	unsigned int keycount;
>  	struct mt6397_chip *pmic_chip = dev_get_drvdata(pdev->dev.parent);
>  	struct device_node *node = pdev->dev.of_node;
>  	static const char *const irqnames[] = { "powerkey", "homekey" };
>  	static const char *const irqnames_r[] = { "powerkey_r", "homekey_r" };
>  	struct mtk_pmic_keys *keys;
>  	const struct mtk_pmic_regs *mtk_pmic_regs;
> +	struct mtk_pmic_keys_info *key;
>  	struct input_dev *input_dev;
> -	const struct of_device_id *of_id =
> -		of_match_device(of_mtk_pmic_keys_match_tbl, &pdev->dev);
>  
>  	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
>  	if (!keys)
>  		return -ENOMEM;
> -
>  	keys->dev = &pdev->dev;
>  	keys->regmap = pmic_chip->regmap;
> -	mtk_pmic_regs = of_id->data;
> +	mtk_pmic_regs = of_device_get_match_data(&pdev->dev);
> +	if (!mtk_pmic_regs)
> +		return -EINVAL;
>  
>  	keys->input_dev = input_dev = devm_input_allocate_device(keys->dev);
>  	if (!input_dev) {
> @@ -356,31 +355,26 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
>  	input_dev->id.product = 0x0001;
>  	input_dev->id.version = 0x0001;
>  
> -	keycount = of_get_available_child_count(node);
> -	if (keycount > MTK_PMIC_MAX_KEY_COUNT ||
> -	    keycount > ARRAY_SIZE(irqnames)) {
> -		dev_err(keys->dev, "too many keys defined (%d)\n", keycount);
> -		return -EINVAL;
> -	}
> +	for_each_available_child_of_node_scoped(node, child) {

Let's keep using for_each_child_of_node_scoped() and check
of_device_is_available() inside the loop. This will allow marking a key
as disabled without shifting it's meaning (power key vs home key).

In the rest of the driver we should be able to determine if key is set
up checking for key->irq > 0.

Thanks.

-- 
Dmitry
