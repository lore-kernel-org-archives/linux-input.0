From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Mon, 14 Nov 2011 16:00:15 +0000
Message-ID: <4EC13B0F.2080509@edigma.com>
References: <4EC10878.20109@edigma.com> <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:33696 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752528Ab1KNQAW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 11:00:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx01.edigma.com (Postfix) with ESMTP id 4E66337618FA
	for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 16:00:19 +0000 (WET)
Received: from mx01.edigma.com ([127.0.0.1])
	by localhost (mx01.edigma.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bFTLAbMrnzLR for <linux-input@vger.kernel.org>;
	Mon, 14 Nov 2011 16:00:18 +0000 (WET)
Received: from [192.168.3.103] (unknown [62.28.174.82])
	by mx01.edigma.com (Postfix) with ESMTPSA id 3F89037618D9
	for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 16:00:17 +0000 (WET)
In-Reply-To: <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi David,

Thanks for your reply.

The best way probably is using sysfs. Register one sysfs attribute per
value and configure your callbacks.
There are several other subsystems that provide wrappers for them. If
you could be more specific about the user-space interaction or
configuration values, then we could also be more specific (hopefully
;)).

sysfs? Need to dig about it. Is there any typical example I can look in kernel source? If you could point me one that would be great.

What do I need to exchange between the kernel and the user space is between a simple byte exchange and a whole structure of several bytes.

Do you know the concept of IOCTLS in windows? Basicly that's what looking after.

I need to be able to communicate to and from the device from the an application build in Qt. So, there must be something really generic that I can call from the application environment. In windows I use window API to call IOCTLS interaction.

With my best regards,

Nuno



