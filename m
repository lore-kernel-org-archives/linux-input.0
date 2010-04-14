From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: add HP Compaq 2710p to 'noloop' table
Date: Wed, 14 Apr 2010 14:41:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004141437340.8345@pobox.suse.cz>
References: <alpine.LNX.2.00.1004141409450.8345@pobox.suse.cz> <20100414123643.GB9242@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47511 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754448Ab0DNMlM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 08:41:12 -0400
In-Reply-To: <20100414123643.GB9242@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 14 Apr 2010, Matthew Garrett wrote:

> On Wed, Apr 14, 2010 at 02:16:25PM +0200, Jiri Kosina wrote:
> > +		.matches = {
> > +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> > +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq 2710p (#ABD)"),
> > +			DMI_MATCH(DMI_PRODUCT_VERSION, "F.14"),
> 
> Is this really the only BIOS version affected? It seems unlikely. 

I don't know, it's the only one I have received the report against (I 
don't own the machine myself).

> It's also a pretty good indication that we're doing something wrong.

What do you mean exactly?

Sending AUX_LOOP is valid thing to do with i8042 controller. If it causes 
such confusion that the controller doesn't function properly any more, 
it's clearly broken.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
