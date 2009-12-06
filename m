From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alps] Timing patch, revised again :-)
Date: Sun, 6 Dec 2009 12:09:57 -0800
Message-ID: <20091206200957.GA18820@core.coreip.homeip.net>
References: <1259513695.32495.171.camel@sardelle.necksus.de> <20091204084902.GB22570@core.coreip.homeip.net> <1259963240.27307.213.camel@sardelle.necksus.de> <200912041549.48949.dmitry.torokhov@gmail.com> <1260129237.21632.7.camel@sardelle.necksus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:38696 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbZLFUJz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Dec 2009 15:09:55 -0500
Received: by ywh36 with SMTP id 36so3694573ywh.15
        for <linux-input@vger.kernel.org>; Sun, 06 Dec 2009 12:10:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1260129237.21632.7.camel@sardelle.necksus.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Cc: Linux Input ML <linux-input@vger.kernel.org>

On Sun, Dec 06, 2009 at 08:53:57PM +0100, Sebastian Kapfer wrote:
> > 
> > Ah, ok, so when we report all 3 buttons pressed we mistaken it as interleaved 
> > packet again... Insteado f waiting till 9th byte can't we just forcefully
> > exit inetrleaved mode (once we processed the bare packet) by doing:
> > 
> >      psmouse->packet[3] &= 0xf7;
> 
> Hmm I guess we could do something like this, but IMHO it makes the code
> needlessly arcane.  What would be the point?  Save 3 bytes of buffer?
> Deliver the mouse movement a microsecond earlier?

No, this allows us validate the data bytes as tehy come in and probably
detect desync right away and resync earlier.

-- 
Dmitry
