From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Elantech touchpad detected as Logitech PS2 Wheel Mouse
Date: Sun, 20 May 2012 14:20:52 -0500
Message-ID: <20120520192052.GA3959@burratino>
References: <4FB939B5.4000309@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63912 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab2ETTVA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 May 2012 15:21:00 -0400
Received: by obbtb18 with SMTP id tb18so7026318obb.19
        for <linux-input@vger.kernel.org>; Sun, 20 May 2012 12:20:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FB939B5.4000309@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicola Alessi <nialessi@gmx.com>
Cc: linux-input@vger.kernel.org, jj_ding@emc.com.tw

Nicola Alessi wrote:

> While I'm expecting the kernel to correctly detect my touchpad, it's
> detected as a mouse. No scrolling, no multitouch.
> Below there's a snippet of my /proc/bus/input/devices:

Kernel log:

 http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=15;filename=dmesg.txt;att=3;bug=673588

[...]
> The notebook I'm using is a Fujitsu Siemens Amilo pi2515.
> I also tried kernel version 3.3.6 with same results.

Can you get a log with the following patch applied?

Thanks,
Jonathan

diff --git i/drivers/input/mouse/elantech.c w/drivers/input/mouse/elantech.c
index d2c0db159b18..a1d59e11e2d3 100644
--- i/drivers/input/mouse/elantech.c
+++ w/drivers/input/mouse/elantech.c
@@ -10,6 +10,7 @@
  * Trademarks are the property of their respective owners.
  */
 
+#define DEBUG
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/module.h>
