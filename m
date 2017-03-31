From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 4/4] Input: synaptics-rmi4 - when registering sensors do
 not call them "drivers"
Date: Fri, 31 Mar 2017 11:28:42 +0200
Message-ID: <20170331092842.GK22683@mail.corp.redhat.com>
References: <20170325060050.39867-1-dmitry.torokhov@gmail.com>
 <20170325060050.39867-4-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932554AbdCaJ2t (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 05:28:49 -0400
Content-Disposition: inline
In-Reply-To: <20170325060050.39867-4-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>

On Mar 24 2017 or thereabouts, Dmitry Torokhov wrote:
> We are not registering drivers, but transport devices (AKA sensors), so
> let's call them that.
> 
> Also let's rename "retval" to "error" in probe() functions as the variables
> are used to store error codes.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/rmi4/rmi_i2c.c   | 51 +++++++++++++++++++++---------------------
>  drivers/input/rmi4/rmi_smbus.c | 43 +++++++++++++++++------------------
>  drivers/input/rmi4/rmi_spi.c   | 44 +++++++++++++++++++-----------------
>  3 files changed, 69 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> index 082306d7c207..e28663ef9e5a 100644
> --- a/drivers/input/rmi4/rmi_i2c.c
> +++ b/drivers/input/rmi4/rmi_i2c.c
> @@ -204,7 +204,7 @@ static int rmi_i2c_probe(struct i2c_client *client,
>  	struct rmi_device_platform_data *client_pdata =
>  					dev_get_platdata(&client->dev);
>  	struct rmi_i2c_xport *rmi_i2c;
> -	int retval;
> +	int error;
>  
>  	rmi_i2c = devm_kzalloc(&client->dev, sizeof(struct rmi_i2c_xport),
>  				GFP_KERNEL);
> @@ -220,30 +220,31 @@ static int rmi_i2c_probe(struct i2c_client *client,
>  
>  	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Probing %s.\n",
>  			dev_name(&client->dev));
> +
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>  		dev_err(&client->dev,
> -			"adapter does not support required functionality.\n");
> +			"adapter does not support required functionality\n");
>  		return -ENODEV;
>  	}
>  
>  	rmi_i2c->supplies[0].supply = "vdd";
>  	rmi_i2c->supplies[1].supply = "vio";
> -	retval = devm_regulator_bulk_get(&client->dev,
> +	error = devm_regulator_bulk_get(&client->dev,
>  					 ARRAY_SIZE(rmi_i2c->supplies),
>  					 rmi_i2c->supplies);
> -	if (retval < 0)
> -		return retval;
> +	if (error < 0)
> +		return error;
>  
> -	retval = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
> +	error = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
>  				       rmi_i2c->supplies);
> -	if (retval < 0)
> -		return retval;
> +	if (error < 0)
> +		return error;
>  
> -	retval = devm_add_action_or_reset(&client->dev,
> +	error = devm_add_action_or_reset(&client->dev,
>  					  rmi_i2c_regulator_bulk_disable,
>  					  rmi_i2c);
> -	if (retval)
> -		return retval;
> +	if (error)
> +		return error;
>  
>  	of_property_read_u32(client->dev.of_node, "syna,startup-delay-ms",
>  			     &rmi_i2c->startup_delay);
> @@ -263,26 +264,26 @@ static int rmi_i2c_probe(struct i2c_client *client,
>  	 * Setting the page to zero will (a) make sure the PSR is in a
>  	 * known state, and (b) make sure we can talk to the device.
>  	 */
> -	retval = rmi_set_page(rmi_i2c, 0);
> -	if (retval) {
> -		dev_err(&client->dev, "Failed to set page select to 0.\n");
> -		return retval;
> +	error = rmi_set_page(rmi_i2c, 0);
> +	if (error) {
> +		dev_err(&client->dev, "Failed to set page select to 0\n");
> +		return error;
>  	}
>  
> -	retval = rmi_register_transport_device(&rmi_i2c->xport);
> -	if (retval) {
> -		dev_err(&client->dev, "Failed to register transport driver at 0x%.2X.\n",
> -			client->addr);
> -		return retval;
> +	dev_info(&client->dev, "registering I2C-connected sensor\n");
> +
> +	error = rmi_register_transport_device(&rmi_i2c->xport);
> +	if (error) {
> +		dev_err(&client->dev, "failed to register sensor: %d\n", error);
> +		return error;
>  	}
> -	retval = devm_add_action_or_reset(&client->dev,
> +
> +	error = devm_add_action_or_reset(&client->dev,
>  					  rmi_i2c_unregister_transport,
>  					  rmi_i2c);
> -	if (retval)
> -		return retval;
> +	if (error)
> +		return error;
>  
> -	dev_info(&client->dev, "registered rmi i2c driver at %#04x.\n",
> -			client->addr);
>  	return 0;
>  }
>  
> diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
> index 724643bf31a6..e84400301973 100644
> --- a/drivers/input/rmi4/rmi_smbus.c
> +++ b/drivers/input/rmi4/rmi_smbus.c
> @@ -53,6 +53,7 @@ static int rmi_smb_get_version(struct rmi_smb_xport *rmi_smb)
>  		dev_err(&client->dev, "failed to get SMBus version number!\n");
>  		return retval;
>  	}
> +
>  	return retval + 1;
>  }
>  
> @@ -274,19 +275,24 @@ static int rmi_smb_probe(struct i2c_client *client,
>  {
>  	struct rmi_device_platform_data *pdata = dev_get_platdata(&client->dev);
>  	struct rmi_smb_xport *rmi_smb;
> -	int retval;
>  	int smbus_version;
> +	int error;
> +
> +	if (!pdata) {
> +		dev_err(&client->dev, "no platform data, aborting\n");
> +		return -ENOMEM;
> +	}
>  
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_READ_BLOCK_DATA |
>  				     I2C_FUNC_SMBUS_HOST_NOTIFY)) {
>  		dev_err(&client->dev,
> -			"adapter does not support required functionality.\n");
> +			"adapter does not support required functionality\n");
>  		return -ENODEV;
>  	}
>  
>  	if (client->irq <= 0) {
> -		dev_err(&client->dev, "no IRQ provided, giving up.\n");
> +		dev_err(&client->dev, "no IRQ provided, giving up\n");
>  		return client->irq ? client->irq : -ENODEV;
>  	}
>  
> @@ -295,12 +301,7 @@ static int rmi_smb_probe(struct i2c_client *client,
>  	if (!rmi_smb)
>  		return -ENOMEM;
>  
> -	if (!pdata) {
> -		dev_err(&client->dev, "no platform data, aborting\n");
> -		return -ENOMEM;
> -	}
> -
> -	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Probing %s.\n",
> +	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Probing %s\n",
>  		dev_name(&client->dev));
>  
>  	rmi_smb->client = client;
> @@ -313,34 +314,30 @@ static int rmi_smb_probe(struct i2c_client *client,
>  	rmi_smb->xport.proto_name = "smb2";
>  	rmi_smb->xport.ops = &rmi_smb_ops;
>  
> -	retval = rmi_smb_get_version(rmi_smb);
> -	if (retval < 0)
> -		return retval;
> +	smbus_version = rmi_smb_get_version(rmi_smb);
> +	if (smbus_version < 0)
> +		return smbus_version;
>  
> -	smbus_version = retval;
>  	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
>  		smbus_version);
>  
>  	if (smbus_version != 2) {
> -		dev_err(&client->dev, "Unrecognized SMB version %d.\n",
> +		dev_err(&client->dev, "Unrecognized SMB version %d\n",
>  				smbus_version);
>  		return -ENODEV;
>  	}
>  
>  	i2c_set_clientdata(client, rmi_smb);
>  
> -	retval = rmi_register_transport_device(&rmi_smb->xport);
> -	if (retval) {
> -		dev_err(&client->dev, "Failed to register transport driver at 0x%.2X.\n",
> -			client->addr);
> -		i2c_set_clientdata(client, NULL);
> -		return retval;
> +	dev_info(&client->dev, "registering SMbus-connected sensor\n");
> +
> +	error = rmi_register_transport_device(&rmi_smb->xport);
> +	if (error) {
> +		dev_err(&client->dev, "failed to register sensor: %d\n", error);
> +		return error;
>  	}
>  
> -	dev_info(&client->dev, "registered rmi smb driver at %#04x.\n",
> -			client->addr);
>  	return 0;
> -
>  }
>  
>  static int rmi_smb_remove(struct i2c_client *client)
> diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
> index 69548d7d1f10..d97a85907ed6 100644
> --- a/drivers/input/rmi4/rmi_spi.c
> +++ b/drivers/input/rmi4/rmi_spi.c
> @@ -370,7 +370,7 @@ static int rmi_spi_probe(struct spi_device *spi)
>  	struct rmi_spi_xport *rmi_spi;
>  	struct rmi_device_platform_data *pdata;
>  	struct rmi_device_platform_data *spi_pdata = spi->dev.platform_data;
> -	int retval;
> +	int error;
>  
>  	if (spi->master->flags & SPI_MASTER_HALF_DUPLEX)
>  		return -EINVAL;
> @@ -383,9 +383,9 @@ static int rmi_spi_probe(struct spi_device *spi)
>  	pdata = &rmi_spi->xport.pdata;
>  
>  	if (spi->dev.of_node) {
> -		retval = rmi_spi_of_probe(spi, pdata);
> -		if (retval)
> -			return retval;
> +		error = rmi_spi_of_probe(spi, pdata);
> +		if (error)
> +			return error;
>  	} else if (spi_pdata) {
>  		*pdata = *spi_pdata;
>  	}
> @@ -396,10 +396,10 @@ static int rmi_spi_probe(struct spi_device *spi)
>  	if (pdata->spi_data.mode)
>  		spi->mode = pdata->spi_data.mode;
>  
> -	retval = spi_setup(spi);
> -	if (retval < 0) {
> +	error = spi_setup(spi);
> +	if (error < 0) {
>  		dev_err(&spi->dev, "spi_setup failed!\n");
> -		return retval;
> +		return error;
>  	}
>  
>  	pdata->irq = spi->irq;
> @@ -413,32 +413,34 @@ static int rmi_spi_probe(struct spi_device *spi)
>  
>  	spi_set_drvdata(spi, rmi_spi);
>  
> -	retval = rmi_spi_manage_pools(rmi_spi, RMI_SPI_DEFAULT_XFER_BUF_SIZE);
> -	if (retval)
> -		return retval;
> +	error = rmi_spi_manage_pools(rmi_spi, RMI_SPI_DEFAULT_XFER_BUF_SIZE);
> +	if (error)
> +		return error;
>  
>  	/*
>  	 * Setting the page to zero will (a) make sure the PSR is in a
>  	 * known state, and (b) make sure we can talk to the device.
>  	 */
> -	retval = rmi_set_page(rmi_spi, 0);
> -	if (retval) {
> +	error = rmi_set_page(rmi_spi, 0);
> +	if (error) {
>  		dev_err(&spi->dev, "Failed to set page select to 0.\n");
> -		return retval;
> +		return error;
>  	}
>  
> -	retval = rmi_register_transport_device(&rmi_spi->xport);
> -	if (retval) {
> -		dev_err(&spi->dev, "failed to register transport.\n");
> -		return retval;
> +	dev_info(&spi->dev, "registering SPI-connected sensor\n");
> +
> +	error = rmi_register_transport_device(&rmi_spi->xport);
> +	if (error) {
> +		dev_err(&spi->dev, "failed to register sensor: %d\n", error);
> +		return error;
>  	}
> -	retval = devm_add_action_or_reset(&spi->dev,
> +
> +	error = devm_add_action_or_reset(&spi->dev,
>  					  rmi_spi_unregister_transport,
>  					  rmi_spi);
> -	if (retval)
> -		return retval;
> +	if (error)
> +		return error;
>  
> -	dev_info(&spi->dev, "registered RMI SPI driver\n");
>  	return 0;
>  }
>  
> -- 
> 2.12.1.578.ge9c3154ca4-goog
> 
