From: AJ Guillon <aj.guillon@gmail.com>
Subject: ALPS: Cirque Smart Cat Pro AG Touchpad Support
Date: Wed, 15 Jan 2014 11:16:26 -0500
Message-ID: <52D6B45A.4050202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35294 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaAOQQa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jan 2014 11:16:30 -0500
Received: by mail-ie0-f171.google.com with SMTP id to1so2352713ieb.16
        for <linux-input@vger.kernel.org>; Wed, 15 Jan 2014 08:16:30 -0800 (PST)
Received: from [192.168.1.30] (192-0-162-80.cpe.teksavvy.com. [192.0.162.80])
        by mx.google.com with ESMTPSA id c10sm29934284igx.4.2014.01.15.08.16.28
        for <linux-input@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 15 Jan 2014 08:16:29 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi everyone,

I bought a Cirque Glidepoint (Model GP415U-5321) that I would like to
use with Linux.  I haven't hacked on the kernel before, but I'm happy to
test and modify alps.c as required to get this device working.

I downloaded alps-reg-dump from
git://kernel.ubuntu.com/sforshee/alps-reg-dump.git and it reports:

Found serio mouse at /sys/bus/serio/devices/serio1/
Invalid ack byte 0xfe after command
Invalid ack byte 0xfe after command
E6 report failed, not an ALPS touchpad

The PCI ID of the device is: 0488:0282

I'm not sure if there is anything else I should try.  I am currently
running Ubuntu 12.04 with kernel 3.2.0-29-generic.

AJ
