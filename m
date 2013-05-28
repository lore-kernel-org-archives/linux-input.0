From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] Bluetooth: hidp: register HID devices async
Date: Tue, 28 May 2013 10:45:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305281044210.3914@pobox.suse.cz>
References: <1369307425-5993-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369307425-5993-1-git-send-email-dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Nicoletti <dantti12-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 23 May 2013, David Herrmann wrote:

> While l2cap_user callbacks are running, the whole hci_dev is locked. Even
> if we would add more fine-grained locking to HCI core, it would still be
> called from the non-reentrant rx work-queue and thus block the event
> processing.
> 
> However, if we want to perform synchronous I/O during HID device
> registration (eg., to perform device-detection), we need the HCI core
> to be able to dispatch incoming data.
> 
> Therefore, we now move device-registration to a separate worker. The HCI
> core can continue running and we add devices asynchronously in another
> kernel thread. Device removal is synchronized and waits for the worker
> to exit before calling the usual device removal functions.
> 
> If l2cap_user->remove is called before the thread registered the devices,
> we set "terminate" to true and the thread will skip it. If
> l2cap_user->remove is called after it, we notice this as the device
> is no longer in HIDP_SESSION_PREPARING state and simply unregister the
> device as we did before.
> There is no new deadlock as we now call hidp_session_add_dev() with
> one lock less held (the HCI lock) and it cannot itself call back into
> HCI as it was called with the HCI-lock held before.
> 
> One might wonder whether this can block during device unregistration.
> But we set "terminate" to true and wake the HIDP thread up _before_
> unregistering the HID/input devices. Therefore, all pending HID I/O
> operations are canceled. All further I/O attempts will fail with ENODEV
> or EIO. So all latency we can get are few context-switches, but no
> timeouts or blocking I/O waits!
> 
> This change also prepares for a long standing HID bug. All HID devices
> that register power_supply devices need to be able to handle callbacks
> during registration (a power_supply oddity that cannot easily be fixed).
> So with this patch available, we can allow HID I/O during registration
> by calling the recently introduced hid_device_io_start/stop helpers,
> which currently are a no-op for bluetooth due to this locking.
> 
> Note that we cannot do the same for input devices. input-core doesn't
> allow us to call input_event() asynchronously to input_register_device(),
> which HID-core kindly allows (for good reasons).
> Fixing input-core to allow this isn't as easy as it sounds and is,
> beside simplifying HIDP, not really an improvement. Hence, we still
> register input devices synchronously as we did before. Only HID devices
> are registered asynchronously.
> 
> Signed-off-by: David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>

Gustavo, I think I'd like to take this patch together with the ENODATA 
change for hid-input, as they, in some sense, stick together.

If you are OK with that, could you please provide me with your Acked-by, 
and I'll take it through my tree?

Thanks.

-- 
Jiri Kosina
SUSE Labs
