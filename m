From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFT] Input: speed up suspend/shutdown for PS/2 mice and keyboards
Date: Wed, 23 Dec 2009 21:48:47 +0100
Message-ID: <200912232148.47172.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0912211528550.2643-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52366 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbZLWUsE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Dec 2009 15:48:04 -0500
In-Reply-To: <Pine.LNX.4.44L0.0912211528550.2643-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>

On Monday 21 December 2009, Alan Stern wrote:
> On Sun, 20 Dec 2009, Dmitry Torokhov wrote:
> 
> > Hi,
> > 
> > I am asking everyone to give this patch a try. It is reported to speed
> > up suspend process, however there is a risk that there are boxes out
> > there that do require full reset and I would prefer to know that sooner
> > than later.
> 
> It works okay on my machine (Intel ICH4).

Likewise on my Toshiba Portege R500 (ICH7).

[Of course, it also works on my other test boxes, the Wind has ICH7 like the
Toshiba, and the nx6325 has ATI SB400).

Rafael
