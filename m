From: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Subject: Re: [alps] Timing patch, revised again :-)
Date: Mon, 07 Dec 2009 01:27:49 +0100
Message-ID: <1260145669.21632.15.camel@sardelle.necksus.de>
References: <1259513695.32495.171.camel@sardelle.necksus.de>
	 <20091204084902.GB22570@core.coreip.homeip.net>
	 <1259963240.27307.213.camel@sardelle.necksus.de>
	 <200912041549.48949.dmitry.torokhov@gmail.com>
	 <1260129237.21632.7.camel@sardelle.necksus.de>
	 <20091206200957.GA18820@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:39024 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932814AbZLGA1p (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 6 Dec 2009 19:27:45 -0500
In-Reply-To: <20091206200957.GA18820@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input ML <linux-input@vger.kernel.org>

On So, 2009-12-06 at 12:09 -0800, Dmitry Torokhov wrote:
> On Sun, Dec 06, 2009 at 08:53:57PM +0100, Sebastian Kapfer wrote:
> > > 
> >[...] 
> > Hmm I guess we could do something like this, but IMHO it makes the code
> > needlessly arcane.  What would be the point?  Save 3 bytes of buffer?
> > Deliver the mouse movement a microsecond earlier?
> 
> No, this allows us validate the data bytes as tehy come in and probably
> detect desync right away and resync earlier.

Hi Dmitry,

note that the resync code is disabled anyway, and the hardware gets
reset in that case, which means losing tens of milliseconds.  (I don't
think we have desync problems left, at least for this particular hw.)

-- 
Best Regards,  | Hi! I'm a .signature virus. Copy me into
 Sebastian     | your ~/.signature to help me spread!

