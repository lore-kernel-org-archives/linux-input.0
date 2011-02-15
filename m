From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] bma023: Support for Bosch BMA023, BMA150 and SMB380 accelerometers
Date: Tue, 15 Feb 2011 11:39:45 +0530
Message-ID: <4D5A18A9.8090104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:39291 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751268Ab1BOGJw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Feb 2011 01:09:52 -0500
Received: by yxm8 with SMTP id 8so2644591yxm.21
        for <linux-input@vger.kernel.org>; Mon, 14 Feb 2011 22:09:50 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-input@vger.kernel.org

Hi Alan,

A few doubts
>  +
>  +/**
>  + *	bma023_suspend		-	called on device suspend
>  + *	@client: i2c client of sensor

 > + * @mesg: actual suspend type
 > + *
 > + * Put the device into sleep mode before we suspend the machine.
 > + */
 > +static int bma023_suspend(struct i2c_client *client, pm_message_t mesg)
 > +{
 > + bma023_set_power_mode(client, BMA023_SUSPEND);
 > + return 0;
 > +}
 > +
 > +/**
 > + * bma023_resume - called on device resume
 > + * @client: i2c client of sensor
 > + *
 > + * Put the device into powered mode on resume.
 > + */
 > +static int bma023_resume(struct i2c_client *client)
 > +{
 > + struct bma023_sensor *sensor = dev_get_drvdata(&client->dev);
 > + if (bma023_get_check_reg(client) != BMA023_INSPECT_VAL)
 > + bma023_initialize(sensor);
The initialise is only in the resume and not in the runtime resume.
 > + bma023_set_power_mode(client, sensor->power_mode);
where is sensor->power_mode getting updated.
 > + msleep(4); /* wait for accel chip resume */
The startup time from poweroff seems to be 3ms am I missing something.
May consider a #define for the time.
 > + return 0;
 > +}
 > +
 > +#else
 > +#define bma023_suspend NULL
 > +#define bma023_resume NULL
 > +#endif
<snip>


 >+ .probe = bma023_probe,
 >+ .remove = __devexit_p(bma023_remove),
 >+ .suspend = bma023_suspend,
 >+ .resume = bma023_resume,
You may consider moving these also to the pm ops.
However these can be taken up later feel free to ignore such comments.
 >+ .id_table = bma023_ids,



