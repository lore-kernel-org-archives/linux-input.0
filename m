From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input/misc: new ADXL345/346 driver
Date: Tue, 20 Oct 2009 20:14:23 -0700
Message-ID: <332DEBB9-8211-471F-9525-109E43B9C1CC@gmail.com>
Mime-Version: 1.0 (iPhone Mail 7C144)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:53580 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbZJUDO2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Oct 2009 23:14:28 -0400
Received: by pzk26 with SMTP id 26so4527877pzk.4
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2009 20:14:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Verges <chrisv@cyberswitching.com>
Cc: Mike Frysinger <vapier@gentoo.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, Michael Hennerich <michael.hennerich@analog.com>, Luotao Fu <l.fu@pengutronix.de>, Barry Song <barry.song@analog.com>

Hi Chris,

On Tue, Oct 20, 2009 at 11:46:08AM -0700, Chris Verges wrote:
> Hi Mike and Michael,
>
>> +config INPUT_ADXL34X
>> +config INPUT_ADXL34X_I2C
>> +config INPUT_ADXL34X_SPI
>
> Should the INPUT_ADXL34X option be auto-selected when the _I2C or _SPI
> counterparts are selected?  Something like:
>
> config HAVE_INPUT_ADXL34X
>
> config INPUT_ADXL34X
>    depends on HAVE_INPUT_ADXL34X
>
> config INPUT_ADXL34X_I2C
>    bool "..."
>    depends on I2C
>    select HAVE_INPUT_ADXL34X
>
> config INPUT_ADXL34X_SPI
>    bool "..."
>    depends on SPI_MASTER
>    select HAVE_INPUT_ADXL34X
>
> The end user would only see the INPUT_ADXL34X_SPI and  
> INPUT_ADXL34X_I2C
> options, with the common INPUT_ADXL34X option being automagically
> selected due to the reverse dependencies.
>

I don't see any problem with the original patch when user selects chip
support and then presented with choice of buses.

-- 
Dmitry
