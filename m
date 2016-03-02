From: Gregor Riepl <onitake@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Wed, 2 Mar 2016 19:25:07 +0100
Message-ID: <56D73003.2060606@gmail.com>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
 <56D568C7.20203@gmail.com>
 <CA+V1LzohZr1ryibyS+YQ75D8-txQaiYU5qo2CNWTKS2kwn53dg@mail.gmail.com>
 <CA+V1Lzp8pEtiwH-EWJiDCu=oFpXO9N2SEM5UbSqi5-mxgwsiTg@mail.gmail.com>
 <20160302175232.GC4318@dtor-ws>
 <CA+V1LzoiheCTZRv9xS=f_aTLkb27vw0aha=otYy=eiwOPB52+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36969 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbcCBSZK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 13:25:10 -0500
Received: by mail-wm0-f53.google.com with SMTP id p65so1176374wmp.0
        for <linux-input@vger.kernel.org>; Wed, 02 Mar 2016 10:25:09 -0800 (PST)
In-Reply-To: <CA+V1LzoiheCTZRv9xS=f_aTLkb27vw0aha=otYy=eiwOPB52+Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

> When you rmmod atmel_mxt_ts the touch still continues to work! I guess
> someone just used atmel_mxt_ts probably as prototype for detecting
> (wake uping) chip and loading its firmware and after - no need in any

It may simply be that the pin assignments are the same for these devices, i.e.
they use the same physical pin for controller wakeup. This wouldn't surprise
me at all.

And since the wakeup sequence is sent before actually communicating with the
device over I2C, it seems logical that the ChipOne wakes up and stays on after
the atmel_probe function has been called - even if probe fails afterwards.

