From: Oliver Neukum <oneukum@suse.de>
Subject: Re: Interacting with a input kernel driver from user space
Date: Tue, 15 Nov 2011 00:17:17 +0100
Message-ID: <201111150017.17985.oneukum@suse.de>
References: <4EC10878.20109@edigma.com> <4EC15CD1.2010409@edigma.com> <201111141057.42310.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40416 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756545Ab1KNXQU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 18:16:20 -0500
In-Reply-To: <201111141057.42310.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nuno Santos <nsantos@edigma.com>, linux-input@vger.kernel.org

Am Montag, 14. November 2011, 19:57:41 schrieb Dmitry Torokhov:
> On Monday, November 14, 2011 10:24:17 AM Nuno Santos wrote:
> > Hi,
> > 
> > I have defined my first attribute in the following way:
> > 
> > static ssize_t usbtouchscreen_update_sensibility(struct device *dev,
> >                                          struct device_attribute *attr,
> >                                          const char *buf, size_t count)
> > {
> > 
> >      printk(KERN_INFO "update sensibility called");
> > 
> 
> Updating sensibility is always a good thing but I gather you mean 
> sensitivity here...
> 
> BTW this should probably be a per-user setting and belong to the X driver, 
> not kernel driver. I.e. kernel streams all data and userspace (X) decides 
> what data do discard according to current user preferences.

Hi,

before we define yet another interface specific to a driver, could we discuss
whether this interface could be applicable to a wider range of devices?

	Regards
		Oliver
