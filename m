From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] linux-input: bcm5974-0.57: mode-switch to atp_open,
	cleanup bug fixed
Date: Tue, 22 Jul 2008 09:52:58 -0400
Message-ID: <20080722093606.ZZRA012@mailhub.coreip.homeip.net>
References: <1216466049.6238.0.camel@alnilam> <20080720051016.GA7853@anvil.corenet.prv> <1216688142.4768.26.camel@alnilam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752357AbYGVNxT@vger.kernel.org>
Content-Description: uplicated.uplicated.
Content-Disposition: inline
In-Reply-To: <1216688142.4768.26.camel@alnilam>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, robfitz@273k.net, akpm@osdl.org, jikos@jikos.cz, vojtech@suse.cz, dmonakhov@openvz.org, johannes@sipsolutions.net, Oliver Neukum <oliver@neukum.org>, stern@rowland.harvard.edu
List-Id: linux-input@vger.kernel.org

On Tue, Jul 22, 2008 at 02:55:42AM +0200, Henrik Rydberg wrote:
> Hi Dmitri,
> 
> Regarding open/close and suspend/resume, I have difficulties finding out
> what the proper behavior is for the various error states that can
> appear. I also wonder whether open should commute with suspend or not.
> It would be of great help to get answers to the scenarios below.
>

Hm, hard questions. I will try answering them but I am also CCing Alan
Stern and Oliver Neikum who are experts in USB suspend/resume.
 
> 1. From the state (!opened,!suspended), calling open followed by
> suspend, or suspend followed by open, are we in the same state?
>

No, we are not... if we first open then suspend then device stays open
but we are not getting reports from it. Opening suspended device will
fail. Autosuspended device should be waken up by open() though.
 
> 2. From the state (!opened,!suspended), calling open fails. What state
> are we in?

Device is closed, the driver will have to make sure that it cleans up
steps that succeded while opening device (like if you submitted 1 URB
successfully and the 2nd URB failed open should kill the first one
before returning).

> 
> 3. From the state (!opened,suspended), calling open gets us to what
> state?
>

Depens on the kind of suspend - manual suspend will cause open to
fail. Autosuspend (if driver implements it) should resume the device.

> 4. From the state (!opened,suspended), calling open fails. Where are we?
>

Manual suspend will surely cause open to fail. Autosuspend - if
autoresume fails then (closed, unknown) otherwise (closed,
autosuspended - autosuspension may not kick in immediately I think).

> 5. From the state (opened,suspended), calling resume fails. What state
> are we in?
> 

Screwed up ;) From the driver POV still (opened, suspended) I think.

Thanks!

-- 
Dmitry
