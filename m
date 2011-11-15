From: Nuno Santos <nsantos@edigma.com>
Subject: Changing the settings of the device driver
Date: Tue, 15 Nov 2011 16:34:26 +0000
Message-ID: <4EC29492.5030209@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:40305 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756540Ab1KOQea (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 11:34:30 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx01.edigma.com (Postfix) with ESMTP id 93BBD3761926
	for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 16:34:27 +0000 (WET)
Received: from mx01.edigma.com ([127.0.0.1])
	by localhost (mx01.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9K3cYvnpJbYR for <linux-input@vger.kernel.org>;
	Tue, 15 Nov 2011 16:34:27 +0000 (WET)
Received: from [192.168.3.103] (unknown [62.28.174.82])
	by mx01.edigma.com (Postfix) with ESMTPSA id 0B2373761923
	for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 16:34:26 +0000 (WET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have been reading about linux kernel development and ioctl seems to be 
discouraged by kernel developers.

However ioctl is precisely what i'm looking for to mimic what I have in 
my Windows driver version.

Should I consider an option to implement ioctl's to change my device 
settings?

Thanks,

Nuno
