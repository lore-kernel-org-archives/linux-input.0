From: Nuno Santos <nsantos@edigma.com>
Subject: Findind input event device path with libudev
Date: Wed, 16 Nov 2011 12:02:30 +0000
Message-ID: <4EC3A656.7050800@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:47689 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756388Ab1KPMCc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 07:02:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx01.edigma.com (Postfix) with ESMTP id 1777F3761915
	for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 12:02:31 +0000 (WET)
Received: from mx01.edigma.com ([127.0.0.1])
	by localhost (mx01.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Po+t1VVy5e69 for <linux-input@vger.kernel.org>;
	Wed, 16 Nov 2011 12:02:30 +0000 (WET)
Received: from [192.168.3.103] (unknown [62.28.174.82])
	by mx01.edigma.com (Postfix) with ESMTPSA id 704BF3761889
	for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 12:02:30 +0000 (WET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I found an example on how to use libudev to iterate over devices present 
in the system to find its precise path since the path can be different 
everytime we plug a device into the system.

http://www.signal11.us/oss/udev/

In this example, the type of device searched is hidraw, however I have 
already tried input, event, etc and none of this match criterias in the 
following function:

|*udev_enumerate_add_match_subsystem*(enumerate,*"hidraw"*);|


Only hidraw seems to work.

Can I use this technic to found the path a of input event device?

Thanks,

With my best regards,

Nuno

