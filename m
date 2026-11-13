Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537308;
	b=E5yAIECnWRqwu1wqUQDTq32MaJ5s4fKmK+vOy5bfRuvmFnSuoC1JYLLuF3umslLhSjiV
	 XvuAorUVe5Qr2L6pb9BGv95/kl9MsvP04TK8S0xm/A5m+QdVCAMhU9gHc9uItfVKh3Icc
	 AcoJIS9pC8oJT7TCwZctfBmtsmnwP3xYoKZVj3FaJNEUW9JBgXnrw99xnv5Ny5Ua23fTH
	 zwNJO66YjBTK2qUqON93iEC3YjwoNtm//LqLBuS0omw1SuULT+WgAd5CeWC4swffLB/FW
	 w/a13BBwDwjZY/gkVjo9pLgc3hWPmM2t5CSkBDwh5wRD/sdPj0BxwZ8Pjg+Mc79RM6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=lzA48Kwy9wvcOuubnJ5E+vvF+x65vAVE+Em3lMyzHzg=;
	b=Bar2bf96WFqZ6NCuE9qn5dUuNUtCpQvcShaluLsDbGza9crsb2HhQ223VXrzYJoxDohY
	 Fi85Kex9qEiMxcuiLs23vEMwVXqcxpDqbcGqXtzV4XvpuhLBQynLq6O3BKQbGOO0Mnniw
	 YBdFmbLz8JcM3dbsG3GTsoD5/JMD38xYXnvqp7HFukkRQIofy1TT981AgBGLKKui+wzZq
	 7XXm+wT/0ZAz8OsWWzjvWaccJQ7ocCDgbIPh5MXrTbZ9mDunvntUv3w0l6kMrmV+AuAjZ
	 ku/fIKsqHLrYqFDywwd+LYtXWJ8IZjcmHRnS6DrX6oZMH8X9H+y+pw4GjIsQAIfgKCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xPZp2319;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D89606A31C
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 02:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D89606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xPZp2319
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-37000e7234bso1094835eec.1
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 18:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794537306; x=1795142106; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lzA48Kwy9wvcOuubnJ5E+vvF+x65vAVE+Em3lMyzHzg=;
        b=xPZp2319Rw9tXuOel/mdPqFfhqqqe4Hqr/yAe/YbfxHrZ9KudEjQQyKu5HML/gTT2J
         N4EF7Gavxa11m4dCXGEqptXVCvQSWzZrHpG5B3hLKPidsJUXxuTlNetg/vmEorT6D7JW
         JW2xrywse7Sn8h1Oxfl/7G0e4pMb4h4y4Vx2R0vrtUb238JW9BWHl/8VIWxlbNgZaRhM
         zeMfAgn5wa1ozViF7wqg4hT9vm6lRMUUqV1Ft2sJcY2zR8KRy7LipW1lI+hqrFoPZDwq
         rCsMIibF/q3tPzS9rm4XMWsnh+hjtMG81afWCp1bdwF+w0v+l3B9PAiFiYsOBIcv5b1f
         h2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794537306; x=1795142106;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lzA48Kwy9wvcOuubnJ5E+vvF+x65vAVE+Em3lMyzHzg=;
        b=WSR0KXTmGx4GTcPn3lGPwp77RyojHNaA7b/uLG1UxujPD1bJTx2mTUawVml1rM02+k
         lpUoiY+k9ZtzX9vCu51Se+AjvXVNC6bOmUpz28LdNDxujclwPp1OADw3e8+b1UzOjZ1/
         qzAI7kFsQlP2YtNDb9zIU9M72pdmdyKeoA3UI/rezwtwBnDzdPLjSY8cuygUYkvLJ4XG
         gTGKIwn6AP+XuPgRbysenPYmgeaM30WyCv6A/d9AIenBE02d7PG+3wLv5PMTg4R6SiZF
         BzN2f0PXT0NreS/VQdJMtWWG8rVj4P7I5wnCnlRcLHCBldi2vjoUQDrtzCyU60QO6Zlc
         DwZg==
X-Forwarded-Encrypted: i=1; AL+hErEPKopuwObhBe7+JrldfGLBZe22RvHkMoKrBPXJiIgqtCuVenlIyJGZefS/RROn2tW1QqTNA0zvbffZ0g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9A0R7CM/jU+4mhNc5ilhrnSCrC6jraTbQuRhvGj+iTgmOKA3U5
	7OI6YNHvStINs3SuKE1pfBC3ceGTgXttZbzI+vbTZPE5Z9R1X9KxXlpP
X-Gm-Gg: AYBFou00qPizdO88jqc62b7+4HrqU71Ac/Sxbvg4w4FqOaS9+Trwr8wfdOeUOZyKOmM
	IZFMIMa0O4zQFNeuwpJ4uw0xyj3I9XMq+6fCyseDlpYfVxVU9HMVrXHVsmA2ZHnDcCuh3ubI1Iu
	OLLU1Jc62fgTdV/M/TZg5/ThhRgIo6/48f+tDl2d57yTRH/wnsd+SzcV8MlevBRPN5SKq/JUQYI
	mbNZ6jfYFYwDlgX4e7PQ2CYl/QnLqM+vsSTUNZ1rMfgepinKvuxvv2xQdLHzD8TSMm0e8Sv6/SC
	d+ht8sx/7trHVcY40+unvWZesxk3r58bd7dMNhl1Gm77IckNVd4y873LrnyMABaAwsEtToUY/Q+
	V9F/RGohnv++rQCamPTFhKq/UpmIiKbd9dnyfOdJ7fUATJxeFpWOcgc093w4mXzg2EAThkO/GhM
	7phzMixw7EIzAWCiXFBAxJWR7Np8md0YoM0QA4+AAnBLZRC0EmFPGxeZdf7z9r7Hn12GRV/stH/
	0/ikvu4JFZyurcZSFKEktih4zK7qWBEBkFgeOh1Oi5+Hj65IRGlJwe1jSeYFuEC9h1/v7NA44/C
	gKVgofG8uA91Y8vSH2lFt42e92HKgE6YUqhOkacv5fzaZsI0FSQ+rKe9m07vuKrQlTugug==
X-Received: by 2002:a05:7300:828e:b0:356:7ddb:2e54 with SMTP id 5a478bee46e88-37966a5ce93mr904136eec.29.1794537306101;
        Thu, 12 Nov 2026 18:35:06 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379559189e8sm2553568eec.11.2026.11.12.18.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:35:05 -0800 (PST)
Date: Thu, 12 Nov 2026 18:35:04 -0800
Message-ID: <ba73c504ce3b17e8b2197de7393484d9@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aelin Reidel <aelin@mainlining.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@mainlining.org,
	phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Piyush Raj Chouhan <pc1598@mainlining.org>,
	Alexander Koskovich <AKoskovich@pm.me>
Subject: Re: [PATCH v2 2/3] Input: add support for Goodix GTX8 Touchscreen ICs
In-Reply-To: <20260228-gtx8-v2-2-3a408c365f6c@mainlining.org>
References: <20260228-gtx8-v2-0-3a408c365f6c@mainlining.org> <20260228-gtx8-v2-2-3a408c365f6c@mainlining.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Aelin,

On Sat, Feb 28, 2026 at 02:56:11AM +0100, Aelin Reidel wrote:
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 7d5b72ee07fa1313da39a625b5129a0459720865..099ccd3679383dcf037bc7c6e6a3dbf0741722b4 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -429,6 +429,21 @@ config TOUCHSCREEN_GOODIX_BERLIN_SPI
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called goodix_berlin_spi.
>  
> +config TOUCHSCREEN_GOODIX_GTX8
> +	tristate "Goodix GTX8 touchscreen"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y here if you have a Goodix GTX8 IC connected to
> +	  your system via I2C. This driver supports Normandy and
> +	  Yellowstone ICs like the GT9886 and GT9896.
> +	  They are commonly found in mobile phones.
> +
> +	  if unsure, say N.

s/if/If/

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called goodix_gtx8.
> +
...
> diff --git a/drivers/input/touchscreen/goodix_gtx8.c b/drivers/input/touchscreen/goodix_gtx8.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..3fbebfa8b75672866788adf89d83be16e32abf81
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix_gtx8.c
> @@ -0,0 +1,563 @@
...
> +#include <linux/bitfield.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/unaligned.h>
> +
> +#include "goodix_gtx8.h"

Please include headers directly for all primitives and types used by the
driver (linux/bits.h, linux/delay.h, linux/device.h, linux/err.h,
linux/interrupt.h, linux/pm.h, linux/regulator/consumer.h,
linux/sizes.h, linux/types.h).

Also, since this is a single-module driver and SPI support does not
exist yet, please fold goodix_gtx8.h into goodix_gtx8.c. We can split it
out if and when a separate SPI transport module is added.

> +
> +static const struct regmap_config goodix_gtx8_regmap_conf = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.max_raw_read = I2C_MAX_TRANSFER_SIZE,
> +	.max_raw_write = I2C_MAX_TRANSFER_SIZE,
> +};
> +
> +/* vendor & product left unassigned here, should probably be updated from fw info */
> +static const struct input_id goodix_gtx8_input_id = {
> +	.bustype = BUS_I2C,
> +};

No need for a separate static struct for this, just assign
input_dev->id.bustype = BUS_I2C in goodix_gtx8_input_dev_config().

> +static int goodix_gtx8_get_remaining_contacts(struct goodix_gtx8_core *cd,
> +					      int n)
> +{
> +	size_t offset = cd->ic_data->header_size + GOODIX_GTX8_TOUCH_SIZE +
> +			GOODIX_GTX8_CHECKSUM_SIZE;
> +	u32 addr = cd->ic_data->touch_data_addr + offset;
> +	int error;
> +
> +	error = regmap_raw_read(cd->regmap, addr, &cd->event_buffer[offset],
> +				(n - 1) * GOODIX_GTX8_TOUCH_SIZE);

Please add a brief comment here (similar to goodix_berlin_core.c)
explaining why offset includes GOODIX_GTX8_CHECKSUM_SIZE while reading
(n - 1) * GOODIX_GTX8_TOUCH_SIZE bytes (i.e. that the initial read for
the first contact plus checksum already fetched the first 2 bytes of the
second contact).

> +	if (error) {
> +		dev_err_ratelimited(cd->dev, "failed to get touch data, %d\n",
> +				    error);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static void goodix_gtx8_report_state(struct goodix_gtx8_core *cd, u8 touch_num,
> +				     union goodix_gtx8_touch *touch_data)
> +{
> +	union goodix_gtx8_touch *t;
> +	int i;
> +	u8 finger_id;
> +
> +	for (i = 0; i < touch_num; i++) {
> +		t = &touch_data[i];
> +
> +		if (cd->ic_data->ic_type == IC_TYPE_NORMANDY) {
> +			input_mt_slot(cd->input_dev, t->normandy.finger_id);
> +			input_mt_report_slot_state(cd->input_dev,
> +						   MT_TOOL_FINGER, true);
> +
> +			touchscreen_report_pos(cd->input_dev, &cd->props,
> +					       __le16_to_cpu(t->normandy.x),
> +					       __le16_to_cpu(t->normandy.y),
> +					       true);
> +			input_report_abs(cd->input_dev, ABS_MT_TOUCH_MAJOR,
> +					 t->normandy.w);
> +		} else {
> +			finger_id = FIELD_GET(
> +				GOODIX_GTX8_FINGER_ID_MASK_YELLOWSTONE,
> +				t->yellowstone.finger_id);
> +			input_mt_slot(cd->input_dev, finger_id);
> +			input_mt_report_slot_state(cd->input_dev,
> +						   MT_TOOL_FINGER, true);
> +
> +			touchscreen_report_pos(cd->input_dev, &cd->props,
> +					       __be16_to_cpu(t->yellowstone.x),
> +					       __be16_to_cpu(t->yellowstone.y),
> +					       true);
> +			input_report_abs(cd->input_dev, ABS_MT_TOUCH_MAJOR,
> +					 t->yellowstone.w);
> +		}
> +	}

Several issues here:

1. finger_id is not checked against GOODIX_GTX8_MAX_TOUCH (10). On
   Yellowstone it is a 4-bit field (0..15), and on Normandy
   t->normandy.finger_id is an unmasked u8 (where only the lower 4 bits
   are the slot ID and upper bits carry event/tool flags such as BIT(7)
   for stylus). If finger_id >= GOODIX_GTX8_MAX_TOUCH, input_mt_slot()
   ignores the slot change and leaves the previously selected slot
   active, so the subsequent calls overwrite another contact's slot.
   Also, on Yellowstone the lower 4 bits encode the contact/tool type
   (like in goodix_berlin), so non-finger contacts should be skipped.

2. Please use le16_to_cpu() and be16_to_cpu() instead of the underscored
   __le16_to_cpu() and __be16_to_cpu() variants.

3. Please extract finger_id, x, y, and w in the if/else block and call
   input_mt_slot(), input_mt_report_slot_state(),
   touchscreen_report_pos(), and input_report_abs() once below it.

> +
> +	input_mt_sync_frame(cd->input_dev);
> +	input_sync(cd->input_dev);
> +}
> +
> +static void goodix_gtx8_touch_handler(struct goodix_gtx8_core *cd, u8 touch_num,
> +				      union goodix_gtx8_touch *touch_data)
> +{
> +	int error;
> +
> +	touch_num = FIELD_GET(GOODIX_GTX8_TOUCH_COUNT_MASK, touch_num);
> +
> +	if (touch_num > GOODIX_GTX8_MAX_TOUCH) {
> +		dev_warn(cd->dev, "invalid touch num %d\n", touch_num);
> +		return;
> +	}
> +
> +	if (touch_num > 1) {
> +		/* read additional contact data if more than 1 touch event */
> +		error = goodix_gtx8_get_remaining_contacts(cd, touch_num);
> +		if (error)
> +			return;
> +	}
> +
> +	if (touch_num) {
> +		/*
> +		 * Normandy checksum is for the entire read buffer,
> +		 * Yellowstone is only for the touch data (since header
> +		 * has a separate checksum)
> +		 */
> +		if (cd->ic_data->ic_type == IC_TYPE_NORMANDY) {
> +			int len = GOODIX_GTX8_HEADER_SIZE_NORMANDY +
> +				  touch_num * GOODIX_GTX8_TOUCH_SIZE +
> +				  GOODIX_GTX8_CHECKSUM_SIZE;
> +			if (!goodix_gtx8_checksum_valid_normandy(
> +				    cd->event_buffer, len)) {
> +				dev_err(cd->dev,
> +					"touch data checksum error: %*ph\n",
> +					len, cd->event_buffer);
> +				return;
> +			}
> +		} else {
> +			int len = touch_num * GOODIX_GTX8_TOUCH_SIZE +
> +				  GOODIX_GTX8_CHECKSUM_SIZE;
> +			if (!goodix_gtx8_checksum_valid_yellowstone(
> +				    (u8 *)touch_data, len)) {
> +				dev_err(cd->dev,
> +					"touch data checksum error: %*ph\n",
> +					len, (u8 *)touch_data);
> +				return;
> +			}
> +		}
> +	}

Please use dev_warn_ratelimited() / dev_err_ratelimited() in the IRQ
path so a noisy bus or misbehaving firmware does not flood the logs.

> +static irqreturn_t goodix_gtx8_irq(int irq, void *data)
> +{
...
> +	error = regmap_raw_read(
> +		cd->regmap, cd->ic_data->touch_data_addr, cd->event_buffer,
> +		cd->ic_data->header_size + GOODIX_GTX8_TOUCH_SIZE +
> +			GOODIX_GTX8_CHECKSUM_SIZE);
> +	if (error) {
> +		dev_warn_ratelimited(
> +			cd->dev, "failed to get event head data: %d\n", error);
> +		goto out;
> +	}
...
> +	if (status == 0)
> +		goto out;
...
> +out_clear:
> +	/* Clear up status field */
> +	regmap_write(cd->regmap, cd->ic_data->touch_data_addr, 0);
> +
> +out:
> +	return IRQ_HANDLED;
> +}

If the initial read fails or status == 0, returning IRQ_HANDLED on a
level-low interrupt prevents the kernel from detecting a stuck interrupt
line. Those paths should return IRQ_NONE.

> +static int goodix_gtx8_dev_confirm(struct goodix_gtx8_core *cd)
> +{
> +	u8 rx_buf[1];
> +	int retry = 3;
> +	int error;
> +
> +	while (retry--) {
> +		/*
> +		 * test_addr appears to always be the touch_data_addr for
> +		 * Normandy, but it doesn't really matter since all we
> +		 * need is a valid address
> +		 */
> +		error = regmap_raw_read(cd->regmap,
> +					cd->ic_data->touch_data_addr, rx_buf,
> +					sizeof(rx_buf));
> +
> +		if (!error)
> +			return 0;
> +
> +		usleep_range(5000, 5100);
> +	}
> +
> +	dev_err(cd->dev, "device confirm failed\n");
> +
> +	return -EINVAL;
> +}

Please return 'error' (and log it) instead of replacing it with -EINVAL.

> +static int goodix_gtx8_suspend(struct device *dev)
> +{
> +	struct goodix_gtx8_core *cd = dev_get_drvdata(dev);
> +
> +	disable_irq(cd->irq);
> +	goodix_gtx8_power_off(cd);
> +
> +	return 0;
> +}
> +
> +static int goodix_gtx8_resume(struct device *dev)
> +{
> +	struct goodix_gtx8_core *cd = dev_get_drvdata(dev);
> +	int error;
> +
> +	error = goodix_gtx8_power_on(cd);
> +	if (error)
> +		return error;
> +
> +	enable_irq(cd->irq);
> +
> +	return 0;
> +}
> +
> +EXPORT_GPL_SIMPLE_DEV_PM_OPS(goodix_gtx8_pm_ops, goodix_gtx8_suspend,
> +			     goodix_gtx8_resume);

1. Use static DEFINE_SIMPLE_DEV_PM_OPS() instead of exporting
   goodix_gtx8_pm_ops when there are no external callers.

2. If goodix_gtx8_power_on() fails in goodix_gtx8_resume(), it leaves
   both regulators disabled and cd->irq disabled. A subsequent driver
   unbind (via goodix_gtx8_power_off_act) or the next suspend cycle will
   call goodix_gtx8_power_off() again on already-disabled regulators
   (triggering a regulator underflow WARN) and disable the IRQ a second
   time.

   Better yet, please wire up input_dev->open and input_dev->close:
   power the chip on in probe() only long enough to read the version,
   then power it off, request the IRQ with IRQF_ONESHOT | IRQF_NO_AUTOEN,
   power on + enable_irq() in open(), and disable_irq() + power off in
   close(). Then suspend() and resume() can take &cd->input_dev->mutex
   and only power down/up when input_device_enabled(cd->input_dev) is
   true, which also avoids keeping the controller powered when nothing
   uses the input device.

> +static int goodix_gtx8_probe(struct i2c_client *client)
> +{
...
> +	cd->dev = &client->dev;
> +	cd->irq = client->irq;
> +	cd->regmap = regmap;
> +	cd->ic_data = i2c_get_match_data(client);
> +
> +	cd->event_buffer =
> +		devm_kzalloc(cd->dev, cd->ic_data->event_size, GFP_KERNEL);
> +	if (!cd->event_buffer)
> +		return -ENOMEM;

Please check if (!cd->ic_data) before dereferencing it.

Also, instead of a separate devm_kzalloc() for cd->event_buffer and
casting it across the driver, you can embed a union of
goodix_gtx8_event_normandy and goodix_gtx8_event_yellowstone directly in
struct goodix_gtx8_core (like goodix_berlin_core.c does).

> +	error = goodix_gtx8_power_on(cd);
> +	if (error) {
> +		dev_err(cd->dev, "failed power on");
> +		return error;
> +	}
> +
> +	error = devm_add_action_or_reset(cd->dev, goodix_gtx8_power_off_act,
> +					 cd);
> +	if (error)
> +		return error;
> +
> +	error = goodix_gtx8_read_version(cd);
> +	if (error) {
> +		dev_err(cd->dev, "failed to get version info");
> +		return error;
> +	}
> +
> +	error = goodix_gtx8_input_dev_config(cd);
> +	if (error) {
> +		dev_err(cd->dev, "failed to set input device");
> +		return error;
> +	}
> +
> +	error = devm_request_threaded_irq(cd->dev, cd->irq, NULL,
> +					  goodix_gtx8_irq, IRQF_ONESHOT,
> +					  "goodix-gtx8", cd);
> +	if (error) {
> +		dev_err(cd->dev, "request threaded IRQ failed: %d\n", error);
> +		return error;
> +	}
> +
> +	dev_set_drvdata(cd->dev, cd);

The three dev_err() messages above are missing trailing '\n' (and
goodix_gtx8_power_on() / goodix_gtx8_read_version() already log their
own errors).

Also, please set drvdata and request the IRQ before registering the
input device in goodix_gtx8_input_dev_config().

> +static const struct i2c_device_id goodix_gtx8_i2c_id[] = {
> +	{ .name = "gt9886", .driver_data = (long)&gt9886_data },
> +	{ .name = "gt9896", .driver_data = (long)&gt9896_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, goodix_gtx8_i2c_id);
> +
> +static const struct of_device_id goodix_gtx8_of_match[] = {
> +	{ .compatible = "goodix,gt9886", .data = &gt9886_data },
> +	{ .compatible = "goodix,gt9896", .data = &gt9896_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, goodix_gtx8_of_match);
> +
> +static struct i2c_driver goodix_gtx8_driver = {
> +	.probe = goodix_gtx8_probe,
> +	.id_table = goodix_gtx8_i2c_id,
> +	.driver = {
> +		.name = "goodix-gtx8",
> +		.of_match_table = of_match_ptr(goodix_gtx8_of_match),
> +		.pm = pm_sleep_ptr(&goodix_gtx8_pm_ops),
> +	},
> +};

Use (kernel_ulong_t) for .driver_data in goodix_gtx8_i2c_id, and drop
of_match_ptr() so goodix_gtx8_of_match does not trigger an unused
variable warning when CONFIG_OF is disabled.

> diff --git a/drivers/input/touchscreen/goodix_gtx8.h b/drivers/input/touchscreen/goodix_gtx8.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..9b13cfce38720b35bb11f0d7f56d671b31664ade
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix_gtx8.h
...
> +#define I2C_MAX_TRANSFER_SIZE			256

Please prefix this with GOODIX_GTX8_ so it does not collide with the I2C
subsystem namespace.

> +struct goodix_gtx8_header_yellowstone {
> +	u8 status;
> +	/* Most likely unused */
> +	u8 __unknown1;
> +	/* Only the lower 4 bits are actually used */
> +	u8 touch_num;
> +	/* Most likely unused */
> +	u8 __unknown2[3];
> +	__le16 checksum;
> +} __packed __aligned(1);

Yellowstone checksum is big-endian (read via get_unaligned_be16() in
goodix_gtx8_checksum_valid_yellowstone()), so this field should be
__be16. Also, __aligned(1) is redundant alongside __packed (here and on
the touch structs below), and the "The data below is u16 aligned"
comments on the event structs are inaccurate for Normandy where x and y
sit at odd byte offsets.

Thanks.

-- 
Dmitry
