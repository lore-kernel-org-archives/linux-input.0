From: "James T. Dickson" <james.dickson@jtdata.net>
Subject: Re: [PATCH] Input: introduce 'notimeout' blacklist for Dell Vostro
 V13 (was Re: Synaptics touchpad on Dell Vostro V13)
Date: Thu, 6 Jan 2011 08:57:49 -0600 (CST)
Message-ID: <8583070.26.1294325869588.JavaMail.root@butch.jtdata.net>
References: <alpine.LNX.2.00.1101061131460.26685@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 99-32-96-5.uvs.tulsok.sbcglobal.net ([99.32.96.5]:51914 "EHLO
	butch.jtdata.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab1AFO5x (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Jan 2011 09:57:53 -0500
In-Reply-To: <alpine.LNX.2.00.1101061131460.26685@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Correct .. Suspend worked fine when the touchpad was a generic mouse.

However, this appears a symptom of the synaptics driver. I was able to overcome it with this script from  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/59867 . 

Placing it in /etc/pm/sleeps.d/ .

#!/bin/sh
#
# Reload the AT keyboard interface.

case "$1" in
        hibernate|suspend)
                rmmod psmouse
                ;;
        thaw|resume)
                modprobe psmouse
                ;;
        *)
                ;;
esac


Also, the inability to shutdown seems to have fixed itself, it is a non issue. 

----- Original Message -----
From: "Jiri Kosina" <jkosina@suse.cz>
To: "James T. Dickson" <james.dickson@jtdata.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Sent: Thursday, January 6, 2011 4:32:22 AM
Subject: Re: [PATCH] Input: introduce 'notimeout' blacklist for Dell Vostro V13 (was Re: Synaptics touchpad on Dell Vostro V13)

On Wed, 5 Jan 2011, James T. Dickson wrote:

> I have applied this patch and can report that it has fixed the problem Ubuntu 10.10. 

Thanks a lot for reporting back.

> However, the mouse freezes when a coming out of suspend and the system 
> will not shutdown.

And that doesn't happen with the touchpad being only in PS/2 mode, right?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
