From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Tue, 15 Nov 2011 18:41:53 +0000
Message-ID: <4EC2B271.90209@edigma.com>
References: <4EC10878.20109@edigma.com> <CANq1E4SVHvkaPqOR2Mfm7e-74yenvvkEoZz1MPkCHEh-dwSveg@mail.gmail.com> <4EC15CD1.2010409@edigma.com> <201111141057.42310.dmitry.torokhov@gmail.com> <4EC23252.8030003@edigma.com> <20111115182331.GA6410@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:47168 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286Ab1KOSl7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 13:41:59 -0500
In-Reply-To: <20111115182331.GA6410@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Generally we restrict access to sysfs attributes to root since they
control behavior for all users, not only one why is changin sysfs
attribute.


Hummm... that leads me to a question. How can I make use of such attributes inside an application without having root access? Imagine that I open the control panel of the device in a user account, the contol panel itself will not have access to the attributes and it will not work. How do I overcome this problem?

Imagine that my device is a soundcard and it has a beautifull control panel to control non general parameters. What would be the interface used by the control panel to access the kernel driver and modify the soundcard parameters?


BTW, please use "reply-all" on linux kernel mailing lists - it is most
preferred method. This way you ensure faster responses from people who
already participating in the thread as I scan my inbox is much more
often than folder where I save linux-input mails.

:) I noticed that all of you were replying that way but couldn't understand why. Thanks.

Regards,

Nuno

