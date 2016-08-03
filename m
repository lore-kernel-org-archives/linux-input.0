From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Fix tuchpad wakeup on ASUS laptops (was [PATCH] Input:
 /input/mouse/elan_i2c_core.c)
Date: Tue, 2 Aug 2016 23:25:28 -0700
Message-ID: <20160803062528.GA32559@dtor-ws>
References: <1468416629-4615-1-git-send-email-kt.liao@emc.com.tw>
 <20160713192247.GB10821@dtor-ws>
 <20160802214609.319d6e588652339f672d149b@vaygr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:32949 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbcHCG2W (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2016 02:28:22 -0400
Content-Disposition: inline
In-Reply-To: <20160802214609.319d6e588652339f672d149b@vaygr.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vlad Glagolev <stealth@vaygr.net>
Cc: KT Liao <ktalex.liao@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw, kt.liao@emc.com.tw, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jonathan Gradstein <jgradstein@gmail.com>, Chris Chiu <chiu@endlessm.com>

On Tue, Aug 02, 2016 at 09:46:09PM -0400, Vlad Glagolev wrote:
> Hey Dmitry!
> 
> Thanks, I've been testing it for 2+ weeks. Works like a charm so far.

Thanks Vlad! I'll queue it for 4.8 and mark for stable.

> 
> On Wed, 13 Jul 2016 12:22:47 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > [ Resending to actually CC people I asked to try the patch ]
> > 
> > On Wed, Jul 13, 2016 at 09:30:29PM +0800, KT Liao wrote:
> > > Fix some Asus touchapod which casue TP no funciton sometimes, the patch detect some specific touchpad and run a special initialize
> > > 
> > > Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> > > ---
> > >  drivers/input/mouse/elan_i2c_core.c | 93 ++++++++++++++++++++++++++++---------
> > >  1 file changed, 71 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> > > index 2f58985..36a69d2 100644
> > > --- a/drivers/input/mouse/elan_i2c_core.c
> > > +++ b/drivers/input/mouse/elan_i2c_core.c
> > > @@ -3,8 +3,8 @@
> > >   *
> > >   * Copyright (c) 2013 ELAN Microelectronics Corp.
> > >   *
> > > - * Author: 林政維 (Duson Lin) <dusonlin@emc.com.tw>
> > 
> > Let's not remove Duson's name, he did quite a bit of work on the driver.
> > 
> > > - * Version: 1.6.0
> > > + * Author: KT Liao <kt.liao@emc.com.tw>
> > > + * Version: 1.6.2
> > >   *
> > >   * Based on cyapa driver:
> > >   * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
> > > @@ -40,7 +40,7 @@
> > >  #include "elan_i2c.h"
> > >  
> > >  #define DRIVER_NAME		"elan_i2c"
> > > -#define ELAN_DRIVER_VERSION	"1.6.1"
> > > +#define ELAN_DRIVER_VERSION	"1.6.2"
> > >  #define ELAN_VENDOR_ID		0x04f3
> > >  #define ETP_MAX_PRESSURE	255
> > >  #define ETP_FWIDTH_REDUCE	90
> > > @@ -95,6 +95,8 @@ struct elan_tp_data {
> > >  	bool			baseline_ready;
> > >  };
> > >  
> > > +static int check_ASUS_special_fw(struct elan_tp_data *data);
> > > +
> > >  static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
> > >  			   u16 *signature_address)
> > >  {
> > > @@ -210,21 +212,40 @@ static int __elan_initialize(struct elan_tp_data *data)
> > >  		return error;
> > >  	}
> > >  
> > > -	data->mode |= ETP_ENABLE_ABS;
> > > -	error = data->ops->set_mode(client, data->mode);
> > > -	if (error) {
> > > -		dev_err(&client->dev,
> > > -			"failed to switch to absolute mode: %d\n", error);
> > > -		return error;
> > > -	}
> > > +	/* If it's the special FW, it need a different flow for mode change.*/
> > > +	if (check_ASUS_special_fw(data)) {
> > > +		error = data->ops->sleep_control(client, false);
> > > +		if (error) {
> > > +			dev_err(&client->dev,
> > > +				"failed to wake device up: %d\n", error);
> > > +			return error;
> > > +		}
> > >  
> > > -	error = data->ops->sleep_control(client, false);
> > > -	if (error) {
> > > -		dev_err(&client->dev,
> > > -			"failed to wake device up: %d\n", error);
> > > -		return error;
> > > -	}
> > > +		msleep(200);
> > >  
> > > +		data->mode |= ETP_ENABLE_ABS;
> > > +		error = data->ops->set_mode(client, data->mode);
> > > +		if (error) {
> > > +			dev_err(&client->dev,
> > > +				"failed to switch to absolute mode: %d\n", error);
> > > +			return error;
> > > +		}
> > > +	} else {
> > > +		data->mode |= ETP_ENABLE_ABS;
> > > +		error = data->ops->set_mode(client, data->mode);
> > > +		if (error) {
> > > +			dev_err(&client->dev,
> > > +				"failed to switch to absolute mode: %d\n", error);
> > > +			return error;
> > > +		}
> > > +
> > > +		error = data->ops->sleep_control(client, false);
> > > +		if (error) {
> > > +			dev_err(&client->dev,
> > > +				"failed to wake device up: %d\n", error);
> > > +			return error;
> > > +		}
> > > +	}
> > >  	return 0;
> > >  }
> > >  
> > > @@ -244,7 +265,7 @@ static int elan_initialize(struct elan_tp_data *data)
> > >  	return error;
> > >  }
> > >  
> > > -static int elan_query_device_info(struct elan_tp_data *data)
> > > +static int elan_query_device_pid_smver(struct elan_tp_data *data)
> > >  {
> > >  	int error;
> > >  
> > > @@ -252,17 +273,24 @@ static int elan_query_device_info(struct elan_tp_data *data)
> > >  	if (error)
> > >  		return error;
> > >  
> > > -	error = data->ops->get_version(data->client, false, &data->fw_version);
> > > +	error = data->ops->get_sm_version(data->client, &data->ic_type,
> > > +					  &data->sm_version);
> > >  	if (error)
> > >  		return error;
> > >  
> > > -	error = data->ops->get_checksum(data->client, false,
> > > -					&data->fw_checksum);
> > > +	return 0;
> > > +}
> > > +
> > > +static int elan_query_device_info(struct elan_tp_data *data)
> > > +{
> > > +	int error;
> > > +
> > > +	error = data->ops->get_version(data->client, false, &data->fw_version);
> > >  	if (error)
> > >  		return error;
> > >  
> > > -	error = data->ops->get_sm_version(data->client, &data->ic_type,
> > > -					  &data->sm_version);
> > > +	error = data->ops->get_checksum(data->client, false,
> > > +					&data->fw_checksum);
> > >  	if (error)
> > >  		return error;
> > >  
> > > @@ -419,6 +447,7 @@ static int elan_update_firmware(struct elan_tp_data *data,
> > >  		data->ops->iap_reset(client);
> > >  	} else {
> > >  		/* Reinitialize TP after fw is updated */
> > > +		elan_query_device_pid_smver(data);
> > >  		elan_initialize(data);
> > >  		elan_query_device_info(data);
> > >  	}
> > > @@ -757,6 +786,22 @@ out:
> > >  	return retval;
> > >  }
> > >  
> > > +static int check_ASUS_special_fw(struct elan_tp_data *data)
> > > +{
> > > +	if (data->ic_type != 0x0E)
> > > +		return false;
> > > +
> > > +	switch (data->product_id) {
> > > +	case 0x05:
> > > +	case 0x06:
> > > +	case 0x07:
> > > +	case 0x09:
> > > +	case 0x013:
> > > +		return true;
> > > +	default:
> > > +		return false;
> > > +	}
> > > +}
> > >  
> > >  static DEVICE_ATTR_WO(acquire);
> > >  static DEVICE_ATTR_RO(min);
> > > @@ -1033,6 +1078,10 @@ static int elan_probe(struct i2c_client *client,
> > >  		return error;
> > >  	}
> > >  
> > > +	error = elan_query_device_pid_smver(data);
> > > +	if (error)
> > > +		return error;
> > 
> > The original code was fetching product ID and IC type after calling the
> > transport "initialize" function; I'd prefer if we kept this order.
> > 
> > Could you tell me if the following version of the patch looks OK to you?
> > 
> > Vlad, Chris, Jonathan, could you please tell me if this version of the
> > patch fixes your touchpad issue?
> > 
> > Thanks!
> > 
> > -- 
> > Dmitry
> > 
> > 
> > Input: elan_i2c - properly wake up touchpad on ASUS laptops
> > 
> > From: KT Liao <kt.liao@emc.com.tw>
> > 
> > Some ASUS laptops were shipped with touchpads that require to be woken up
> > first, before trying to switch them into absolute reporting mode, otherwise
> > touchpad would fail to work while flooding the logs with:
> > 
> > 	elan_i2c i2c-ELAN1000:00: invalid report id data (1)
> > 
> > Among affected devices are Asus E202SA, N552VW, X456UF, UX305CA, and
> > others. We detect such devices by checking the IC type and product ID
> > numbers and adjusting order of operations accordingly.
> > 
> > Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> > Reported-by: Chris Chiu <chiu@endlessm.com>
> > Reported-by: Vlad Glagolev <stealth@vaygr.net>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/mouse/elan_i2c_core.c |   79 ++++++++++++++++++++++++++++-------
> >  1 file changed, 63 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> > index 2f58985..d15b338 100644
> > --- a/drivers/input/mouse/elan_i2c_core.c
> > +++ b/drivers/input/mouse/elan_i2c_core.c
> > @@ -4,7 +4,8 @@
> >   * Copyright (c) 2013 ELAN Microelectronics Corp.
> >   *
> >   * Author: 林政維 (Duson Lin) <dusonlin@emc.com.tw>
> > - * Version: 1.6.0
> > + * Author: KT Liao <kt.liao@emc.com.tw>
> > + * Version: 1.6.2
> >   *
> >   * Based on cyapa driver:
> >   * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
> > @@ -40,7 +41,7 @@
> >  #include "elan_i2c.h"
> >  
> >  #define DRIVER_NAME		"elan_i2c"
> > -#define ELAN_DRIVER_VERSION	"1.6.1"
> > +#define ELAN_DRIVER_VERSION	"1.6.2"
> >  #define ELAN_VENDOR_ID		0x04f3
> >  #define ETP_MAX_PRESSURE	255
> >  #define ETP_FWIDTH_REDUCE	90
> > @@ -199,9 +200,41 @@ static int elan_sleep(struct elan_tp_data *data)
> >  	return error;
> >  }
> >  
> > +static int elan_query_product(struct elan_tp_data *data)
> > +{
> > +	int error;
> > +
> > +	error = data->ops->get_product_id(data->client, &data->product_id);
> > +	if (error)
> > +		return error;
> > +
> > +	error = data->ops->get_sm_version(data->client, &data->ic_type,
> > +					  &data->sm_version);
> > +	if (error)
> > +		return error;
> > +
> > +	return 0;
> > +}
> > +
> > +static int elan_check_ASUS_special_fw(struct elan_tp_data *data)
> > +{
> > +	if (data->ic_type != 0x0E)
> > +		return false;
> > +
> > +	switch (data->product_id) {
> > +	case 0x05 ... 0x07:
> > +	case 0x09:
> > +	case 0x13:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> >  static int __elan_initialize(struct elan_tp_data *data)
> >  {
> >  	struct i2c_client *client = data->client;
> > +	bool woken_up = false;
> >  	int error;
> >  
> >  	error = data->ops->initialize(client);
> > @@ -210,6 +243,27 @@ static int __elan_initialize(struct elan_tp_data *data)
> >  		return error;
> >  	}
> >  
> > +	error = elan_query_product(data);
> > +	if (error)
> > +		return error;
> > +
> > +	/*
> > +	 * Some ASUS devices were shipped with firmware that requires
> > +	 * touchpads to be woken up first, before attempting to switch
> > +	 * them into absolute reporting mode.
> > +	 */
> > +	if (elan_check_ASUS_special_fw(data)) {
> > +		error = data->ops->sleep_control(client, false);
> > +		if (error) {
> > +			dev_err(&client->dev,
> > +				"failed to wake device up: %d\n", error);
> > +			return error;
> > +		}
> > +
> > +		msleep(200);
> > +		woken_up = true;
> > +	}
> > +
> >  	data->mode |= ETP_ENABLE_ABS;
> >  	error = data->ops->set_mode(client, data->mode);
> >  	if (error) {
> > @@ -218,11 +272,13 @@ static int __elan_initialize(struct elan_tp_data *data)
> >  		return error;
> >  	}
> >  
> > -	error = data->ops->sleep_control(client, false);
> > -	if (error) {
> > -		dev_err(&client->dev,
> > -			"failed to wake device up: %d\n", error);
> > -		return error;
> > +	if (!woken_up) {
> > +		error = data->ops->sleep_control(client, false);
> > +		if (error) {
> > +			dev_err(&client->dev,
> > +				"failed to wake device up: %d\n", error);
> > +			return error;
> > +		}
> >  	}
> >  
> >  	return 0;
> > @@ -248,10 +304,6 @@ static int elan_query_device_info(struct elan_tp_data *data)
> >  {
> >  	int error;
> >  
> > -	error = data->ops->get_product_id(data->client, &data->product_id);
> > -	if (error)
> > -		return error;
> > -
> >  	error = data->ops->get_version(data->client, false, &data->fw_version);
> >  	if (error)
> >  		return error;
> > @@ -261,11 +313,6 @@ static int elan_query_device_info(struct elan_tp_data *data)
> >  	if (error)
> >  		return error;
> >  
> > -	error = data->ops->get_sm_version(data->client, &data->ic_type,
> > -					  &data->sm_version);
> > -	if (error)
> > -		return error;
> > -
> >  	error = data->ops->get_version(data->client, true, &data->iap_version);
> >  	if (error)
> >  		return error;
> 
> 
> --
> Vlad Glagolev <stealth@vaygr.net>



-- 
Dmitry
