From: Nuno Santos <nsantos@edigma.com>
Subject: Restoring kernel input driver state on boot
Date: Mon, 28 Nov 2011 10:20:32 +0000
Message-ID: <4ED36070.8080700@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:57269 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053Ab1K1KUf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Nov 2011 05:20:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx01.edigma.com (Postfix) with ESMTP id 77CEB376262B
	for <linux-input@vger.kernel.org>; Mon, 28 Nov 2011 10:20:33 +0000 (WET)
Received: from mx01.edigma.com ([127.0.0.1])
	by localhost (mx01.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0XpfX-ycjQfE for <linux-input@vger.kernel.org>;
	Mon, 28 Nov 2011 10:20:33 +0000 (WET)
Received: from [192.168.3.103] (unknown [62.28.174.82])
	by mx01.edigma.com (Postfix) with ESMTPSA id E2E9837625FC
	for <linux-input@vger.kernel.org>; Mon, 28 Nov 2011 10:20:32 +0000 (WET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

Since is not possible for a kernel driver to save anything to a file I 
need to know how could I achieve that using other technic.

Someone mentioned earlier in this list that I could use udev to load 
settings on a kernel module.

Since my module state depends on a whole structure the best thing I can 
remember to achieve this goal is someting like this:

- In user space (and since i'm always exchanging that data from and to 
the kernel module within my device control panel) I could save to a 
fixed place a file with that state.

- With a custom and small utility I could load (using the binnary 
attributes) that state to the kernel module on it's initialization using 
for that udev.

Since my understanding of udev at this point is almost null, I would 
like to know if this is possible, and in what functionality of udev I 
should put my effort on.

If someone could give me an expert advice about I would really 
appreciate it.

Thanks in advance,

With my best regards,

Nuno Santos
