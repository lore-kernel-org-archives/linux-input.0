From: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not  work	anymore
Date: Sun, 25 Oct 2009 12:47:03 +0100
Message-ID: <4AE43AB7.8070601@tremplin-utc.net>
References: <20091015215944.GA9845@core.coreip.homeip.net> <4ADF6237.9070004@tremplin-utc.net> <200910211320.16339.dmitry.torokhov@gmail.com> <4AE0840C.8070801@tremplin-utc.net> <20091022162202.GA18031@core.coreip.homeip.net> <4AE09AFF.805@tremplin-utc.net> <20091022181915.GB18031@core.coreip.homeip.net> <4AE16489.4030008@tremplin-utc.net> <20091023085824.GA7199@core.coreip.homeip.net> <4AE17586.9020009@tremplin-utc.net> <20091023163113.GA7707@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:7334 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbZJYLqx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Oct 2009 07:46:53 -0400
In-Reply-To: <20091023163113.GA7707@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Op 23-10-09 18:31, Dmitry Torokhov schreef:
>
> Right, your init scripts/UDEV/HAL whatever adjust keymap to match your
> laptop.
:
> Now, all depends on when this adjustment happens... In your case it
> looks like X server starts before the keymap is adjusted, so on first
> resume the keymaps are different and it disables the device.
Ok, now I catch it. It's actually my own written script, which is 
executed at init a bit after X starts. It does a couple of 
"setkeycodes". So now the scenario is very clear: X starts, init script 
do setkeycodes, resume/suspend, X detect a difference in keymaps and 
disable the device.

BTW, I haven't really found info about this: what does setkeycodes? It 
does not work on a specific device, but still it changes keymap of some 
specific devices. Does it change only the current devices which have 
keys? Whenever a new input device appears, all the setkeycodes should be 
re-executed?

Eric

