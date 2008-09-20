From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: Sleeping inside spinlock in force feedback input event code
Date: Sat, 20 Sep 2008 23:31:07 +0300
Message-ID: <48D55D8B.4070904@gmail.com>
References: <4868e2410806150157o5b290bf7kaccdeb2faf5057d6@mail.gmail.com> <485540A6.1050306@gmail.com> <4868e2410806151023j67ceea16pe1c5ad8ab9a8e122@mail.gmail.com> <4855507E.4030201@gmail.com> <4868e2410806151036o1a1652d8y8bf8432e3c6c0d06@mail.gmail.com> <4868e2410806151036r6d96a840v41b8ee745041db35@mail.gmail.com> <4868e2410806151105v3fec88a1qa439e2cc1423bc6a@mail.gmail.com> <48556723.2090204@gmail.com> <20080616143112.ZZRA012@mailhub.coreip.homeip.net> <485807F4.3010903@gmail.com> <20080617153423.ZZRA012@mailhub.coreip.homeip.net> <48581857.2080906@gmail.com> <4866E804.3000603@gmail.com> <4883474D.6080602@gmail.com> <alpine.LNX.1.10.0807251122210.16387@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:43804 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128AbYITUbM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Sep 2008 16:31:12 -0400
In-Reply-To: <alpine.LNX.1.10.0807251122210.16387@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, James Carthew <jcarthew@gmail.com>

Jiri Kosina wrote:
> On Sun, 20 Jul 2008, Anssi Hannula wrote:
> 
>> Ping? Please comment :) I'd really much like the hid-pidff driver
>> to not panic when used.
> 
> Hi,

Hi!

> sorry for not commeting on this for quite some time, I have been quite
> loaded during past few days.

Sorry for replying so late, I haven't had too much free time during the
last few months.

>> For the record, here is a workqueue solution. It is much less
>> intrusive than the previous patch, but IMO less correct.
> 
> I like the previous generic approach more. It looks correct to me, but
> you marked the patch as untested when you were sending it. Is this still
> the case?

I've done some more testing and it seems to be working fine.

> Thanks a lot,
> 


-- 
Anssi Hannula
