From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Input: aiptek: fix crash on detecting device without
 endpoints
Date: Thu, 26 Nov 2015 12:35:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1511261233120.14257-100000@netrider.rowland.org>
References: <20151126163621.GA3075@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:37289 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751274AbbKZRfb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2015 12:35:31 -0500
In-Reply-To: <20151126163621.GA3075@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vladis Dronov <vdronov@redhat.com>, linux-input@vger.kernel.org

On Thu, 26 Nov 2015, Dmitry Torokhov wrote:

> Hi Vladis,
> 
> On Wed, Nov 25, 2015 at 04:58:08PM +0100, Vladis Dronov wrote:
> > The aiptek driver crashes in aiptek_probe() when a specially crafted usb device
> > without endpoints is detected. This fix adds a check that the device has proper
> > configuration expected by the driver. Also an error return value is changed to
> > more matching one in one of the error paths.
> 
> Hmm, I see quite a few drivers assuming that endpoint 0 will be present.
> I wonder if that should not be solved at USB level.

Every USB device always has endpoint 0.  If one didn't, the kernel 
wouldn't be able to initialize and enumerate it.

> Alan, does it make sense to have drivers probe interface if it does not
> have any endpoints?

Yes; in theory an interface can do everything it needs using only 
endpoint 0.  Driver shouldn't assume anything about the endpoints in 
the interfaces they problem.

Alan Stern

