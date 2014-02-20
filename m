From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID_REQ_GET_REPORT and report not filled during hid_pidff_init
Date: Thu, 20 Feb 2014 16:14:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402201613030.1192@pobox.suse.cz>
References: <CAMvWtwT_J7rL1yFXZ3PyK1EEmmd=z3CgRUtQcgG+Yeh1tcWNrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55344 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391AbaBTPOh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 10:14:37 -0500
In-Reply-To: <CAMvWtwT_J7rL1yFXZ3PyK1EEmmd=z3CgRUtQcgG+Yeh1tcWNrg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lauri Peltonen <lauri.peltonen@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 27 Jan 2014, Lauri Peltonen wrote:

> I'm making some enhancements to hid/usbhid/hid-pidff.c to support more
> force feedback devices, but I've encountered some weird behaviour. I'm
> not sure whether it's a bug or something else.
> 
> My changes depend on knowing some device information (like memory) in
> the initialization phase, and luckily hid-pidff reads the info from
> PID_POOL report in hid_pidff_init -> pidff_reset. [1] and [2]
> 
> However, I noticed that the report struct never gets filled (all
> zeros), even though with usbmon I can see the ctrl message out and the
> report coming in with correct data (300 bytes of memory etc). I
> managed to locate the line which causes the report to be dropped in
> hid/hid-core.c , in hid_input_repor(..)t checking for
> driver_input_lock. [3] Commenting out the following lines "fixes" the
> issue, and the struct gets filled correctly. Anyways, I think that is
> not a real solution.
> 
> if (down_trylock(&hid->driver_input_lock))
>  return -EBUSY;
> 
> Now, I wonder if there is a reason why the locking fails? Is the
> driver locked during the initialization and hid_hw_request(...
> HID_REQ_GET_REPORT) cannot be used? 

Hi Lauri,

yes, that is the case. For the reasoning, and quite some more background 
explanation of how this whole thing works, please read changelog of commit 
4ea5454203d ("HID: Fix race condition between driver core and ll-driver"). 

Hopefully that should clarify your questions. If not, just ask :)

-- 
Jiri Kosina
SUSE Labs
