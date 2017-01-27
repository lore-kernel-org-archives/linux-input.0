From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 4/4] Input: leds - force the LED status after .probe()
Date: Fri, 27 Jan 2017 19:19:25 +0100
Message-ID: <20170127181925.GI13244@mail.corp.redhat.com>
References: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
 <20170127171318.2596-5-benjamin.tissoires@redhat.com>
 <20170127173400.GA9511@var.bordeaux.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbdA0S1m (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Jan 2017 13:27:42 -0500
Content-Disposition: inline
In-Reply-To: <20170127173400.GA9511@var.bordeaux.inria.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jan 27 2017 or thereabouts, Samuel Thibault wrote:
> Benjamin Tissoires, on Fri 27 Jan 2017 18:13:18 +0100, wrote:
> > Once the host has set the initial setting of the LEDs after a new
> > USB keyboard gets connected, they appear to have a SET_IDLE command
> > sent which turns of the LEDs.
> > This means that the initial step of setting the LEDs on a keyboard is
> > just reset once .probe() finishes.
> > To be sure we set the LEDs, start a delayed task to try to resend
> > them after 1 sec.
> 
> If there is such issue, I'd say fix the issue (what is sending
> SET_IDLE?) instead of working around it.
> 

That is the question. I am not even sure who sends the SET_IDLE, and if
this is something that can be controlled without disturbing too many
devices. I'll dig further then.

Cheers,
Benjamin
