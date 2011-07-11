From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC] Synchronization Issue in hid_hw_start()
Date: Mon, 11 Jul 2011 17:38:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1107111737580.5754@pobox.suse.cz>
References: <BANLkTinz5iSCCGNC-U8TVrZ7xbc4biF_jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48888 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757753Ab1GKPip (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 11:38:45 -0400
In-Reply-To: <BANLkTinz5iSCCGNC-U8TVrZ7xbc4biF_jA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Wed, 29 Jun 2011, David Herrmann wrote:

> The comment of hid_hw_start() (hid.h) mentions:
>  * Call this in probe function *after* hid_parse. This will setup HW buffers
>  * and start the device (if not deffered to device open). hid_hw_stop must be
>  * called if this was successful.
> Especially the part in brackets allows the low-level driver to start
> the device without waiting for hid_hw_open() (bluetooth hid does
> this). However, hid_hw_start() does not synchronize hid and input
> startup, but instead first starts the hid layer followed by input. If
> the HID layer reports an event before the input layer is started,
> HIDINPUT will send the event to a nonexisting input device or may even
> dereference an invalid address.
> Same thing in hid_hw_stop().
> 
> An easy fix would be adding an atomic_t "ready" variable to the
> hid_device that is set to 1 after successful setup and
> hid_input_report must ignore every input until ready is 1. However,
> this does not work for hid_hw_stop() because we can't determine
> whether there is already a thread running inside hid_input_report() or
> similar.
> 
> A more complex fix is a rwlock. hid_hw_start() locks it as writer and
> hid_input_report() and all other depending functions lock it as
> reader. We would still need something like a "ready" variable, but
> synchronization is also possible on hid_hw_stop() this way.
> 
> Another more complex fix would be an input function like
> input_stop_reports() which will prevent the input instance from
> reporting any more events but still allow us to send events to it.
> Similar input_start_reports() for startup-synchronization. So we could
> register the input layer but prevent it from sending reports. Then we
> would start up the hid layer and after that we would start input
> reports. Same thing on shutdown...

[ sorry for the delay ]

I like the rwlock idea, it seems to be the most straightforward. Have you 
already played with it and have patch(es)? Otherwise I'll start looking 
into it.

Thanks,

-- 
Jiri Kosina
SUSE Labs
