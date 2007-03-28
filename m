From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: appletouch quirk doesn't run at resume
Date: Wed, 28 Mar 2007 19:06:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0703281903470.29565@twin.jikos.cz>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
 <1174078066.13341.279.camel@localhost.localdomain>
 <1174087552.13341.332.camel@localhost.localdomain>  <45FBBDEA.9060708@m3y3r.de>
 <20070318004240.GO752@stusta.de>  <Pine.LNX.4.64.0703181934530.4195@jikos.suse.cz>
  <45FD8CA3.10405@m3y3r.de>  <Pine.LNX.4.64.0703182020070.4195@jikos.suse.cz>
  <4609866C.4060602@m3y3r.de>  <Pine.LNX.4.64.0703281414410.29565@twin.jikos.cz>
 <d120d5000703280624q62c26ffbs80e31d557bf3c72b@mail.gmail.com>
 <460A9D28.5050703@m3y3r.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <460A9D28.5050703@m3y3r.de>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Soeren Sonnenburg <kernel@nn7.de>, linux-input@atrey.karlin.mff.cuni.cz, Peter Osterlund <petero2@telia.com>
List-Id: linux-input@vger.kernel.org

On Wed, 28 Mar 2007, Thomas Meyer wrote:

> > I am not sure if this would help... According to the excerpt from X
> > log synaptics driver attempted to scan evdev devices and locate the
> > touchpad. However if this scan happen before udev had a chance to
> > process the event and create new /dev/input/eventX device node it will
> > fail.
> Okay. This strengthens above statement. And udev is too slow to create
> the devices, while the driver already scanned the directory.
> > I wonder if we should adjust the X driver to spin for a couple of 
> > seconds in EventAutoDevProbe if the touchpad was already seen once... 
> > Peter?

Yes, it looks like this is the root cause.

However I must admit that I don't like this behavior too much. We 
shouldn't rely on drivers individual userland to wait for a reasonable 
time before the udev settles down. This is not a nice API to provide. Will 
try to think of some solution which would have reasonable 
nastiness/functionality ratio.

-- 
Jiri Kosina
