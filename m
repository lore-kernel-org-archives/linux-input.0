From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Annoying touchpad behavior
Date: Sat, 12 Nov 2011 21:22:26 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1111122117470.15550-100000@netrider.rowland.org>
References: <20111113005854.GA10446@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:57732 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751416Ab1KMCW1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Nov 2011 21:22:27 -0500
In-Reply-To: <20111113005854.GA10446@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Kurtz <djkurtz@google.com>, linux-input@vger.kernel.org

On Sat, 12 Nov 2011, Dmitry Torokhov wrote:

> > The synclient program does the job.  However there is no Synaptics 
> > section in xorg.conf.  In fact, there isn't any xorg.conf file at all; 
> > the /etc/X11/xorg.conf.d directory contains only 
> > 00-system-setup-keyboard.conf, which talks about the keyboard but not 
> > the touchpad.
> > 
> > Presumably I can add a similar file with config information for the 
> > touchpad driver, but I'm not sure what it should say.  Any suggestions?
> 
> I think the following link explains it fairly well:
> 
> 	http://fedoraproject.org/wiki/Input_device_configuration
> 
> Hope this helps.

Yes, it does ... sort of.  I set it up and it works correctly.  But the
gnome-mouse-properties trackpad settings override my changes whenever I
log in or resume from suspend!  And there's no way to customize those
settings; the TapButton* things are either all on or all off.

Oh well.  At least now I know what the problem is and what needs to be 
done.  Thanks to both of you for your help.

Alan Stern

