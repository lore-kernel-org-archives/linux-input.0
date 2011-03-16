From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 00/17] Merging of TSC2005 driver
Date: Wed, 16 Mar 2011 17:44:23 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1103161737540.2634@esdhcp041196.research.nokia.com>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:32250 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392Ab1CPPqv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 11:46:51 -0400
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Hi,

On Wed, 16 Mar 2011, Dmitry Torokhov wrote:
> So I guess the common core for tsc2005/2007 will not materialize anytime
> soon and I should finally merge the standalone version of driver... Still
> there were a few issues with it and I would appreciate if you take a look
> at the following patches and let me know if the driver still works if
> you apply them.

Thanks, I think those are good changes. There are two bugs (about which
I already sent mails) but with those fixed it appeared to work fine
with RX-51 (Nokia N900) based on a brief sanity check. I tested with
mainline v2.6.38.

A.
