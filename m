From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: New Force Feedback device support - GreenAsia 0x12
Date: Thu, 11 Dec 2008 22:13:38 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0812112210060.21089@jikos.suse.cz>
References: <200811262333.45245.lukasz@lubojanski.info>  <alpine.LNX.1.10.0811281514210.19853@jikos.suse.cz>  <49303827.4050907@gmail.com>  <200811282008.41601.lukasz@lubojanski.info>  <alpine.LNX.1.10.0811292327470.19853@jikos.suse.cz>
 <92cd8c320812041235u6bf501d9ta473398bc1374aac@mail.gmail.com>  <92cd8c320812041255i1a8bb4ces9468d2821ab7c620@mail.gmail.com>  <493973BA.1010902@gmail.com>  <92cd8c320812051249m39bcd8d6mb03e15e14398f01c@mail.gmail.com>  <alpine.LNX.1.10.0812111610330.21089@jikos.suse.cz>
 <92cd8c320812111146q60a70570w227dc6a4386703dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="336216065-851327688-1229030018=:21089"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:49617 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756211AbYLKVNj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Dec 2008 16:13:39 -0500
In-Reply-To: <92cd8c320812111146q60a70570w227dc6a4386703dd@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-2?Q?=A3ukasz_Luboja=F1ski?= <lukasz@lubojanski.info>
Cc: linux-input@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--336216065-851327688-1229030018=:21089
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 11 Dec 2008, Łukasz Lubojański wrote:

> So I resend the patch with changed debug to dbg_hid, fixed report_count, 
> init & exit functions are properly marked.

I have applied your patch to my tree.

> ps. Should I still send full diff every time or only the changes between 
> my posts ?

Up to now (as the driver hasn't been merged yet), full diffs were the 
proper option. Now, as the code is merged, please send only incremental 
patches on top of it.

Thanks,

-- 
Jiri Kosina
SUSE Labs
--336216065-851327688-1229030018=:21089--
