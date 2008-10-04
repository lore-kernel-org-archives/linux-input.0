From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Sleeping inside spinlock in force feedback input event code
Date: Sat, 4 Oct 2008 13:59:30 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810041358370.26779@jikos.suse.cz>
References: <4868e2410806150157o5b290bf7kaccdeb2faf5057d6@mail.gmail.com> <485540A6.1050306@gmail.com> <4868e2410806151023j67ceea16pe1c5ad8ab9a8e122@mail.gmail.com> <4855507E.4030201@gmail.com> <4868e2410806151036o1a1652d8y8bf8432e3c6c0d06@mail.gmail.com>
 <4868e2410806151036r6d96a840v41b8ee745041db35@mail.gmail.com> <4868e2410806151105v3fec88a1qa439e2cc1423bc6a@mail.gmail.com> <48556723.2090204@gmail.com> <20080616143112.ZZRA012@mailhub.coreip.homeip.net> <485807F4.3010903@gmail.com>
 <20080617153423.ZZRA012@mailhub.coreip.homeip.net> <48581857.2080906@gmail.com> <4866E804.3000603@gmail.com> <4883474D.6080602@gmail.com> <alpine.LNX.1.10.0807251122210.16387@jikos.suse.cz> <48D55D8B.4070904@gmail.com> <alpine.LNX.1.10.0810031123000.26779@jikos.suse.cz>
 <48E7546F.3010307@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:42216 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751711AbYJDL7b (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 4 Oct 2008 07:59:31 -0400
In-Reply-To: <48E7546F.3010307@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, James Carthew <jcarthew@gmail.com>

On Sat, 4 Oct 2008, Anssi Hannula wrote:

> > There were some changes in the code due to hidbus getting finally 
> > merged, but it should be rather trivial to solve.
> AFAICS no changes are needed, it applies to hid.git#mm fine.

You are right.

Could you please send me the patch with the changelog? I will then merge 
it for 2.6.28.

Thanks,

-- 
Jiri Kosina
SUSE Labs
