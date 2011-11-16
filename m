From: Sean Young <sean@mess.org>
Subject: Re: [PATCH] HID: Add support for pressure sensitive buttons
Date: Wed, 16 Nov 2011 10:23:59 +0000
Message-ID: <20111116102359.GA29328@pip.mess.org>
References: <1321304314-17424-1-git-send-email-sean@mess.org>
 <alpine.LNX.2.00.1111151523500.15187@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pip.mess.org ([212.110.186.137]:56218 "EHLO pip.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755394Ab1KPKYA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 05:24:00 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1111151523500.15187@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, linux-input@vger.kernel.org

On Tue, Nov 15, 2011 at 03:27:42PM +0100, Jiri Kosina wrote:
> On Mon, 14 Nov 2011, Sean Young wrote:
> 
> >  	left = left * 0xff / 0xffff;
> >  	right = (right != 0); /* on/off only */
> >  
> > +	sjoyff->report->field[0]->value[0] = 1;
> >  	sjoyff->report->field[0]->value[1] = right;
> >  	sjoyff->report->field[0]->value[2] = left;
> 
> General comment to the whole patch applicable on many other places as 
> well: it'd be nice if you could stick a short comment to the places which 
> contain magic contants mandated by the device protocol, so that anyone 
> else looking at the driver gets at least a basic idea why are individial 
> fields initialized the way they are.

The constants are found by snooping what the windows driver does. I have 
no idea why the values are what they are; in the v2 version of my patch
I've attempted to document better what the device is supposed to do. Is
that what you're after?


Sean
