From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC][PATCH] input: Introduce device information ioctl
Date: Tue, 7 Dec 2010 13:44:00 +0100
Message-ID: <201012071344.01173.arnd@arndb.de>
References: <1291706726-8835-1-git-send-email-rydberg@euromail.se> <20101207105620.GB23729@core.coreip.homeip.net> <AANLkTinmcKgUJfs+0_E6Zke6Y0+nfMU71Z8sY_-7-0iE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58630 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab0LGMoM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Dec 2010 07:44:12 -0500
In-Reply-To: <AANLkTinmcKgUJfs+0_E6Zke6Y0+nfMU71Z8sY_-7-0iE@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>

On Tuesday 07 December 2010, Kay Sievers wrote:
> On Tue, Dec 7, 2010 at 11:56, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Dec 07, 2010 at 11:48:28AM +0100, Kay Sievers wrote:
> 
> >> Please don't add new ioctls which are not extensible. The ioctl should
> >> carry the length or the version of the structure it asks for, so it
> >> can be extended in the future.
> >
> > Size of ioctl data is encoded in ioctl, it can be extended easily. For
> > examples take a look at how EVIOCGKEYCODE and EVIOCGSKEYCODE are handled
> > in recent kernels.
> 
> Oh, how does that work? With the ioctl call, userspace has to supply
> the size it expects to be returned from the kernel. How does the
> kernel otherwise know how much it is allowed to copy to the user?

The ioctl command number itself is calculated from the size of the
data that gets passed:

#define EVIOCGDEVINFO          _IOR('E', 0x09, struct input_devinfo)

If struct input_devinfo ever changes (which it can, but should not),
the command changes as well.

	Arnd
