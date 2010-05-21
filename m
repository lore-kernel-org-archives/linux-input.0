From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev3)
Date: Fri, 21 May 2010 18:36:03 +0200
Message-ID: <4BF6B673.1080507@euromail.se>
References: <1274457354-5570-1-git-send-email-rydberg@euromail.se>	 <1274457354-5570-2-git-send-email-rydberg@euromail.se> <AANLkTikBWzgRmso0oQNXcTxeExdKZORXYbIwK9CcMl85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:49020 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758248Ab0EUQkt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 May 2010 12:40:49 -0400
In-Reply-To: <AANLkTikBWzgRmso0oQNXcTxeExdKZORXYbIwK9CcMl85@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>

Ping Cheng wrote:
> Hi Henrik,
> 
> Thank you for your quick turnaround. Two minor comments in line.
> 
> Ping

Thanks for those, yes, both mistakes. Dmitry, in case you find these last
versions acceptable, perhaps one could change them manually:

1. Patch description: s/SYN_MT_SLOT/ABS_SLOT/
2. Test: s/hardware of computed/hardware or computed/

Thanks,
Henrik

