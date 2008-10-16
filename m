From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Need for 'nomux' has been rising lately ...
Date: Thu, 16 Oct 2008 02:10:40 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810160209260.26779@jikos.suse.cz>
References: <alpine.LNX.1.10.0810141652090.26779@jikos.suse.cz> <20081014111522.ZZRA012@mailhub.coreip.homeip.net> <48F4C1C5.9090006@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:50853 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753870AbYJPAKm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2008 20:10:42 -0400
In-Reply-To: <48F4C1C5.9090006@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Carlos Tonussi <tonussi@farmaco.ufsc.br>

On Tue, 14 Oct 2008, Alexey Starikovskiy wrote:

> There was an issue with EC interrupt storm on several Acer notebooks 
> lately, hopefully solved (bug 11549). Symptoms could be that 
> keyboard/mouse are slow, missing keys, etc. I suggest you should try the 
> patch in 11549, or acpi-test tree, and see if your problem goes away...

I am not experiencing the problems myself, but there has been quite a 
number of reports in our bugzilla about this.

I have built the kernel package with your patch included to test, and will 
let you know if their report that the problem is fixed by that kernel.

Thanks,

-- 
Jiri Kosina
SUSE Labs
