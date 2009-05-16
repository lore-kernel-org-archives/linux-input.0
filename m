From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] autocentering support for Logitech Force 3D Pro
Date: Fri, 15 May 2009 17:50:12 -0700
Message-ID: <20090516005012.GA9564@dtor-d630.eng.vmware.com>
References: <bb829a0b0905081244j36d069bfre73eba5d170494b3@mail.gmail.com> <alpine.LNX.2.00.0905111705540.22712@wotan.suse.de> <bb829a0b0905110913o1a1c20hb73c7ba0f3905bd5@mail.gmail.com> <alpine.LNX.2.00.0905151607240.22712@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:48584 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755530AbZEPAu3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2009 20:50:29 -0400
Received: by pzk13 with SMTP id 13so1310976pzk.33
        for <linux-input@vger.kernel.org>; Fri, 15 May 2009 17:50:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0905151607240.22712@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?utf-8?B?0KHQtdGA0LPQtdC5INCR0LXQu9GP0YjQvtCy?= <sergey.belyashov@gmail.com>, linux-input@vger.kernel.org, Anssi Hannula <anssi.hannula@gmail.com>

On Fri, May 15, 2009 at 04:08:52PM +0200, Jiri Kosina wrote:
> On Mon, 11 May 2009, ?????? ??????? wrote:
> 
> >    Of course I agree.
> 
> I have applied the autocentering support patch for 0x286, thanks.
> 
> >    How about axes information in EVIOCGBIT(EV_FF,...)?
> 
> Anssi, Dmitry, what do you think?
> 

I'd say no... Can we guarantee that all stated FF effects would be
always applicable to every one of the ABS events types returned by
EVIOCGBIT(EV_FF,...)?

-- 
Dmitry
