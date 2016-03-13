From: Gregor Riepl <onitake@gmail.com>
Subject: Re: Chipone icn85xx support in x86 linux kernel
Date: Sun, 13 Mar 2016 14:24:01 +0100
Message-ID: <56E569F1.1000900@gmail.com>
References: <CA+V1Lzo4-EBWQcpg9T-BBcF5xqa31_JNOZj-ev56PWe=vuvqZQ@mail.gmail.com>
 <56E1EE3C.6010007@gmail.com>
 <CA+V1LzoHQq71riUOciB2PTLm4-Xk5DO1DA49f2uF9SOk5x_rKA@mail.gmail.com>
 <56E41184.8020006@gmail.com>
 <CA+V1LzrQJguh4Yqi56x1Jv+WJtO+A5B_7N6Q6kPw+_zcU6H8Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33141 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcCMNYF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Mar 2016 09:24:05 -0400
Received: by mail-wm0-f52.google.com with SMTP id l68so70842426wml.0
        for <linux-input@vger.kernel.org>; Sun, 13 Mar 2016 06:24:04 -0700 (PDT)
In-Reply-To: <CA+V1LzrQJguh4Yqi56x1Jv+WJtO+A5B_7N6Q6kPw+_zcU6H8Ng@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: linux-input@vger.kernel.org

> Actually I am not sure if I have waked up chip, BUT at the same I am
> stabile receive something on i2c-3 0x30.
> This looks like in DSDT ACPI and by analogy with Chuwi vi8 again is a
> shift on Baytrail -1 on i2cbus.
> The problem is - why I am receiving each time different values for
> reading the same addresses on i2c bus?
> I mean if I read 0xa address (should be 0x85 - the major version of
> the chip) - I receive each time new values but not 0x85! see my posts
> with test results.
> 
> HOW IT COULD BE  POSSIBLE SO?
>
> ...
> 
> Also from android - the only TS module is loaded and present is
> atmel_mxt_ts - nm g shows

Well.... Perhaps you have one of those Atmel maXTouch chips after all?

Have you looked inside your tablet to confirm this?

The mXT most likely has a different protocol/memory map than the icn85xx.
If you can find a data sheet, you may be able to read the respective
identification registers.

Also, keep in mind that a loaded module does not necessarily mean you have the
corresponding hardware. There could be a user space driver that handles touch
on Android.

Or perhaps... You have a totally different chip.
Are you sure that all icnxxxx devices use the same memory map?
