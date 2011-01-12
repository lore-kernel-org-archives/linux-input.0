From: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Subject: RE: [PATCH 1/2] input:Regulator support in ROHM BU21013 touch panel
Date: Wed, 12 Jan 2011 10:05:07 +0100
Message-ID: <81C3A93C17462B4BBD7E272753C1057919521AF539@EXDCVYMBSTM005.EQ1STM.local>
References: <1294814126-13632-1-git-send-email-naveen.gaddipati@stericsson.com>
 <20110112084050.GB4644@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:54931 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751171Ab1ALJZx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 04:25:53 -0500
In-Reply-To: <20110112084050.GB4644@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "tsoni@codeaurora.org" <tsoni@codeaurora.org>, "rydberg@euromail.se" <rydberg@euromail.se>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Dmitry,


>On Wed, Jan 12, 2011 at 12:05:26PM +0530, Naveen Kumar G wrote:
>> @@ -456,6 +459,16 @@ static int __devinit bu21013_probe(struct
>i2c_client *client,
>>  	bu21013_data->in_dev = in_dev;
>>  	bu21013_data->chip = pdata;
>>  	bu21013_data->client = client;
>> +	dev_set_name(&client->dev, pdata->name);
>
>Hmm, why is this needed?
>
Actual name of the client device is 3-005c, which is not clearly understand.
So, in our project line we are setting the device name from platform data.

Thanks & Regards,
Naveen
