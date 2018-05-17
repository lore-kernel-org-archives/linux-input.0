From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 1/3] input: touchscreen: edt-ft5x06: make wakeup source
 behavior configurable
Date: Thu, 17 May 2018 10:48:20 +0200
Message-ID: <3a6eb6a2-8a55-e4d8-f495-fd0d80d95de6@zonque.org>
References: <20180516122829.23694-1-daniel@zonque.org>
 <20180516122829.23694-2-daniel@zonque.org> <20180516170333.GA21971@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180516170333.GA21971@dtor-ws>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org, kernel@pengutronix.de, linux-input@vger.kernel.org, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Wednesday, May 16, 2018 07:03 PM, Dmitry Torokhov wrote:
>> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
>> index 5bf63f76ddda..955f085627fa 100644
>> --- a/drivers/input/touchscreen/edt-ft5x06.c
>> +++ b/drivers/input/touchscreen/edt-ft5x06.c
>> @@ -1007,7 +1007,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>>   		goto err_remove_attrs;
>>   
>>   	edt_ft5x06_ts_prepare_debugfs(tsdata, dev_driver_string(&client->dev));
>> -	device_init_wakeup(&client->dev, 1);
>> +	device_init_wakeup(&client->dev,
>> +			    device_property_read_bool(dev, "wakeup-source"));
> 
> I think we should actually drop device_init_wakeup() call. I2C core
> already handles "wakeup-source" property (for OF). The static board
> files can instantiate clients with I2C_CLIENT_WAKE, so that's handled
> too, and I think ACPI has its own notion of annotating wakeup sources.

Ah, right! Thanks, will respin :)


Daniel
