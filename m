From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
Date: Mon, 21 Jun 2010 22:19:55 +0800
Message-ID: <AANLkTimhik3BOQNzybs1tUuHUXri-yxm5v7wH1JjQ5B1@mail.gmail.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
	<AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
	<4C1F4B30.3020006@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45361 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab0FUOUT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 10:20:19 -0400
In-Reply-To: <4C1F4B30.3020006@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

>> and now in s5pc200 code, you can also register/re-use the s5pc100_keypad
>> device/driver, and everyone knows - OK, the IP on S5PC100 is now re-used
>> here.
>>
>
> This is naming issue and i know it was not desided yet.
> This keypad driver can support s3c64xx, s5pc100, s5pc110, s5pv210.
>

I bet the first silicon this IP is deployed is s3c64xx, so my understanding
's3c64xx-keypad.c' should be an acceptable name.  And it's also reasonable,
a s3c64xx-keypad driver, and is later expanded to support subsequent silicons
without the file name being changed.
