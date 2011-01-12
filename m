From: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Subject: RE: [PATCH 1/2] input:Regulator support in ROHM BU21013 touch panel
Date: Wed, 12 Jan 2011 11:04:10 +0100
Message-ID: <81C3A93C17462B4BBD7E272753C1057919521AF64C@EXDCVYMBSTM005.EQ1STM.local>
References: <1294814126-13632-1-git-send-email-naveen.gaddipati@stericsson.com>
 <20110112084050.GB4644@core.coreip.homeip.net>
 <81C3A93C17462B4BBD7E272753C1057919521AF539@EXDCVYMBSTM005.EQ1STM.local>
 <20110112091553.GA4183@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:54025 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750942Ab1ALKEf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 05:04:35 -0500
In-Reply-To: <20110112091553.GA4183@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "tsoni@codeaurora.org" <tsoni@codeaurora.org>, "rydberg@euromail.se" <rydberg@euromail.se>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Bengt JONSSON <bengt.g.jonsson@stericsson.com>

Hi Dmitry,

>>
>> >On Wed, Jan 12, 2011 at 12:05:26PM +0530, Naveen Kumar G wrote:
>> >> @@ -456,6 +459,16 @@ static int __devinit bu21013_probe(struct
>> >i2c_client *client,
>> >>  	bu21013_data->in_dev = in_dev;
>> >>  	bu21013_data->chip = pdata;
>> >>  	bu21013_data->client = client;
>> >> +	dev_set_name(&client->dev, pdata->name);
>> >
>> >Hmm, why is this needed?
>> >
>> Actual name of the client device is 3-005c, which is not clearly
>understand.
>> So, in our project line we are setting the device name from platform
>data.
>>
>
>So who/what cares about I2C device name? I do not see how this help
>anything, but it does make device's name differ from its sysfs name.
>
>I believe that driver should only alter names of objects they create and
>leave other objects alone.
>

In our regulator driver platform data, we used to differentiate with device name,
which is more readable than the client device name. That is why we are sending it through platform data.
If you are not preferable to use this, we could change it to client device name.

Thanks & Regards,
Naveen
