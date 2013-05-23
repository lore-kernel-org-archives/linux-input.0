From: Daniel Nicoletti <dantti12-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Bluetooth: hidp: register HID devices async
Date: Thu, 23 May 2013 18:20:18 -0300
Message-ID: <CACo8zOfsNP+1Tx_3KcUtVwXKfJ-DEb+4G638q0g_wVGPFs3rNA@mail.gmail.com>
References: <1369307425-5993-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369307425-5993-1-git-send-email-dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This patch alone didn't work: http://privatepaste.com/a3fe0dff0a
Should I also apply the one that returns ENODATA?
>From what I can tell it wouldn't be needed as this power_supply
registration would be delayed tho I see nothing in this patch that
does that. What am I missing?

Thanks,

2013/5/23 David Herrmann <dh.herrmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
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
> ---
> Hi
>
>  @Daniel, this should fix the battery issues for Bluetooth devices. As far
> as I can see, it should have always worked for USB devices already as it uses
> the synchronous HID data-callbacks.
>
> I tested this on my machine and it works quite well. However, I cannot tell
> whether it fixes the battery issues as I have no device to test. It would be
> nice to get a "tested-by" if it works for you.
>
> If it doesn't fix the issues, I will have to look closer again, but I didn't
> find any other issues.
>
> Please note that this _must_ be applied on linux-next or linux-3.10-rc1 or
> later. It does not work with linux-3.9 or older.
>
> Cheers
> David
>
>  net/bluetooth/hidp/core.c | 56 +++++++++++++++++++++++++++++++++++++++--------
>  net/bluetooth/hidp/hidp.h |  2 ++
>  2 files changed, 49 insertions(+), 9 deletions(-)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index c756b06..e3c14de 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -848,6 +848,29 @@ static void hidp_session_dev_del(struct hidp_session *session)
>  }
>
>  /*
> + * Asynchronous device registration
> + * HID device drivers might want to perform I/O during initialization to
> + * detect device types. Therefore, call device registration in a separate
> + * worker so the HIDP thread can schedule I/O operations.
> + * Note that this must be called after the worker thread was initialized
> + * successfully. This will then add the devices and increase session state
> + * on success, otherwise it will terminate the session thread.
> + */
> +static void hidp_session_dev_work(struct work_struct *work)
> +{
> +       struct hidp_session *session = container_of(work,
> +                                                   struct hidp_session,
> +                                                   dev_init);
> +       int ret;
> +
> +       ret = hidp_session_dev_add(session);
> +       if (!ret)
> +               atomic_inc(&session->state);
> +       else
> +               hidp_session_terminate(session);
> +}
> +
> +/*
>   * Create new session object
>   * Allocate session object, initialize static fields, copy input data into the
>   * object and take a reference to all sub-objects.
> @@ -894,6 +917,7 @@ static int hidp_session_new(struct hidp_session **out, const bdaddr_t *bdaddr,
>         session->idle_to = req->idle_to;
>
>         /* device management */
> +       INIT_WORK(&session->dev_init, hidp_session_dev_work);
>         setup_timer(&session->timer, hidp_idle_timeout,
>                     (unsigned long)session);
>
> @@ -1032,8 +1056,8 @@ static void hidp_session_terminate(struct hidp_session *session)
>   * Probe HIDP session
>   * This is called from the l2cap_conn core when our l2cap_user object is bound
>   * to the hci-connection. We get the session via the \user object and can now
> - * start the session thread, register the HID/input devices and link it into
> - * the global session list.
> + * start the session thread, link it into the global session list and
> + * schedule HID/input device registration.
>   * The global session-list owns its own reference to the session object so you
>   * can drop your own reference after registering the l2cap_user object.
>   */
> @@ -1055,21 +1079,30 @@ static int hidp_session_probe(struct l2cap_conn *conn,
>                 goto out_unlock;
>         }
>
> +       if (session->input) {
> +               ret = hidp_session_dev_add(session);
> +               if (ret)
> +                       goto out_unlock;
> +       }
> +
>         ret = hidp_session_start_sync(session);
>         if (ret)
> -               goto out_unlock;
> +               goto out_del;
>
> -       ret = hidp_session_dev_add(session);
> -       if (ret)
> -               goto out_stop;
> +       /* HID device registration is async to allow I/O during probe */
> +       if (session->input)
> +               atomic_inc(&session->state);
> +       else
> +               schedule_work(&session->dev_init);
>
>         hidp_session_get(session);
>         list_add(&session->list, &hidp_session_list);
>         ret = 0;
>         goto out_unlock;
>
> -out_stop:
> -       hidp_session_terminate(session);
> +out_del:
> +       if (session->input)
> +               hidp_session_dev_del(session);
>  out_unlock:
>         up_write(&hidp_session_sem);
>         return ret;
> @@ -1099,7 +1132,12 @@ static void hidp_session_remove(struct l2cap_conn *conn,
>         down_write(&hidp_session_sem);
>
>         hidp_session_terminate(session);
> -       hidp_session_dev_del(session);
> +
> +       cancel_work_sync(&session->dev_init);
> +       if (session->input ||
> +           atomic_read(&session->state) > HIDP_SESSION_PREPARING)
> +               hidp_session_dev_del(session);
> +
>         list_del(&session->list);
>
>         up_write(&hidp_session_sem);
> diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
> index 6162ce8..9e6cc35 100644
> --- a/net/bluetooth/hidp/hidp.h
> +++ b/net/bluetooth/hidp/hidp.h
> @@ -128,6 +128,7 @@ int hidp_get_conninfo(struct hidp_conninfo *ci);
>
>  enum hidp_session_state {
>         HIDP_SESSION_IDLING,
> +       HIDP_SESSION_PREPARING,
>         HIDP_SESSION_RUNNING,
>  };
>
> @@ -156,6 +157,7 @@ struct hidp_session {
>         unsigned long idle_to;
>
>         /* device management */
> +       struct work_struct dev_init;
>         struct input_dev *input;
>         struct hid_device *hid;
>         struct timer_list timer;
> --
> 1.8.2.3
>



-- 
Daniel Nicoletti

KDE Developer - http://dantti.wordpress.com
