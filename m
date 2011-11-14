From: Nuno Santos <nsantos@edigma.com>
Subject: Interacting with a input kernel driver from user space
Date: Mon, 14 Nov 2011 12:24:24 +0000
Message-ID: <4EC10878.20109@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:35796 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413Ab1KNMY2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 07:24:28 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx01.edigma.com (Postfix) with ESMTP id AFE9A37618D9
	for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 12:24:26 +0000 (WET)
Received: from mx01.edigma.com ([127.0.0.1])
	by localhost (mx01.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bHTZh0FPyA-4 for <linux-input@vger.kernel.org>;
	Mon, 14 Nov 2011 12:24:26 +0000 (WET)
Received: from [192.168.3.103] (unknown [62.28.174.82])
	by mx01.edigma.com (Postfix) with ESMTPSA id C350537618D6
	for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 12:24:25 +0000 (WET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I'm developing a linux kernel driver for a multitouch device. Right now 
I have already touch being injected to the linux kernel subsystem and it 
is working. The problem is that I also need to interact with the device 
to change settings an so on.

While the kernel is grabbing the device I can't grab it in user space, 
so I need to find a way to interact with the kernel driver.

My first driver test (missile laucnher example found on the internet) 
had some extra operations that I can't find on the current model i'm 
using (usbtouchscreen driver was my starting point).

It had open, close, read, write operations that I could perform from 
user space.

How can I do such things with input drivers? Is there any official way?

Thanks in advance,

With my best regards,

Nuno Santos

