From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [NEEDS TEST][PATCH] elantech: discard the first 2 positions
 reports for some firmwares
Date: Sun, 30 May 2010 16:29:39 -0400
Message-ID: <1275251379.6666.76.camel@mini>
References: <4C02B18D.3050003@tudelft.nl> <1275243114.6666.50.camel@mini>
	 <20100530182600.GA32416@core.coreip.homeip.net>
	 <1275245732.6666.70.camel@mini>
	 <20100530201221.GA6069@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:40001 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730Ab0E3U3p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 May 2010 16:29:45 -0400
In-Reply-To: <20100530201221.GA6069@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, 2010-05-30 at 13:12 -0700, Dmitry Torokhov wrote:
> The patch was not taken from the commit, Eric just referenced the commit
> as he gathered some additional information. The code in that commit is
> so hideous that it would never get close to mainline as is.

Ahhh, yes. Now I see what's going on. I thought, based on Eric's initial
email and his related email describing the protocol, the commit was
something we had in our tree that hadn't made it upstream. I should have
read through everything a second time more thoroughly :).

Thanks,

-- Chase

