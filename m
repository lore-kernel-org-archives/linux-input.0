From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] input: edt-ft5x06: fixed a macro coding style issue
Date: Mon, 08 Dec 2014 22:44:20 -0800
Message-ID: <1418107460.15957.9.camel@perches.com>
References: <20141209063456.GA15121@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:45749 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751251AbaLIGoY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Dec 2014 01:44:24 -0500
In-Reply-To: <20141209063456.GA15121@ubuntu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Asaf Vertz <asaf.vertz@tandemg.com>
Cc: dmitry.torokhov@gmail.com, LW@KARO-electronics.de, B38611@freescale.com, maksqwe1@ukr.net, jg1.han@samsung.com, linux@rasmusvillemoes.dk, fabf@skynet.be, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2014-12-09 at 08:34 +0200, Asaf Vertz wrote:
> Fixed a coding style error, macros with complex values should be
> enclosed in parentheses.
[]
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
[]
> @@ -849,10 +849,11 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
>  	return 0;
>  }
>  
> -#define EDT_ATTR_CHECKSET(name, reg) \
> +#define EDT_ATTR_CHECKSET(name, reg) { \
>  	if (pdata->name >= edt_ft5x06_attr_##name.limit_low &&		\
>  	    pdata->name <= edt_ft5x06_attr_##name.limit_high)		\
> -		edt_ft5x06_register_write(tsdata, reg, pdata->name)
> +		edt_ft5x06_register_write(tsdata, reg, pdata->name);	\
> +}

Any time you see a naked if (foo) bar in a macro
prefer to use a do while (0) like;

#define EDT_ATTR_CHECKSET(name, reg)					\
do {									\
	if (pdata->name >= edt_ft5x06_attr_##name.limit_low &&		\
	    pdata->name <= edt_ft5x06_attr_##name.limit_high)		\
		edt_ft5x06_register_write(tsdata, reg, pdata->name);	\
while (0)

