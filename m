From: Oleg Kravchenko <oleg@kaa.org.ua>
Subject: i2c keyboard
Date: Mon, 23 Feb 2009 10:50:52 +0200
Message-ID: <49A2636C.10502@kaa.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kaa.org.ua ([193.178.146.73]:35756 "EHLO kaa.org.ua"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbZBWJAv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2009 04:00:51 -0500
Received: from [192.168.1.80] (unknown [213.160.132.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by kaa.org.ua (Postfix) with ESMTPSA id C90BAC1592
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2009 10:40:24 +0200 (EET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello, everyone.
We are porting the Linux kernel to our PDA, Asus P525/P535. This device 
has a pca9535 gpio extender. The keyboard is connected to it. The 
extender has only one irq. At the moment, the pca9535 is handled by 
pca953x gpio driver. We need to have the access to its registers from 
our keyboard driver (so as not to read 13 gpios, but decode the register 
containing gpio states). If i try to read each of these 13 gpios after 
the interrupt from the extender comes, the kernel crashes. Is there a 
solution to read i2c client addresses when there is a client registered 
already?


http://www.kaa.org.ua/asus-p535/hardware.html
