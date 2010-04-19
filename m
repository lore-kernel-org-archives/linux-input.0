From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Mon, 19 Apr 2010 01:31:49 +0100
Message-ID: <1271637109.19833.3767.camel@localhost.localdomain>
References: <1271434792.2045.5.camel@localhost.localdomain>
	 <20100418194328.GA17565@core.coreip.homeip.net>
	 <1271620177.19833.3471.camel@localhost.localdomain>
	 <201004181319.25318.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:53721 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab0DSAcA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Apr 2010 20:32:00 -0400
In-Reply-To: <201004181319.25318.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Sun, 2010-04-18 at 13:19 -0700, Dmitry Torokhov wrote:
<snip>
> > > Hmm, I am curious why suspend and resume is not necessary for this
> > > device... Are you relying on the USB core to tear down and re-create the
> > > device? Then you may lose user-applied settings (like changed keymap).
> > 
> > How could I test that?
> 
> Change the keymap (with keyfuzz or something similar), suspend. resume and see 
> if the mapping persisted.

Tried using udev's keymap tool on it, but the default get function
doesn't give me any output.

Am I supposed to implement get/setkeycode myself for this to work, or
should the default input functions work? If the latter, is there
anything missing in the driver for me to call to enable that?

Trying to set a keycode says that the "EVIOCSKEYCODE" ioctl returns
EINVAL.

Cheers

