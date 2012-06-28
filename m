From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC] input: fix weird issue of synaptics psmouse sync
 lost after resume
Date: Thu, 28 Jun 2012 16:55:18 -0700
Message-ID: <20120628235518.GA26283@core.coreip.homeip.net>
References: <CAMPhdO92C=t8hDYAkk5rG0ZNHnLiZQ2WY3SP+LGJ=VNJL=Unaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52591 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab2F1XzY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jun 2012 19:55:24 -0400
Content-Disposition: inline
In-Reply-To: <CAMPhdO92C=t8hDYAkk5rG0ZNHnLiZQ2WY3SP+LGJ=VNJL=Unaw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.miao@canonical.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Ayan George <ayan.george@canonical.com>

Hi Eric,

On Sun, Jun 24, 2012 at 11:32:38PM +0800, Eric Miao wrote:
> All,
> 
> BugLink: https://bugs.launchpad.net/bugs/717970
> 
> So in summary, the symptom is intermittent key events lost after resume
> on some machines with synaptics touchpad (seems this is synaptics _only_),
> and key events loss is due to serio port reconnect after psmouse sync lost.
> Removing psmouse and inserting it back during the suspend/resume process
> is able to work around the issue, so the difference between psmouse_connect()
> and psmouse_reconnect() is the key to the root cause of this problem.
> 
> After comparing the two different paths, synaptics driver has its own
> implementation of synaptics_reconnect(), and the missing psmouse_probe()
> seems significant, the patch below added psmouse_probe() to the reconnect
> process, and has been verified many times that the issue could not be reliably
> reproduced.
> 
> There are two PS/2 commands in psmouse_probe():
> 
>   1. PSMOUSE_CMD_GETID
>   2. PSMOUSE_CMD_RESET_DIS
> 
> The weird thing is, the PSMOUSE_CMD_GETID seems to be significant, and the
> PSMOUSE_CMD_RESET_DIS is irrelevant to this issue after trying several times.
> Now it's rather difficult to form a sane theory. So this patch is
> really for RFC.

Hmm, murky and unknown to us EC/KBC firmware code and uglies are hidden
there...

I issuing PSMOUSE_CMD_GETID bis fine if it makes some firmware happy and
we probably should do it for all protocols, not only Synaptics. Could
you please try moving calls to psmouse_reset() and psmouse_probe() in
psmouse_reconnect() up, before we check if we have protocol specific
reconnect handler?

Thanks.

-- 
Dmitry
