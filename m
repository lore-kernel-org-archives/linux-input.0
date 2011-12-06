From: Nuno Santos <nsantos@edigma.com>
Subject: Restoring kernel module settings
Date: Tue, 06 Dec 2011 18:34:32 +0000
Message-ID: <4EDE6038.5080303@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:37747 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632Ab1LFSeh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Dec 2011 13:34:37 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx01.edigma.com (Postfix) with ESMTP id 6985A37625FD
	for <linux-input@vger.kernel.org>; Tue,  6 Dec 2011 18:34:35 +0000 (WET)
Received: from mx01.edigma.com ([127.0.0.1])
	by localhost (mx01.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nH8lGVZ04a2G for <linux-input@vger.kernel.org>;
	Tue,  6 Dec 2011 18:34:35 +0000 (WET)
Received: from [192.168.3.103] (unknown [62.28.174.82])
	by mx01.edigma.com (Postfix) with ESMTPSA id 505B73761849
	for <linux-input@vger.kernel.org>; Tue,  6 Dec 2011 18:34:34 +0000 (WET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have developed a kernel module to act as driver for a multitouch input 
device,

It happens that the kernel module settings are setted and getted via 
binnary attributes.

I know that kernel modules can't save or read files. I need an 
alternative way of restoring a saved settings state.

Question:

Is there any way of calling a determined program when a device is 
connected to the computer?

My idea is to develop a really small application that sets the saved 
settings from the last time the device control panel interacted with the 
device.

I think someone has already suggested udev to do it. What functionality 
should I search within udev documentation? Is there any other way of 
achieving this?

Thank you in advance,

With my best regards,

Nuno
