From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Multi-Touch (MT) support - arbitration or not
Date: Thu, 11 Nov 2010 11:55:40 -0800
Message-ID: <20101111195540.GA14508@core.coreip.homeip.net>
References: <20101110050219.GB29110@barra.bne.redhat.com>
 <4CDA6D25.4070501@euromail.se>
 <20101110235355.GB4473@barra.bne.redhat.com>
 <4CDB3D6C.2000507@euromail.se>
 <20101111012251.GC2121@core.coreip.homeip.net>
 <AANLkTinYE40qN7n98Vb-Pyh5npst6JN+1LzxZaU50X_H@mail.gmail.com>
 <20101111082653.GC24415@core.coreip.homeip.net>
 <AANLkTikVZBdTTR=jb=jpW+u5sHr4zazypwOnJSoR-RXv@mail.gmail.com>
 <20101111192434.GA13163@core.coreip.homeip.net>
 <4CDC46E5.8040703@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52059 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab0KKTzu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Nov 2010 14:55:50 -0500
Received: by gwb20 with SMTP id 20so123609gwb.19
        for <linux-input@vger.kernel.org>; Thu, 11 Nov 2010 11:55:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDC46E5.8040703@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Ping Cheng <pinglinux@gmail.com>, Michal Suchanek <hramrach@centrum.cz>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>, Chris Bagwell <chris@cnpbagwell.com>, linux-input <linux-input@vger.kernel.org>

On Thu, Nov 11, 2010 at 08:41:25PM +0100, Henrik Rydberg wrote:
> >>
> 
> >> But, I think ABS_X/Y arbitration should be considered in the kernel to
> >> reduce the overhead in userland.
> > 
> > With option 1 you have natural ST arbitration - the first touch gets to
> > report (ABS_X, ABS_Y), the rest will have to report ABS_MT_* till the
> > first touch is lifted, right?
> 
> 
> Right. Perhaps this is a good time to discuss some additional helper functions
> Chris and myself are playing with right now.
> 
> /**
>  * input_mt_report_state() - report contact state
>  * @dev: input device with allocated MT slots
>  * @active: true if contact is active, false otherwise
>  *
>  * Reports an active touch via ABS_MT_TRACKING_ID. If active is
>  * true and the slot is currently inactive, a new tracking id is
>  * assigned to the slot.
>  */
> void input_mt_report_state(struct input_dev *dev, bool active);
> 
> Since all tracking-capable drivers we have seen so far have a contact id with
> the same semantics as the slot id, it makes sense to have the above function to
> remove the need for individual drivers to assign tracking ids.
> 
> With the input core (or input-mt.c) controlling the tracking id, it is easy to
> add more goodness, such as
> 
> /**
>  * input_mt_report_pointer_emulation() - common pointer emulation
>  * @dev: input device with allocated MT slots
>  *
>  * Performs legacy pointer emulation via BTN_TOUCH, etc.
>  */
> void input_mt_report_pointer_emulation(struct input_dev *dev);
> 
> Since the input device knows the MT state and what buttons and abs axes are in
> use, it can provide the right set of data to emit to emulate pointer and touch
> events. The track-oldest-contact logic can be readily implemented.
> 
> From what I can see, this would remove two complications from each MT slots
> driver, removing both code and headaches.
> 
> What do you think?
> 

input-mt.c seems like a good idea for keeping a common library of
goodies for MT drivers.

-- 
Dmitry
