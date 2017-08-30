From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <l.majewski@majess.pl>
Subject: Question regarding placement of touchscreen driver with USB interface
Date: Wed, 30 Aug 2017 10:11:46 +0200
Message-ID: <665f48c4-b5d3-3477-234a-bbea8a7d9774@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:57939 "EHLO
        5.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbdH3JbQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Aug 2017 05:31:16 -0400
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id 71DE074914
        for <linux-input@vger.kernel.org>; Wed, 30 Aug 2017 10:11:47 +0200 (CEST)
Received: from [192.168.2.222] (89-77-92-62.dynamic.chello.pl [89.77.92.62])
        (Authenticated sender: l.majewski@majess.pl)
        by player737.ha.ovh.net (Postfix) with ESMTPSA id 486CCE006E
        for <linux-input@vger.kernel.org>; Wed, 30 Aug 2017 10:11:47 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Dear All,

I would like to ask you for some help regarding placement of a 
touchscreen driver.

The device has two interfaces -> I2C and USB.

I2C is well supported and used:
https://searchcode.com/codesearch/view/16778586/


On my board the USB is used (1.1).

     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Device
       bInterfaceSubClass      0
       bInterfaceProtocol      2 Mouse
       iInterface              0


It shows up as a mice.

And now I'm puzzled, because there are two places where this driver 
could be placed:

1. drivers/input/touchscreen/ (and write the driver in a similar way to 
usbtouchscreen.c)

2. drivers/input/mouse/ (and for example appletouch.c)


Another question is if this USB interface really is a mouse - I 
personally doubt, since for me it looks like USB being only the "other" 
transport layer, which "emulates" I2C access to the device 
(reading/writing a few bytes).



Thanks in advance for support.

-- 
Best regards.

Łukasz Majewski
