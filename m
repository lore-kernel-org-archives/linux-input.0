From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Mon, 14 Nov 2011 15:34:49 -0800
Message-ID: <201111141534.49608.dmitry.torokhov@gmail.com>
References: <4EC10878.20109@edigma.com> <201111141057.42310.dmitry.torokhov@gmail.com> <201111150017.17985.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36891 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753425Ab1KNXe6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 18:34:58 -0500
Received: by wyh15 with SMTP id 15so6483765wyh.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 15:34:57 -0800 (PST)
In-Reply-To: <201111150017.17985.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Nuno Santos <nsantos@edigma.com>, linux-input@vger.kernel.org

On Monday, November 14, 2011 03:17:17 PM Oliver Neukum wrote:
> Am Montag, 14. November 2011, 19:57:41 schrieb Dmitry Torokhov:
> > On Monday, November 14, 2011 10:24:17 AM Nuno Santos wrote:
> > > Hi,
> > > 
> > > I have defined my first attribute in the following way:
> > > 
> > > static ssize_t usbtouchscreen_update_sensibility(struct device *dev,
> > > 
> > >                                          struct device_attribute
> > >                                          *attr, const char *buf,
> > >                                          size_t count)
> > > 
> > > {
> > > 
> > >      printk(KERN_INFO "update sensibility called");
> > 
> > Updating sensibility is always a good thing but I gather you mean
> > sensitivity here...
> > 
> > BTW this should probably be a per-user setting and belong to the X
> > driver, not kernel driver. I.e. kernel streams all data and userspace
> > (X) decides what data do discard according to current user
> > preferences.
> 
> Hi,
> 
> before we define yet another interface specific to a driver, could we
> discuss whether this interface could be applicable to a wider range of
> devices?

... and whether it should be a kernel userspace at all...

-- 
Dmitry
