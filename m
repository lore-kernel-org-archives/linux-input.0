From: Jan Bessai <jan.bessai@tu-dortmund.de>
Subject: Re: T440s Synaptics clickpad: lost sync / KBC bad data
Date: Fri, 17 Jan 2014 16:24:57 +0100
Message-ID: <52D94B49.9090600@tu-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.HRZ.Uni-Dortmund.DE ([129.217.128.51]:54662 "EHLO
	unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbaAQQ2o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 11:28:44 -0500
Received: from [192.168.1.2] (p57A18F05.dip0.t-ipconnect.de [87.161.143.5])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.14.7/8.14.7) with ESMTP id s0HFOJZK009469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 16:24:25 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

I'm having the same issue with a Lenovo T440p. The "lost sync" messages
occur if packets sent by the touchpad don't respect the bitmasks
specified in [1]. Adding some more debug output to the driver reveals,
that packages are garbled in a fairly random pattern, so just using the
less enforcing "SYN_NEWABS_RELAXED" bitmask
(drivers/input/mouse/synaptics.c:1165 , in accordance to manual section
6.1 last bullet point) does not help. Neither does cutting the packet
rate in halve or deactivating all wireless devices (=> not an
interference problem). As far as I can see, sleep flags are never set by
the driver, thus no luck with that either.
Interestingly my BIOS offers a switch to deactivate the touchpad and
just use the trackpoint. This however doesn't work either. As soon as I
trigger some (especially multi touch) activity, the touchpad comes back
and causes trouble. I believe the switch triggers pass-through mode
described in manual [1] section 5.3 and:

> A spontaneous reset of the TouchPad, due to internal sanity checks,
> ESD, or some other problem, will take the device out of transparent
> Pass-Through mode

Disabling the touchpad caused trouble for the Windows driver [2], too:
> <16.3.15.2>
> - (New) Fixed an issue where touchpad was still enabled after having
>   been disabled by BIOS.

I was able to reproduce the bug in the Windows 8 Professional installer,
the Debian 7.1 installer, the live CD version of the Ubuntu 14.04
(Trusty Tahr) daily build (14.01.2014, kernel 3.13.x) and my installed
Gentoo system (kernel 3.12.7). I'm not sure, but I think the touchpad
was acting a bit jumpy (but no where as bad) in the pre-installed
version of Windows 7 Professional as well.

For now I'm using the Bios switch to disable the touchpad in combination
with the psmouse module parameter "proto=exps". This allows me to just
use the trackpoint with a primitive ps2 mouse driver and leave the
touchpad disabled (at least if I'm careful enough not to accidentally
rest my palm on it). Being not careful enough however still causes it to
wake up and to inject timeout and bad parity errors, triggering the
cursor to jump around, click aimlessly and finally to hang. As soon as I
can afford to be without the laptop for a few days, I'll ask Lenovo to
replace the touchpad. I don't want to lose my warranty, otherwise I'd
open the notebook [3] and check if perhaps the cables are not in place
or broken. I'll also report back here, if there is anything new.

Greetings,
 Jan

[1]: Synaptics PS/2 TouchPad Interfacing Guide.
http://www.synaptics.com/sites/default/files/511-000275-01_RevB.pdf
[2]: Synaptics ThinkPad UltraNav Driver.
http://download.lenovo.com/ibmdl/pub/pc/pccbbs/mobiles/gggx45ww.txt
[3]: Video training for Lenovo T440p servicing.
http://lenovoservicetraining.com/content/CourseWarePublic/22088/player.html
