From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH V3 1/3] iio: mxs-lradc: simplify TS registration
Date: Wed, 4 May 2016 10:38:31 +0100
Message-ID: <7cb1766c-a3c2-891a-9bb8-df8f7b7c3407@kernel.org>
References: <1461441479-23218-1-git-send-email-stefan.wahren@i2se.com>
 <1461441479-23218-2-git-send-email-stefan.wahren@i2se.com>
 <20160425210006.GA26059@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35781 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbcEDOhq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2016 10:37:46 -0400
In-Reply-To: <20160425210006.GA26059@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Marek Vasut <marex@denx.de>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Juergen Borleis <jbe@pengutronix.de>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 25/04/16 22:00, Dmitry Torokhov wrote:
> On Sat, Apr 23, 2016 at 07:57:57PM +0000, Stefan Wahren wrote:
>> This patch simplifies the TS registration of mxs-lradc by
>> using devm_input_allocate_device.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Applied to the togreg branch of iio.git - initially going
to be pushed out as testing though may not be until the weekend.

Jonathan
> 
>> ---
>>  drivers/iio/adc/mxs-lradc.c |   10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
>> index ad26da1..3d1d370 100644
>> --- a/drivers/iio/adc/mxs-lradc.c
>> +++ b/drivers/iio/adc/mxs-lradc.c
>> @@ -1120,18 +1120,16 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>>  {
>>  	struct input_dev *input;
>>  	struct device *dev = lradc->dev;
>> -	int ret;
>>  
>>  	if (!lradc->use_touchscreen)
>>  		return 0;
>>  
>> -	input = input_allocate_device();
>> +	input = devm_input_allocate_device(dev);
>>  	if (!input)
>>  		return -ENOMEM;
>>  
>>  	input->name = DRIVER_NAME;
>>  	input->id.bustype = BUS_HOST;
>> -	input->dev.parent = dev;
>>  	input->open = mxs_lradc_ts_open;
>>  	input->close = mxs_lradc_ts_close;
>>  
>> @@ -1146,11 +1144,8 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
>>  
>>  	lradc->ts_input = input;
>>  	input_set_drvdata(input, lradc);
>> -	ret = input_register_device(input);
>> -	if (ret)
>> -		input_free_device(lradc->ts_input);
>>  
>> -	return ret;
>> +	return input_register_device(input);
>>  }
>>  
>>  static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
>> @@ -1159,7 +1154,6 @@ static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
>>  		return;
>>  
>>  	mxs_lradc_disable_ts(lradc);
>> -	input_unregister_device(lradc->ts_input);
>>  }
>>  
>>  /*
>> -- 
>> 1.7.9.5
>>
> 

