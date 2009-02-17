From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: linux-next: USB mouse won't work after resume.
Date: Tue, 17 Feb 2009 16:05:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902171602510.18399-100000@iolanthe.rowland.org>
References: <200902172142.57302.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57682 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751723AbZBQVFL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2009 16:05:11 -0500
In-Reply-To: <200902172142.57302.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>, Oliver Neukum <oliver@neukum.org>
Cc: Laurent Riffard <laurent.riffard@free.fr>, linux-input@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>

On Tue, 17 Feb 2009, Oliver Neukum wrote:

> Please try the attached patch.
> 
> 	Regards
> 		Oliver

Jiri,

It seems likely that you are seeing the same problem as Laurent in your
mmotm 2009-02-10-16-35 kernel.  You should try Oliver's patch,
available here:

	http://marc.info/?l=linux-usb&m=123490330326229&w=2

Alan Stern

