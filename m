From: rosenp@gmail.com
Subject: Synaptiics RMI4 ID
Date: Tue, 15 Aug 2017 16:42:50 -0700
Message-ID: <1502840570.3706.5.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35516 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdHOXmy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Aug 2017 19:42:54 -0400
Received: by mail-pg0-f54.google.com with SMTP id v189so14721993pgd.2
        for <linux-input@vger.kernel.org>; Tue, 15 Aug 2017 16:42:53 -0700 (PDT)
Received: from mangix.clevo ([2001:470:1f05:c3e:68a7:7753:7a32:f6a1])
        by smtp.gmail.com with ESMTPSA id q76sm21585629pfg.42.2017.08.15.16.42.52
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Aug 2017 16:42:52 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I've successfully tested my touchpad with
psmouse.synaptics_intertouch=1 . Obligatory info:

Your touchpad (PNP: SYN1219 PNP0f13) says it can support a different
bus.

synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps:
0xf00123/0x840300/0x26800/0x0, board id: 3163, fw id: 1924066

/proc/bus/input/devices
I: Bus=001d Vendor=06cb Product=0000 Version=0000
N: Name="Synaptics TM3163-001"
P: Phys=rmi4-00/input0
S: Sysfs=/devices/rmi4-00/input/input27
U: Uniq=
H: Handlers=mouse0 event17 
B: PROP=1
B: EV=b
B: KEY=e520 30000 0 0 0 0
B: ABS=6f3800001000003


