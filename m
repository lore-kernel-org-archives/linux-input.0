From: "Hn Chen" <hn.chen@weidahitech.com>
Subject: RE: [PATCH v5] Fix the resolution issue in ChromeOS
Date: Wed, 10 Jun 2015 22:41:26 +0800
Message-ID: <1A63A1423E772B419A9D2E882CBCF6C4020229A8@mail>
References: <1432873649-32484-1-git-send-email-hn.chen@weidahitech.com> <20150608055629.GA23660@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:1832 "EHLO
	ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933567AbbFJOls convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jun 2015 10:41:48 -0400
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Dmitry, 

Thanks for your suggestion !

> Thank you for making changes, I have some more comments. By the way, have you tried running scripts/checkpatch.pl over your patch? 
> It often picks up some common issues.
I did the check before I submit the patch every time. Below is the way what I did, is it lack of some parameters ?
./scripts/checkpatch.pl -f driver/input/touchscreen/wdt87xx_i2c.c
Or do I check the wrong file ?  

> Why do you need to disable IRQ here just ti enable it again in probe()?
Just in case to prevent the IRQ triggered and the input device is not ready.
After you remind me to create the input device first and then request irq, 
I think they (disable IRQ in request & enable IRQ in probe) can be just removed from codes.

Hn.chen 


