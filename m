From: Alex Manoussakis <amanou@gnu.org>
Subject: Re: [PATCH] HID: elecom: rewrite report fixup for EX-G and future
 mice
Date: Mon, 11 Dec 2017 12:31:16 -0500
Message-ID: <20171211173116.GA9941@gnu.org>
References: <20171204205550.2621-1-tk@the-tk.com>
 <20171205201307.GA13831@gaia.local>
 <nycvar.YFH.7.76.1712071103120.3572@cbobk.fhfr.pm>
 <20171209172311.GA5570@gaia.local>
 <nycvar.YFH.7.76.1712111128080.3572@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eggs.gnu.org ([208.118.235.92]:33291 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbdLKRbc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Dec 2017 12:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
        (envelope-from <amanou@gnu.org>)
        id 1eORvM-00083D-G0
        for linux-input@vger.kernel.org; Mon, 11 Dec 2017 12:31:29 -0500
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1712111128080.3572@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Tomasz Kramkowski <tk@the-tk.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Yuxuan Shui <yshuiv7@gmail.com>, Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.eu>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Tomasz please add the wireless version in your next patch, a web search
shows it's called M-XT3DRBK and the USB ID is 0x00fc.

Thanks,
Alex

On Mon, Dec 11, 2017 at 11:28:37AM +0100, Jiri Kosina wrote:
> On Sat, 9 Dec 2017, Tomasz Kramkowski wrote:
> 
> > Alright, that's fine. Anything else to change before I send a v2? 
> 
> Not from my side, I think we're good to go.
> 
> > Also, would you like v2 in-reply-to the root of this thread or as its 
> > own thread?
> 
> Feel free to send it as a followup here. Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
