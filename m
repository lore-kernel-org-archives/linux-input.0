From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Reset ps/2 port should psmouse_probe	fail	before	retrying
Date: Wed, 21 Apr 2010 12:52:38 -0700
Message-ID: <20100421195238.GA10641@core.coreip.homeip.net>
References: <1271502098.4155.27.camel@lovely>
 <4BC9D444.3090802@canonical.com>
 <1271523195.3676.5.camel@lovely>
 <4BCC77B4.5030703@canonical.com>
 <1271723857.6652.6.camel@lovely>
 <4BCE17CC.8020804@canonical.com>
 <20100421063328.GJ4364@core.coreip.homeip.net>
 <4BCF2263.40306@canonical.com>
 <20100421171055.GB10566@core.coreip.homeip.net>
 <4BCF5453.5060703@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f185.google.com ([209.85.222.185]:53605 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab0DUUTy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 16:19:54 -0400
Received: by pzk15 with SMTP id 15so4608085pzk.15
        for <linux-input@vger.kernel.org>; Wed, 21 Apr 2010 13:19:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BCF5453.5060703@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, linux-input@vger.kernel.org, rubini@cvml.unipv.it

On Wed, Apr 21, 2010 at 03:38:59PM -0400, Peter M. Petrakis wrote:
> This issue only occurs on resume, boot is fine. It is indeed
> a multitouch.

Ok, so full multitouch is not supported at the moment but the est of teh
features shoudl work.

> It doesn't have the $OTHER_OS installed but it
> could if necessary. 

Can you enable i8042 debugging:

	echo 1 > /sys/module/i8042/parameters/debug

and do suspend/resume cycle and share dmesg? I wonder where exactly
reconnect fails.

Thanks.

-- 
Dmitry
