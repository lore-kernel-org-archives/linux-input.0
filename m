From: David Miller <davem@davemloft.net>
Subject: Re: [RFC 7/8] HID: move apple quirks
Date: Fri, 18 Apr 2008 04:35:34 -0700 (PDT)
Message-ID: <20080418.043534.160130917.davem@davemloft.net>
References: <Pine.LNX.4.64.0804161544490.12972@jikos.suse.cz>
	<48061042.6030005@gmail.com>
	<Pine.LNX.4.64.0804181332040.12972@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42409
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750921AbYDRLff (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Apr 2008 07:35:35 -0400
In-Reply-To: <Pine.LNX.4.64.0804181332040.12972@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: jirislaby@gmail.com, linux-input@vger.kernel.org, marcel@holtmann.org, dmitry.torokhov@gmail.com, jslaby@suse.cz

From: Jiri Kosina <jkosina@suse.cz>
Date: Fri, 18 Apr 2008 13:33:06 +0200 (CEST)

> On Wed, 16 Apr 2008, Jiri Slaby wrote:
> 
> > Since the apple mightymouse is only quirked bluetooth device. Do you 
> > want me to split it to 2 patches -- an usb part and a BT part? (Or note 
> > this in changelog?)
> 
> I think this is up to Marcel -- if he is OK with me taking this through my 
> tree eventually, just Acked-by is OK. If he wants to take it through 
> his/Davem's tree, a separate patch will be probably needed.

I'm ambivalent, you guys do whatever is most convenient for you.
It doesn't have to go through my tree at all and I doubt it will
generate any merge hassles for net-2.6.26.
