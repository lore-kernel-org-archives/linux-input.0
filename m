From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: keyboards and evdev printing multiple keys
Date: Thu, 1 Jan 2009 13:49:27 +1000
Message-ID: <20090101034926.GA7361@dingo>
References: <494FF40A.7000806@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ipx-119-252-190-80.ipxserver.de ([80.190.252.119]:60197 "EHLO
	ipx10616.ipxserver.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754751AbZAAEeH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Dec 2008 23:34:07 -0500
Content-Disposition: inline
In-Reply-To: <494FF40A.7000806@ameritech.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "F. Heitkamp" <heitkamp@ameritech.net>
Cc: linux-input@vger.kernel.org

On Mon, Dec 22, 2008 at 03:09:46PM -0500, F. Heitkamp wrote:
> I am not sure this is a bug.
> I have a Apple keyboard connected to a IOGear USB KVM.
> I have installed evdev and the Xorg 1.5.3 server.
> When I use any X apps the keyboard repeats three for one in.  i.e.  
> typing one 'L' puts three of them in the input.
> I noticed when looking at /proc/bus/input/devices there are three  
> instanced of the keyboard.

This is an X server problem and the most likely cause is that your server is
picking up a keyboard device (driver "kbd") and the evdev device separately.
If you are using evdev 2.1, then you will get two events for each key press.

Another reason may be that you have an evdev device configured in the
xorg.conf, and the same device gets added again through HAL.

Cheers,
  Peter
