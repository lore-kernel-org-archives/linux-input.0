From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] SOUND: kill gameport bits
Date: Wed, 20 Aug 2014 07:49:54 -0700
Message-ID: <20140820144952.GB18099@core.coreip.homeip.net>
References: <20140820024638.GA25240@rhlx01.hs-esslingen.de>
 <20140820051815.GA1109@core.coreip.homeip.net>
 <s5hwqa3hetu.wl-tiwai@suse.de>
 <20140820063130.GA11226@core.coreip.homeip.net>
 <s5htx57hc89.wl-tiwai@suse.de>
 <s5hfvgrwe59.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:50389 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbaHTOuC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Aug 2014 10:50:02 -0400
Content-Disposition: inline
In-Reply-To: <s5hfvgrwe59.wl-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andreas Mohr <andi@lisas.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>, Jiri Kosina <jkosina@suse.cz>

On Wed, Aug 20, 2014 at 02:15:30PM +0200, Takashi Iwai wrote:
> At Wed, 20 Aug 2014 09:05:58 +0200,
> Takashi Iwai wrote:
> > Well, it worked on my test machine a year ago or so.  Maybe I had a
> > good luck.
> 
> FYI, now I tested again an analog joystick on SB Live put on a Dell
> IvyBridge desktop with 3.17-rc1 x86-64 kernel, and it worked fine as
> is.
> 
> So it's not that broken.

That's probably because in your system TSCs are stable when switching CPU
frequency. Earlier systems had bunch of issues there IIRC.

Thanks.

-- 
Dmitry
