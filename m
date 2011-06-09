From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCHv3 3/3] Add sixaxis plugin: USB pairing and LEDs settings
Date: Thu, 09 Jun 2011 16:57:00 +0100
Message-ID: <1307635023.2669.215.camel@novo.hadess.net>
References: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
	 <1307538557-9287-4-git-send-email-ospite@studenti.unina.it>
	 <20110608175251.GC20343@piper>
	 <20110609155731.bd2c5a8b.ospite@studenti.unina.it>
	 <BANLkTimJ20rf8rJVPROLiJidq3dtVRGuig@mail.gmail.com>
	 <20110609174822.3e922722.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53811 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab1FIP5F (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jun 2011 11:57:05 -0400
In-Reply-To: <20110609174822.3e922722.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>, Vinicius Costa Gomes <vinicius.gomes@openbossa.org>, linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>

On Thu, 2011-06-09 at 17:48 +0200, Antonio Ospite wrote:
> On Thu, 9 Jun 2011 11:30:56 -0400
> Anderson Lizardo <anderson.lizardo@openbossa.org> wrote:
> 
> > Hi,
> > 
> > On Thu, Jun 9, 2011 at 9:57 AM, Antonio Ospite <ospite@studenti.unina.it> wrote:
> > > Would you mind if I keep these three stdlib ones in? I use this code
> > > verbatim in another program which does not link against Glib.
> > 
> > But you use e.g. "g_strcmp0()", GIOChannel etc. How is that?
> > 
> > Also remember sed is your friend :)
> > 
> 
> I was referring to the "low level" functions:
>   get_feature_report()
>   set_feature_report()
>   get_device_bdaddr()
>   set_master_bdaddr()
> 
> sorry, I use them in a command line tool which opens the hidraw node
> directly without udev.
> 
> But as you say, it is not a big deal to substitute them, if you like a
> more uniform style in the bluez plugin then I'll comply.

If it makes it easier for testing, split them out in a separate file,
add a header, and a test program in bluez directly.

That'll stop the 2 copies getting out of sync.

