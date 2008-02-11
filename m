From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: event devices not released
Date: Mon, 11 Feb 2008 22:48:38 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802112245290.7699@twin.jikos.cz>
References: <47B043ED.3020309@slagter.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:53937 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635AbYBKVsu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2008 16:48:50 -0500
In-Reply-To: <47B043ED.3020309@slagter.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-input@vger.kernel.org

On Mon, 11 Feb 2008, Erik Slagter wrote:

> Symptoms: when I remove (unplug) a USB keyboard or mouse, the 
> corresponding event device seems to be closed but not released; when I 
> plug the device back in, it gets a new input device handle. This means 
> that after several suspend/resume cycles (in which it seems all usb 
> devices are virtually unplugged and replugged) the kernel is out of 
> event devices and complains likewise. My nice little program that 
> catches specific keystrokes also stops to get any interesting events 
> from that moment on. After reboot everything works again as expected.

Hi Erik,

this is very likely bug in HAL -- please see 
https://bugzilla.novell.com/show_bug.cgi?id=344872

-- 
Jiri Kosina

