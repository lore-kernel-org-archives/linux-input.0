From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Chipone icn85xx support in x86 linux kernel
Date: Sun, 14 Feb 2016 23:03:41 +0000
Message-ID: <CA+V1LzoXvWO1FROO2z7tFc-0zoM_Ur+B1iiar+EJ4uvn+DWGdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35045 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbcBNXDm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Feb 2016 18:03:42 -0500
Received: by mail-qg0-f49.google.com with SMTP id y89so100064131qge.2
        for <linux-input@vger.kernel.org>; Sun, 14 Feb 2016 15:03:42 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello All,
Please advice whether it is supported touch screen icn85xx in anykind
of x86 (baytrail interested in!) kernel?

I have discovered in Vanilla chipone_icn8318.c  kernel driver from Hans de Goede
but this driver in contrast to arm available icn83xx.c looks really
strange, it is even excluded from Kconfig by default in 4.4.1: it has
no firmware load while at the same time android driver
https://android.googlesource.com/kernel/bcm/+/android-bcm-tetra-3.10-lollipop-wear-release/drivers/input/touchscreen/icn83xx.c
has.
Also for rtk3128 chip there is!  icn85xx driver:
https://github.com/bbelos/rk3188-kernel/blob/master/drivers/input/touchscreen/ICN8503/icn85xx.c

I am trying to make it working my touch on Chuwi Vi10 (Baytrail
Z3536), Archlinux, custom 4.4.1 (from Vanilla) kernel.
What I have discovered from Windows and Android: I2c address of TS is
0x48, in Android it is located under i2c-4 0x48

>: cat /sys/bus/i2c/devices/i2c-4/4-0048/name
chipone-icn85xx.

Under windows 8.1 there is icnfirmware.sys for it. (;-) no need to
grab it!), fw also present in .h file of rtk3128 github repo.
GPIO pin I have guessing to enable TS is 393 (stupid looking over all
gpios via sysfs and enabling each to 1).

So my farther additional questions are:

2) Could be icn8318 by Hans de Goede be adopted for icn85xx?
3) Looks currently kernel is not supported ACPII for icn85xx
4) Please advice how to (if possible) having windows and android with
working touch to grab all needed information for makes device working
with kernel (gpio pins).
5) In Windows driver is myi2c.sys and reports that this is chipone ts,
in Android is loaded atmel_mxt_ts module and the most strange thing
afrer rmmod touch is working.
dmesg under android shows: input: chipone-ts as /devices/virtual/input/input5.
modalis: input:b0000v0000p0000-e0,1,3,k8b,9e,d9,ra2f,30,32,35,36,39,m1sfw
how it is possible to use atmel_mxt_ts module for chipone? or what is the trick?

Thanks in advance,
      hope together we will make it working under x86!
Regards,
                 Serge Kolotylo.
