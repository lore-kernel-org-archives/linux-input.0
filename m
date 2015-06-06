From: doa379 <doa379@gmail.com>
Subject: Re: [PATCH] Input: synaptics - switch ForcePad detection to PNP IDs
Date: Sat, 06 Jun 2015 14:11:10 +0100
Message-ID: <5572F16E.9030407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34659 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932597AbbFFNLR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Jun 2015 09:11:17 -0400
Received: by wibut5 with SMTP id ut5so44977153wib.1
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2015 06:11:16 -0700 (PDT)
Received: from [192.168.1.2] (host-78-148-179-78.as13285.net. [78.148.179.78])
        by mx.google.com with ESMTPSA id gh3sm15131123wjb.36.2015.06.06.06.11.15
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2015 06:11:15 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Dec 29 2014 or thereabouts, Dmitry Torokhov wrote:

 > According to Synaptics devices with ForcePads use SYN300D and SYN3014 as
 > PNP IDs, so let's switch from DMI-bases detection scheme to PNP-based
 > one, which should be more reliable.
 >
 > Suggested-by: Hans de Goede <hdegoede@xxxxxxxxxx>
 > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@xxxxxxxxx>




ForcePads are also detected as SYN3018.

In particular:

$ cat /sys/bus/pnp/drivers/i8042\ aux/00\:04/id
SYN3018
SYN0100
SYN0002
PNP0f13


As of Kernel 4.0.4 there is no support for this device. So please add it.


-

