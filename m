Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8823451BB
	for <linux-input@vger.kernel.org>; Fri,  8 May 2026 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220715; cv=none; b=daFlsHVQEWCuE8C0uaU0YzPk3FJKbL2PZTu9eKu651AgmNY+3eFHQc3EbmPPkUstBRhqAUsmNOr+xh76ZRgjg0AjfX4ZcaWdJX9MNbiyi9DdPLJOaOd4JEPwdJE9fbNZD7WLW+QDauYNHPsgQFB2CBx/SlaggziQ5vA6dq5buJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220715; c=relaxed/simple;
	bh=UOMQRXoAVwk70uaufZhCWFNt7EA3VOTwF7G0ARoU3VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXwPGuN5u4+DiotBA+J8tzlNpTfIqacwGDC69Q3MlZwYDHQiQGtkZroH1wvvhXpNSVdUB1eG4RhmMWOhrIsPhtLDVytObzfSF+BAdH1vLJPUoHAIAFTdVG1KQWwwjz+mjChZC7EoxdOYXwu5iyuTGVNLSiKzh0MTHkPYCKH+bgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=af9Aq9W0; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af9Aq9W0"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c15849aa2cso2113584eec.0
        for <linux-input@vger.kernel.org>; Thu, 07 May 2026 23:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778220704; x=1778825504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXb0SR/K0dwEQwnGYT+FJTHi8ls55dvpbTwOnKCIOSw=;
        b=af9Aq9W0YoPBm3194Lof4H08dGP+IF1d0al6sFdkh25soZ66jiCO1V56mxofiQLRJ1
         eS29CYpT7QFelcSRA652MmQA4IzaC9kXNqM7iiKrvPPacrX3MP+ZwdlSIUs6VOVpYi9B
         d98xZfJPhigLxZYybmnXEW6phB0VJUA13jsXMmLZekAV94oI0DCV46Zv0NkpTMH4MtQQ
         NyvdNSRG/TOyc1wlWiwT9tQG8ytP7EqafxbQKQP6zBffcx5QnC9qk/41pQDKKW4PAt7u
         gh9jzhkmp3sDLj24NDARc8itE86iV1UMnvsDT3U4YP1rfnsFzrsSxRCvfuSbE4lpjxHU
         HU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778220704; x=1778825504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXb0SR/K0dwEQwnGYT+FJTHi8ls55dvpbTwOnKCIOSw=;
        b=LwQ4J3DiR4XfwXzJwOBuf+iYiXJ847Eiit5eR6R5MVUagoKHGfB3pnSEHlijwn/S6G
         U9qi2NxfwecNkRTNk50tqZkDSOJdviImaBz+K8gSvnLj+C8neRNAnSp+NgIttvXYNrlC
         UQykzFzxJmgXfcpAJqkCj8hSlSY/TvmGuWY1DlVPWrmiwImlK6zfPFKsCs6CAQaTPWC6
         XHaCAPG+N9e2VPWf8nr79cZwC5pFY/DfYkXlndy+7UifqSdsEX3EpVwyNY+K89N9pU3G
         hOxqEKlDViKYawKQCyxFewSfKehQGu6xNTS1CVQd/6hblQzWGI29iZ5tpjcNFIsI2ESp
         hBiQ==
X-Forwarded-Encrypted: i=1; AFNElJ93Sh0AJDmpPFj8RMcr+zSbs2YbUsvR7cNkkrodeSlQV8xQ1h1qjuE7SPjqVSFIIl4fN769i76bbNxY1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBDJIYIZVYtFFkDISwl6H9ryrVh7W00Pgvnv/hnwlqFjicrMqe
	Tg8BAVP1JPd9Bcfnh2bt/TfBXqYBoDpySsUDFU1DbnDMNIUwaC2uR30m
X-Gm-Gg: Acq92OH1o7d4S9xxGCCYm57drr9hQdzTU8eTK7OZuYCBIeQwq5kBjiGMh/7WOGlhzYq
	M1lI3zI2pX72ozL8+Mx96HQWrI+SEu1xyc3z3S7Jw3W0Sw49Jc6e5q0/qjQ++0xgpFvllXnm/4y
	QciqoCVqkUDeUbGAb26lruhmgZspg4BsB+CBjnumpkdIi+X1aPuDywd4svx+6zbCcaH+7qoCAEC
	9wNDOPXuzFygsFmHtXjb7mZofr7ZsUJXDg+ypIGhVo3b7QWfg/VtsZZKsJKK6PsZYPenbYGQYom
	ovh0nWLFDX44awUrkr3FhU5r7+uFRdVUcS09S//rHHQcEK6WPOesnJEAWaJl1dI+wbTUkQwu3hR
	QizthQr9+rDsU+F0qEG1KWuZ0kLCWOgLy4PN6yfA34c8h0KVI+QZx2/Hc0WrBPBZezedVVzPxL6
	5UBJpvyBkXKZM3aTHDC5vepTSJEJGOWerlfqAgzdmFivvfrZcEQDkezkdYrPsvtUu6W2YAyyuVI
	9I=
X-Received: by 2002:a05:693c:2b08:b0:2ea:cd38:f921 with SMTP id 5a478bee46e88-2f54aa78245mr5844784eec.26.1778220703475;
        Thu, 07 May 2026 23:11:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:852e:ebf3:8de1:32e1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e3e285sm1132502eec.27.2026.05.07.23.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:11:42 -0700 (PDT)
Date: Thu, 7 May 2026 23:11:39 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Petr Hodina <petr.hodina@protonmail.com>, 
	linux-input@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 10/11] Input: stmfts - support FTS5
Message-ID: <af13d0-zM8Qjtjcj@google.com>
References: <20260409-stmfts5-v4-0-64fe62027db5@ixit.cz>
 <20260409-stmfts5-v4-10-64fe62027db5@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-stmfts5-v4-10-64fe62027db5@ixit.cz>

Hi David,

On Thu, Apr 09, 2026 at 12:15:53AM +0200, David Heidelberg via B4 Relay wrote:
> @@ -101,12 +129,27 @@ struct stmfts_data {
>  
>  	struct completion cmd_done;
>  
> +	unsigned long touch_id;
> +	unsigned long stylus_id;

I wonder why do you track contacts yourself instead of telling input
core to do it for you and report BTN_TOUCH as needed? You just need to
call input_mt_sync_frame() when you are done processing input frame.

Does the device send all contacts state in one transmission or it can
transmit contacts one by one?

> +
> +	/* Boundary check - some devices report max value, adjust */
> +	if (x >= sdata->prop.max_x)
> +		x = sdata->prop.max_x - 1;
> +	if (y >= sdata->prop.max_y)
> +		y = sdata->prop.max_y - 1;

It is allowed to exceed declared min and max, so this clampin is not
needed.

>  
> +static int stmfts5_set_scan_mode(struct stmfts_data *sdata, const u8 val)
> +{
> +	int err;
> +
> +	u8 scan_mode_cmd[3] = { STMFTS5_SET_SCAN_MODE, 0x00, val };
> +	struct i2c_msg msg = {
> +		.addr = sdata->client->addr,
> +		.len = sizeof(scan_mode_cmd),
> +		.buf = scan_mode_cmd,
> +	};
> +
> +	err = i2c_transfer(sdata->client->adapter, &msg, 1);

Is this i2c_master_send()?

> +	if (err != 1)
> +		return err < 0 ? err : -EIO;
> +
> +	return 0;
> +
> +}
> +
>  static int stmfts_input_open(struct input_dev *dev)
>  {
>  	struct stmfts_data *sdata = input_get_drvdata(dev);
> @@ -371,6 +622,28 @@ static int stmfts_input_open(struct input_dev *dev)
>  	return 0;
>  }
>  
> +static int stmfts5_input_open(struct input_dev *dev)
> +{
> +	struct stmfts_data *sdata = input_get_drvdata(dev);
> +	int err;
> +
> +	err = pm_runtime_resume_and_get(&sdata->client->dev);
> +	if (err)
> +		return err;
> +
> +	mutex_lock(&sdata->mutex);
> +	sdata->running = true;
> +	mutex_unlock(&sdata->mutex);

	scoped_guard(mutex, &sdata->mutex)
		sdata->running;

> +
> +	err = stmfts5_set_scan_mode(sdata, 0xff);
> +	if (err) {
> +		pm_runtime_put_sync(&sdata->client->dev);

Reset "running"?

> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static void stmfts_input_close(struct input_dev *dev)
>  {
>  	struct stmfts_data *sdata = input_get_drvdata(dev);
> @@ -404,6 +677,23 @@ static void stmfts_input_close(struct input_dev *dev)
>  	pm_runtime_put_sync(&sdata->client->dev);
>  }
>  
> +static void stmfts5_input_close(struct input_dev *dev)
> +{
> +	struct stmfts_data *sdata = input_get_drvdata(dev);
> +	int err;
> +
> +	err = stmfts5_set_scan_mode(sdata, 0x00);
> +	if (err)
> +		dev_warn(&sdata->client->dev,
> +			 "failed to disable touchscreen: %d\n", err);
> +
> +	mutex_lock(&sdata->mutex);
> +	sdata->running = false;
> +	mutex_unlock(&sdata->mutex);

scoped_guard()

> +
> +	pm_runtime_put_sync(&sdata->client->dev);
> +}
> +
>  static ssize_t stmfts_sysfs_chip_id(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -484,10 +774,8 @@ static ssize_t stmfts_sysfs_hover_enable_write(struct device *dev,
>  	guard(mutex)(&sdata->mutex);
>  
>  	if (hover != sdata->hover_enabled) {
> -		if (sdata->running) {
> -			err = i2c_smbus_write_byte(sdata->client,
> -					   value ? STMFTS_SS_HOVER_SENSE_ON :
> -						   STMFTS_SS_HOVER_SENSE_OFF);
> +		if (sdata->running && sdata->ops->set_hover) {
> +			err = sdata->ops->set_hover(sdata, hover);
>  			if (err)
>  				return err;
>  		}
> @@ -612,7 +900,7 @@ static int stmfts_power_on(struct stmfts_data *sdata)
>  	if (sdata->reset_gpio)
>  		stmfts_reset(sdata);
>  
> -	err = stmfts_configure(sdata);
> +	err = sdata->ops->configure(sdata);
>  	if (err)
>  		regulator_bulk_disable(ARRAY_SIZE(stmfts_supplies),
>  				       sdata->supplies);
> @@ -620,6 +908,29 @@ static int stmfts_power_on(struct stmfts_data *sdata)
>  	return err;
>  }
>  
> +static int stmfts5_configure(struct stmfts_data *sdata)
> +{
> +	u8 event[STMFTS_EVENT_SIZE];
> +	int ret;
> +
> +	/* Verify I2C communication */
> +	ret = i2c_smbus_read_i2c_block_data(sdata->client,
> +					    STMFTS_READ_ALL_EVENT,
> +					    sizeof(event), event);
> +	if (ret < 0)
> +		return ret;
> +
> +	enable_irq(sdata->client->irq);
> +
> +	return 0;
> +}
> +
> +static void stmfts5_chip_power_off(struct stmfts_data *sdata)
> +{
> +	i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);
> +	msleep(20);
> +}
> +
>  static void stmfts_power_off(void *data)
>  {
>  	struct stmfts_data *sdata = data;
> @@ -629,10 +940,73 @@ static void stmfts_power_off(void *data)
>  	if (sdata->reset_gpio)
>  		gpiod_set_value_cansleep(sdata->reset_gpio, 1);
>  
> +	if (sdata->ops->power_off)
> +		sdata->ops->power_off(sdata);
> +
>  	regulator_bulk_disable(ARRAY_SIZE(stmfts_supplies),
>  			       sdata->supplies);
>  }
>  
> +static int stmfts_setup_input(struct stmfts_data *sdata)
> +{
> +	struct device *dev = &sdata->client->dev;
> +
> +	input_set_abs_params(sdata->input, ABS_MT_ORIENTATION, 0, 255, 0, 0);
> +	input_set_abs_params(sdata->input, ABS_DISTANCE, 0, 255, 0, 0);
> +
> +	sdata->use_key = device_property_read_bool(dev, "touch-key-connected");
> +	if (sdata->use_key) {
> +		input_set_capability(sdata->input, EV_KEY, KEY_MENU);
> +		input_set_capability(sdata->input, EV_KEY, KEY_BACK);
> +	}
> +
> +	return input_mt_init_slots(sdata->input, STMFTS_MAX_FINGERS,
> +				   INPUT_MT_DIRECT);
> +}
> +
> +static int stmfts5_setup_input(struct stmfts_data *sdata)
> +{
> +	struct device *dev = &sdata->client->dev;
> +
> +	sdata->mode_switch_gpio = devm_gpiod_get_optional(dev, "mode-switch",
> +							  GPIOD_OUT_HIGH);
> +	if (IS_ERR(sdata->mode_switch_gpio))
> +		return dev_err_probe(dev, PTR_ERR(sdata->mode_switch_gpio),
> +				     "Failed to get GPIO 'switch'\n");
> +
> +	/* Mark as direct input device for calibration support */
> +	__set_bit(INPUT_PROP_DIRECT, sdata->input->propbit);
> +
> +	/* Set up basic touch capabilities */
> +	input_set_capability(sdata->input, EV_KEY, BTN_TOUCH);

This will be done by input_mt_init_slots(..., INPUT_MT_DIRECT). 

> +
> +	/* Set resolution for accurate calibration */
> +	if (!input_abs_get_res(sdata->input, ABS_MT_POSITION_X)) {
> +		input_abs_set_res(sdata->input, ABS_MT_POSITION_X, 10);
> +		input_abs_set_res(sdata->input, ABS_MT_POSITION_Y, 10);
> +	}
> +
> +	input_set_abs_params(sdata->input, ABS_MT_DISTANCE, 0, 255, 0, 0);
> +
> +	/* Enable stylus support if requested */
> +	sdata->stylus_enabled = device_property_read_bool(dev, "stylus-enabled");
> +
> +	/* Initialize touch tracking bitmaps */
> +	sdata->touch_id = 0;
> +	sdata->stylus_id = 0;
> +
> +	/* Initialize MT slots with support for pen tool type */
> +	return input_mt_init_slots(sdata->input, STMFTS_MAX_FINGERS,
> +				   INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);

Why INPUT_MT_DROP_UNUSED?

> +}
> +
> +static int stmfts_set_hover(struct stmfts_data *sdata, bool enable)
> +{
> +	return i2c_smbus_write_byte(sdata->client,
> +				    enable ? STMFTS_SS_HOVER_SENSE_ON :
> +					     STMFTS_SS_HOVER_SENSE_OFF);
> +}
> +
>  static int stmfts_enable_led(struct stmfts_data *sdata)
>  {
>  	int err;
> @@ -678,6 +1052,8 @@ static int stmfts_probe(struct i2c_client *client)
>  	mutex_init(&sdata->mutex);
>  	init_completion(&sdata->cmd_done);
>  
> +	sdata->ops = of_device_get_match_data(dev);
> +
>  	err = devm_regulator_bulk_get_const(dev,
>  					    ARRAY_SIZE(stmfts_supplies),
>  					    stmfts_supplies,
> @@ -697,8 +1073,8 @@ static int stmfts_probe(struct i2c_client *client)
>  
>  	sdata->input->name = STMFTS_DEV_NAME;
>  	sdata->input->id.bustype = BUS_I2C;
> -	sdata->input->open = stmfts_input_open;
> -	sdata->input->close = stmfts_input_close;
> +	sdata->input->open = sdata->ops->input_open;
> +	sdata->input->close = sdata->ops->input_close;
>  
>  	input_set_capability(sdata->input, EV_ABS, ABS_MT_POSITION_X);
>  	input_set_capability(sdata->input, EV_ABS, ABS_MT_POSITION_Y);
> @@ -706,19 +1082,9 @@ static int stmfts_probe(struct i2c_client *client)
>  
>  	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
>  	input_set_abs_params(sdata->input, ABS_MT_TOUCH_MINOR, 0, 255, 0, 0);
> -	input_set_abs_params(sdata->input, ABS_MT_ORIENTATION, 0, 255, 0, 0);
>  	input_set_abs_params(sdata->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
> -	input_set_abs_params(sdata->input, ABS_DISTANCE, 0, 255, 0, 0);
> -
> -	sdata->use_key = device_property_read_bool(dev,
> -						   "touch-key-connected");
> -	if (sdata->use_key) {
> -		input_set_capability(sdata->input, EV_KEY, KEY_MENU);
> -		input_set_capability(sdata->input, EV_KEY, KEY_BACK);
> -	}
>  
> -	err = input_mt_init_slots(sdata->input,
> -				  STMFTS_MAX_FINGERS, INPUT_MT_DIRECT);
> +	err = sdata->ops->setup_input(sdata);
>  	if (err)
>  		return err;
>  
> @@ -789,13 +1155,62 @@ static int stmfts_runtime_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int stmfts_runtime_resume(struct device *dev)
> +static int stmfts_chip_runtime_resume(struct stmfts_data *sdata)
> +{
> +	return i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_OUT);
> +}
> +
> +static int stmfts5_chip_runtime_resume(struct stmfts_data *sdata)
>  {
> -	struct stmfts_data *sdata = dev_get_drvdata(dev);
>  	struct i2c_client *client = sdata->client;
> +	struct device *dev = &client->dev;
> +	u8 int_enable_cmd[4] = {0xB6, 0x00, 0x2C, 0x01};
> +	struct i2c_msg msg = {
> +		.addr = client->addr,
> +		.len = sizeof(int_enable_cmd),
> +		.buf = int_enable_cmd,
> +	};
>  	int ret;

"int err" everywhere where the variable carries error code or 0.


Thanks.

-- 
Dmitry
