From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH v2] input: touchscreen: add OF match table for ads7846
Date: Wed, 15 Jun 2011 12:01:35 +0800
Message-ID: <4DF82E9F.60501@wytron.com.tw>
References: <1308015955-8286-1-git-send-email-Baohua.Song@csr.com> <4DF6FC70.2050707@wytron.com.tw> <5EB3BFCD089AD643B9BB63439F5FD5E937BB39A1@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.wytron.com.tw ([211.75.82.101]:36534 "EHLO
	www.wytron.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab1FOEBg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2011 00:01:36 -0400
In-Reply-To: <5EB3BFCD089AD643B9BB63439F5FD5E937BB39A1@SHAASIEXM01.ASIA.ROOT.PRI>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Baohua Song <Baohua.Song@csr.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DL-SHA-APBU Linux <DL-SHA-APBULinux@internal.csr.com>, Junyi Zhang <Junyi.Zhang@csr.com>, Grant Likely <grant.likely@secretlab.ca>

On 06/14/2011 02:38 PM, Baohua Song wrote:
>> Could we add an option for gpio
>> pendown, like this?
>>
>> - gpios : should specify GPIO used for pendown.
>>
>> If interrupt node is not present in this node, gpio_to_irq of the pe=
n
>> down GPIO will be used.
>=20
> I disagree... An optional gpio node doesn't make sense here. The resu=
lt of gpio_to_irq is still an interrupt, then we can place the result i=
n interrupt node.
> And the ads7846 driver required an interrupt node but not a gpio node=
 since we don't find any of_get_gpio() in this driver.
> BTW, it even doesn=A1=AFt make sense to call function gpio_to_irq in =
a driver like ads7846. on the contrary, drivers/input/keyboard/gpio_key=
s.c is really an good user of gpio_to_irq.

Hi Barry,

The classical platform data is seldom used when device tree is passed.
So it would be better to disable platform data passing to verify device
tree support.

Without platform data passing, we don't have pdata and
pdata->get_pendown_state func for ads7846_setup_pendown(). The
ads7846_probe() will need updates on this.

Passing gpio for pendown might be a possible solution, as device tree
supports "gpios" node. We could use of_get_gpio_flags() to retrieve it.

I sent an earlier work of mine on this back in Feb. to you.

Best regards,
Thomas

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
