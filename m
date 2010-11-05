From: Russell Shaw <rjshaw@netspace.net.au>
Subject: Evdev uniq id
Date: Fri, 05 Nov 2010 15:42:19 +1100
Message-ID: <4CD38B2B.3080200@netspace.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out4.netspace.net.au ([203.10.110.77]:48268 "EHLO
	smtp.netspace.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750772Ab0KEEsD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Nov 2010 00:48:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.netspace.net.au (Postfix) with ESMTP id 1297E125411
	for <linux-input@vger.kernel.org>; Fri,  5 Nov 2010 15:42:22 +1100 (EST)
Received: from smtp.netspace.net.au ([127.0.0.1])
	by localhost (mail-out4.netpace.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HRdKoYectZen for <linux-input@vger.kernel.org>;
	Fri,  5 Nov 2010 15:42:20 +1100 (EST)
Received: from [192.168.0.10] (220.253-234-241.VIC.netspace.net.au [220.253.234.241])
	by smtp.netspace.net.au (Postfix) with ESMTPA id 9D06F12539C
	for <linux-input@vger.kernel.org>; Fri,  5 Nov 2010 15:42:18 +1100 (EST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hi,
In X, i want an application program to apply settings to a specific
mouse/puck device, regardless of how many other devices have been
plugged in since the last session.

Prefereably, a manufacturer-model-serial_number call would be available
from evdev.

Minimally, a uniq non-changing ID could be useful. I found this in
linux-2.6.31.1/drivers/input/evdev.c:

   if (_IOC_NR(cmd) == _IOC_NR(EVIOCGUNIQ(0)))
     return str_to_user(dev->uniq, _IOC_SIZE(cmd), p);

How is "dev->uniq" constructed?
