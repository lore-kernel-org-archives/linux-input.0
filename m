From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Sleeping inside spinlock in force feedback input event code
Date: Mon, 21 Jul 2008 00:21:13 -0400
Message-ID: <20080721042112.GB14432@anvil.corenet.prv>
References: <4868e2410806151036o1a1652d8y8bf8432e3c6c0d06@mail.gmail.com> <4868e2410806151036r6d96a840v41b8ee745041db35@mail.gmail.com> <4868e2410806151105v3fec88a1qa439e2cc1423bc6a@mail.gmail.com> <48556723.2090204@gmail.com> <20080616143112.ZZRA012@mailhub.coreip.homeip.net> <485807F4.3010903@gmail.com> <20080617153423.ZZRA012@mailhub.coreip.homeip.net> <48581857.2080906@gmail.com> <4866E804.3000603@gmail.com> <4883474D.6080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:44056 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYGUEVW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2008 00:21:22 -0400
Received: by py-out-1112.google.com with SMTP id p76so926324pyb.10
        for <linux-input@vger.kernel.org>; Sun, 20 Jul 2008 21:21:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4883474D.6080602@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, James Carthew <jcarthew@gmail.com>

On Sun, Jul 20, 2008 at 05:10:21PM +0300, Anssi Hannula wrote:
> Ping? Please comment :) I'd really much like the hid-pidff driver
> to not panic when used.
> 
> For the record, here is a workqueue solution. It is much less
> intrusive than the previous patch, but IMO less correct.
> 

I was deferring the final judgement to Jiri but I like the generic
solution with com plete copy of the report best of all. I also wonder if
we could pre-allocate the buffer for the report queue so we dont need to
allocate it separately for each request.

-- 
Dmitry
