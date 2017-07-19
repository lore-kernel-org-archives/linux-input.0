From: jan.steffens@gmail.com
Subject: InterTouch support for Clevo P651Rx
Date: Wed, 19 Jul 2017 22:30:50 +0200
Message-ID: <1500496250.4617.1.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:38524 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbdGSUaz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Jul 2017 16:30:55 -0400
Received: by mail-wr0-f178.google.com with SMTP id f21so6478594wrf.5
        for <linux-input@vger.kernel.org>; Wed, 19 Jul 2017 13:30:54 -0700 (PDT)
Received: from philomeena (philomeena.heftig.homenet.org. [2001:470:1f0b:db0:4685:ff:fe94:4571])
        by smtp.gmail.com with ESMTPSA id t33sm5610198wrc.50.2017.07.19.13.30.52
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jul 2017 13:30:52 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi list,

My laptop is a Schenker H506 (rebrand of Clevo P651RG) and I got the
message about InterTouch support (PNP: SYN1219 PNP0f13). After booting
4.12.2 with psmouse.synaptics_intertouch=1, the rmi_smbus driver is
loaded and the touchpad continues to work.

rmi4_smbus 0-002c: registering SMbus-connected sensor
rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3163-001, fw id: 1924066
input: Synaptics TM3163-001 as /devices/rmi4-00/input/input15

Greetings,
Jan Steffens
