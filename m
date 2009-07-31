From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH] hid: ignore all recent SoundGraph iMON devices
Date: Fri, 31 Jul 2009 15:00:28 -0400
Message-ID: <200907311500.28866.jarod@redhat.com>
References: <200907311056.36729.jarod@redhat.com> <4A733AE2.5000508@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:45963 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752707AbZGaTD1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jul 2009 15:03:27 -0400
In-Reply-To: <4A733AE2.5000508@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Friday 31 July 2009 14:41:38 Anssi Hannula wrote:
> Jarod Wilson wrote:
> > After some inspection of the Windows iMON driver, several additional
> > device IDs were added to the lirc_imon driver. At least a few of these
> > have been seen in the wild, and require manual quirking to keep the
> > usbhid driver from binding to them. Rather than list out every single
> > device, ignore the entire device ID range, 0x0034 - 0x0046. Some of
> > these may not advertise themselves as HID devices, but no harm done to
> > such devices anyway. Does the right thing in brief testing w/my 0x0045
> > device.
> 
> I'm not sure this is a good idea. I have a 0x0038 device and I'm
> developing a proper HID driver for it. If and when I'll submit it for
> kernel inclusion, this kind of ID range blacklisting may get ugly.

Erm, there's already a full driver for it though, and its already in
the ignore list...

-- 
Jarod Wilson
jarod@redhat.com
