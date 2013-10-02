From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: New USB core API to change interval and max packet size
Date: Wed, 2 Oct 2013 15:37:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1310021536110.1293-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1310021449240.1293-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53882 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754410Ab3JBThP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Oct 2013 15:37:15 -0400
In-Reply-To: <Pine.LNX.4.44L0.1310021449240.1293-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Xenia Ragiadakou <burzalodowa@gmail.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org

On Wed, 2 Oct 2013, Alan Stern wrote:

> > Ok, so it sounds like we want to keep the changes the endpoints across
> > alt setting changes.
> 
> No, just the opposite.  That was the point I was trying to make.  Any
> changes to ep5 in altsetting 0 (for example) will have no effect on ep1
----------------------------------------------------------------------^^^

Typo: this should have been ep5 as well.

> in altsetting 1, because the two altsettings reference the endpoint by
> two separate usb_host_endpoint structures.

Alan Stern

