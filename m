From: Jiri Kosina <jkosina@suse.cz>
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
Date: Fri, 29 Jan 2010 14:53:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001291448510.356@pobox.suse.cz>
References: <1263833399.20565.2905.camel@localhost.localdomain>  <1263886149.5591.166.camel@localhost.localdomain>  <1263897015.20565.3988.camel@localhost.localdomain>  <FE57175CCE23E5419899C1B0CFA26FAD101B5E591A@EXMBXSD.dm.solekai.com>
 <1264037759.1735.5008.camel@localhost.localdomain>  <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C0F@EXMBXSD.dm.solekai.com>  <1264719198.29532.3149.camel@localhost.localdomain>  <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C1E@EXMBXSD.dm.solekai.com>
 <alpine.LRH.2.00.1001291039350.15694@twin.jikos.cz> <1264772713.29532.4943.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56233 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547Ab0A2NxG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Jan 2010 08:53:06 -0500
In-Reply-To: <1264772713.29532.4943.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: "Gunn, Brian" <bgunn@solekai.com>, Marcel Holtmann <marcel@holtmann.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, BlueZ development <linux-bluetooth@vger.kernel.org>, Ping <pinglinux@gmail.com>

On Fri, 29 Jan 2010, Bastien Nocera wrote:

> > Having separate methods for feature and output reports should be 
> > sufficient and general enough, right?
> 
> Most likely, yes. Feature is enough for the 2 devices I provided patches
> for. Could you please comment on what you'd like the implementation of
> this to look like? 

I think that we should probably introduce flag parameter into 
hid_output_raw_report(), which would indicate whether OUTPUT or FEATURE 
report should be sent.

This makes sense both for Bluetooth and HID.

I will send out patches later today for you guys to test (and for Marcel 
to Ack the Bluetooth part).

> This simple bug fix is turning into a lot more to-and-fro than I would 
> have anticipated.

It's nice example of evolution, isn't it? :)

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
