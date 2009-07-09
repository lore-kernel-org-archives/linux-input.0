From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2] input:Add clk api support for w90p910 touchscreen
Date: Thu, 09 Jul 2009 15:01:42 +0800
Message-ID: <4A5595D6.8060501@gmail.com>
References: <4A555B9E.8060508@gmail.com> <20090709051143.GA14516@dtor-d630.eng.vmware.com> <4A557CBC.3000507@gmail.com> <20090709062929.GD14516@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:45124 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760260AbZGIHBv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 03:01:51 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1880897rvb.1
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2009 00:01:47 -0700 (PDT)
In-Reply-To: <20090709062929.GD14516@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input@vger.kernel.org, Trilok Soni <soni.trilok@gmail.com>

Dear Dmitry,

Please see below.


Dmitry Torokhov:
> On Thu, Jul 09, 2009 at 01:14:36PM +0800, Wan ZongShun wrote:
>> Dmitry Torokhov =E5=86=99=E9=81=93:
>>> Hi Wan,
>>>
>>> On Thu, Jul 09, 2009 at 10:53:18AM +0800, Wan ZongShun wrote:
>>>> @@ -311,6 +309,9 @@ static int __devexit w90x900ts_remove(struct p=
latform_device *pdev)
>>>>  	del_timer_sync(&w90p910_ts->timer);
>>>>  	iounmap(w90p910_ts->ts_reg);
>>>> =20
>>>> +	clk_disable(w90p910_ts->clk);
>>> This disable is unneeded since we already disable clock in close().=
 I
>>> will fix locally and apply, there is no need to resubmit. I will al=
so
>>> fix pxa27 driver.
>> Okay, got it, thanks for your help!
>>
>=20
> Umm, one more thing - we need to add "depends on" to Kconfig since
> clk API is not implemented on every platform. Any ideas what is the
> most wide dependency is?
>=20

Do you mean that w90p910 ts have missed this "depends on"?
Adding this depends as following:

config TOUCHSCREEN_W90X900
	tristate "W90P910 touchscreen driver"
	depends on ARCH_W90X900
	help
	  Say Y here if you have a W90P910 based touchscreen.

	  To compile this driver as a module, choose M here: the
	  module will be called w90p910_ts.

Is it okay, now?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
