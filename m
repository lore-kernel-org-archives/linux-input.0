From: Nuno Santos <nsantos@edigma.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Thu, 17 Nov 2011 16:58:36 +0000
Message-ID: <4EC53D3C.9030900@edigma.com>
References: <4EC10878.20109@edigma.com> <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com> <4EC13B0F.2080509@edigma.com> <CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com> <4EC3F2AD.5080505@edigma.com> <20111116192749.GA26909@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.edigma.com ([195.22.21.235]:41106 "EHLO mx01.edigma.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932294Ab1KQQ6k (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 11:58:40 -0500
In-Reply-To: <20111116192749.GA26909@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

 > Now that i'm copying the proper amount of data I have another
 > problem. I'm actually reading this attribute constantly when I open
 > my control panel, however it seems that I can only have reading
 > results from second to second. Is there anything that limits the
 > amount of times I can push attribute data per second? I would
 > definitily need at least 40 readings per second in order to have my
 > data visualized in control panel.

I had overcome this problem using binary attributes. It's blazing fast now.

First I tried with a 4096 length attribute. But when I tried to transfer 
the whole state variable, the one that size is 40k length, I got kernel 
error at the middle of the transfer. My guess in that case is that the 
operation is not atomic and the variable was written between bin 
attribute read calls. Does this make sense?

Having such an attribute would really spare me a lot of time doing the 
control panel interaction and it would make me windows version and linux 
version very similiar, therefore I would use the very mechanisms.

With this said, i'm not discarding all the thing that you guys I have 
been telling me in the last emails and with the time I can make my head 
clear for structural changes in order to make this become better with 
the time in both OS's.

Thanks,

Nuno
