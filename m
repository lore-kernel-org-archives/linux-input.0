From: tsuraan <tsuraan@gmail.com>
Subject: XPad driver, unrecognized controller
Date: Sun, 8 Aug 2010 18:04:24 -0500
Message-ID: <AANLkTinNW2ZJZt9w19q4_eSdhTUHFHrPeOetwcSH1Gta@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62983 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab0HHXEZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Aug 2010 19:04:25 -0400
Received: by qyk7 with SMTP id 7so1584897qyk.19
        for <linux-input@vger.kernel.org>; Sun, 08 Aug 2010 16:04:24 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I  have a standard XBox360 wireless controller (two that came with
XBoxes, a few that didn't).  All of them have this info from
usb/devices:

T:  Bus=02 Lev=01 Prnt=01 Port=05 Cnt=04 Dev#= 21 Spd=12 MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=ff Prot=ff MxPS= 8 #Cfgs=  1
P:  Vendor=045e ProdID=028f Rev= 1.09
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=5d Prot=ff Driver=(none)

Although the P: Rev line varies from 1.05 to 2.04.  None of these
controllers are detected by the xpad driver when plugged into my
computer through the standard USB charging cable.  I've tried adding
the vendor/prodid to the xpad_device array, but it didn't help at all.
 I've also noticed that none of these controllers show a manufacturer,
nor any other things that USB devices normally show.  Do you have any
advice on how to get a standard xbox controller to work under Linux? I
have a cheapo MadCatz device that does work, so I know that much is
functional, anyhow.

I'm running 2.6.35, amd64.

Thanks for any help you can give.
