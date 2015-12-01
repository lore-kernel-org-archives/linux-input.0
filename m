From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Input: aiptek: fix crash on detecting device without
 endpoints
Date: Tue, 1 Dec 2015 10:07:22 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1512011006490.1697-100000@iolanthe.rowland.org>
References: <191812479.29673243.1448957346445.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:48984 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752608AbbLAPHX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2015 10:07:23 -0500
In-Reply-To: <191812479.29673243.1448957346445.JavaMail.zimbra@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vladis Dronov <vdronov@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, 1 Dec 2015, Vladis Dronov wrote:

> Hello, Alan,
> 
> Thank you for the explanations and I'm sorry for my terminology
> misunderstanding, I got the point now, endpoint 0 != endpoint[0].

That's okay; it's an understandable mistake.

> > My advice is to fix aiptek's probe routine. It should check that 
> > intf->altsetting[0].desc.bNumEndpoints > 0 before trying to accessing 
> > the endpoint array.
> 
> Thank you, yes, the patch proposed does something quite alike.

You're welcome.  Glad I could help.

Alan Stern

