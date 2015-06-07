From: doa379 <doa379@gmail.com>
Subject: Synaptics Forcepad Support Kernel 4.1-rc6
Date: Sun, 07 Jun 2015 14:40:37 +0100
Message-ID: <557449D5.2070007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35417 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbbFGNks (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Jun 2015 09:40:48 -0400
Received: by wgme6 with SMTP id e6so84896489wgm.2
        for <linux-input@vger.kernel.org>; Sun, 07 Jun 2015 06:40:46 -0700 (PDT)
Received: from [192.168.1.2] (host-78-148-179-78.as13285.net. [78.148.179.78])
        by mx.google.com with ESMTPSA id ez19sm6893907wid.19.2015.06.07.06.40.46
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2015 06:40:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I am trying to add Forcepad support for a touchpad which isn't yet 
supported.

The kernel is now using pnp ids and so for the device I am using kernel 
reports this:

$ cat /sys/bus/pnp/drivers/i8042\ aux/00\:04/id
SYN3018
SYN0100
SYN0002
PNP0f13


I have tried modifying drivers/input/mouse/synaptics.c line 213:

/* This list has been kindly provided by Synaptics. */
static const char * const forcepad_pnp_ids[] = {
	"SYN300D",
	"SYN3014",
+	"SYN3018",
	NULL
};

Unfortunately it hasn't worked. Touchpad is still being detected as 
vanilla PS/2 Generic Mouse.

Which other modifications are needed?


--


