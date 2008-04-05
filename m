From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend
Date: Sat, 5 Apr 2008 10:13:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804051012110.5030-100000@netrider.rowland.org>
References: <200804051000.26661.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:2971 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751896AbYDEONU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Apr 2008 10:13:20 -0400
In-Reply-To: <200804051000.26661.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Stefan Schweizer <genstef@gentoo.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Sat, 5 Apr 2008, Oliver Neukum wrote:

> Am Samstag, 5. April 2008 00:40:35 schrieb Stefan Schweizer:
> > On Fri, Apr 4, 2008 at 1:36 PM, Oliver Neukum <oliver@neukum.org> wrote:
> > > Am Freitag, 4. April 2008 11:20:51 schrieb Stefan Schweizer:
> > >
> > > > Yeah, I tested it with the combined patch. How can I test if
> > >  > autosuspend works? Seems to work fine so far but does not write in my
> > >  > logfile. No problems found when testing.
> > >
> > >  Please compile your kernel with CONFIG_PM_DEBUG and follow the
> > >  instructions in Documentation/usb. You should see something in the log.

Note that CONFIG_PM_DEBUG has nothing to do with autosuspend.  You 
shouldn't expect to see anything unless you set CONFIG_USB_DEBUG.

> > there is still no information in dmesg when I use the device. Do I
> > need more debugging maybe?
> 
> Ok, please locate the directory for your touchpad in sysfs and post all
> files in the power subdirectory.

Alan Stern

