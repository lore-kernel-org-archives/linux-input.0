From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] [HID] hid-sony: regression probing a SIXAXIS controller
 - wrong return value
Date: Sat, 3 Jan 2009 02:21:51 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901030220060.5377@jikos.suse.cz>
References: <495A9D82.7090500@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:48523 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758321AbZACBVz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Jan 2009 20:21:55 -0500
In-Reply-To: <495A9D82.7090500@web.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Nauber <RichardNauber@web.de>
Cc: linux-input@vger.kernel.org

On Tue, 30 Dec 2008, Richard Nauber wrote:

> This patch fixes a regression introduced in bd28ce00. It occurs when
> attaching a Sony SIXAXIS controller:
> 
> input: Sony PLAYSTATION(R)3 Controller as
> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1:1.0/input/input9
> sony 0003:054C:0268.0006: input,hiddev96,hidraw0: USB HID v1.11 Joystick
> [Sony PLAYSTATION(R)3 Controller] on usb-0000:00:1d.0-1/input0
> sony: probe of 0003:054C:0268.0006 failed with error 17
> 
> The reason for this nasty behavior is a wrong return value emitted by
> sony_set_operational().

Hi Richard,

the similar patch fixing this issue is already in my queue [1], Marcin 
beat you in reporting this :) But thanks anyway!

[1] http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=commitdiff;h=7100c4281258f185d82430d1cab698de8db4ab75

-- 
Jiri Kosina
SUSE Labs
