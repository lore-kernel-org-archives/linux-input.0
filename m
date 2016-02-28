From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: Re: atmel_mxt_ts maxtouch.cfg firmware
Date: Sun, 28 Feb 2016 02:09:40 +0000
Message-ID: <CA+V1LzrQk6NWPi5MRTX6ihmkZEiG=D50oDqLSNUofMgb+hf84w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34298 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932395AbcB1CJl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Feb 2016 21:09:41 -0500
Received: by mail-qg0-f49.google.com with SMTP id b67so92922263qgb.1
        for <linux-input@vger.kernel.org>; Sat, 27 Feb 2016 18:09:41 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
Just relative question:

Have discovered that on many chinese tablets atmel_mxt_ts is used as a
driver (I guess just only to initialize the chip and load firmware
then switch to the firmware)
for touch_screen like icn85xx (Chuwi Vi10_ 11 rev)  or gsl680 (Cube I7 remix).
The strange is that when rmmod atmel_mxt_ts touch is still working and
there are no any touchrelated moduled in the system (Android).

How it is possible to use atmel_mxt_ts for such purpose?

Regards,
                      Serge Kolotylo.
