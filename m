From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Wed, 16 Nov 2011 10:25:59 +0000
Message-ID: <4EC38FB7.90609@edigma.com>
References: <4EC10878.20109@edigma.com> <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com> <4EC13B0F.2080509@edigma.com> <CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com> <4EC1427D.2090703@edigma.com> <20111114171300.GB12659@core.coreip.homeip.net> <20111115103225.GA8074@polaris.bitmath.org> <4EC2B882.10503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:50620 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755525Ab1KPK0H (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 05:26:07 -0500
In-Reply-To: <4EC2B882.10503@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chasedouglas@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>

We may want to look into creating a mechanism for taking raw bitmap data
and assigning touch points. ALPS trackpads and apparently Nuno's device
provide raw data and need touch point recognition processing.

Perhaps we could take the code in the ALPS driver and generalize it?


While we belive that further improvements to our device will lead to 
have the processing be made inside the device, if we want to see the 
sensing matrix as we do now we definitly will need that feature

Regards,

Nuno
