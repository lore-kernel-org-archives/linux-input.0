From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: RE: [PATCH v3 1/1] input: add support for Nomadik SKE keypad
 controller
Date: Wed, 8 Sep 2010 14:55:12 +0200
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B181C8565B5@EXDCVYMBSTM006.EQ1STM.local>
References: <1283777284-24811-1-git-send-email-sundar.iyer@stericsson.com>
 <4C8645CB.9070206@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:54585 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752996Ab0IHMzU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Sep 2010 08:55:20 -0400
In-Reply-To: <4C8645CB.9070206@codeaurora.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Linus WALLEIJ <linus.walleij@stericsson.com>

Hi Trilok,

>-----Original Message-----
>From: Trilok Soni [mailto:tsoni@codeaurora.org]
>
>More description about the keypad controller please.
>

Okay.

>Is it Onchip on the NomaDik or over PMIC?
>

As stated in the Kconfig option, it is on the Nomadik and U8500 platforms.
Anyways, I will update the commit message for more description.

>> +/* register definitions for SKE peripheral */
>
>Why they need to be in the header? These registers #define can be moved to .c file.
>

These registers are for the SKE Keypad - Scroll Key Encoder and Keypad modules. The 
scroll key encoder too shares them and hence in the header file.

>> +	return;
>
>No need.
>

Okay.

>Can you please clarify why you need thread? Looking at the code, I don't think that
>we have any need of creating thread. request_irq(...) should work just fine.

Yes it can. I am seeing increasing tendency to migrate to threaded_irq from the legacy irq recently
and hence the threaded request.

>> +	device_init_wakeup(&pdev->dev, true);
>
>Can you make this pdata?
>

Okay.

>> +MODULE_AUTHOR("Naveen Kumar G/Sundar Iyer");
>
>Care to add e-mail address?
>

Okay.

Dmitry, apart from Trilok's comments above, is there anything else you want me to re-spin?

Regards,
Sundar
