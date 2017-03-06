From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: sony: Fix input device leak when connecting a
 DS4 twice using USB/BT
Date: Mon, 6 Mar 2017 14:21:47 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061421220.31814@cbobk.fhfr.pm>
References: <20170225001415.21361-1-roderick@gaikai.com> <20170225001415.21361-2-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753658AbdCFP5R (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Mar 2017 10:57:17 -0500
In-Reply-To: <20170225001415.21361-2-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Fri, 24 Feb 2017, Roderick Colenbrander wrote:

> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> When a user connects a DS4 twice using USB and BT, we reject the
> second device connection after the setup work. We then perform
> a cleanup, but during cleanup we are not removing the touchpad
> device. This leads to leakage of an input device, which we would
> never remove. It can likely result into a kernel oops as well
> when the touchpad evdev node is accessed and the underlaying HID
> device has been removed from the system.
> 
> Fixes: ac797b95f532 ("HID: sony: Make the DS4 touchpad a separate device")
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>

I've added -stable anotation and applied to for-4.11/upstream-fixes. 
Thanks,

-- 
Jiri Kosina
SUSE Labs

