From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: psmouse_disconnect lockdep splat
Date: Sat, 28 Oct 2017 20:52:20 +0300
Message-ID: <20171028175220.n63ynowcb3wscirp@node.shutemov.name>
References: <20160828093011.GA2842@nazgul.tnic>
 <20161018120921.dhlo76bbkdhlm7ey@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161018120921.dhlo76bbkdhlm7ey@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, lkml <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Chris Diamand <chris@diamand.org>, Richard Pospesel <pospeselr@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, Oct 18, 2016 at 02:09:22PM +0200, Borislav Petkov wrote:
> Adding more people to CC.
> 
> I still see this after 4.8 is out.
> 
> So PeterZ suggested something like this:
> 
> ---
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index fb4b185dea96..9112c3cecad7 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -1420,14 +1420,16 @@ static void psmouse_disconnect(struct serio *serio)
>  		psmouse_deactivate(parent);
>  	}
>  
> -	if (psmouse->disconnect)
> -		psmouse->disconnect(psmouse);
> -
>  	if (parent && parent->pt_deactivate)
>  		parent->pt_deactivate(parent);
>  
>  	psmouse_set_state(psmouse, PSMOUSE_IGNORE);
>  
> +	mutex_unlock(&psmouse_mutex);
> +	if (psmouse->disconnect)
> +		psmouse->disconnect(psmouse);
> +	mutex_lock(&psmouse_mutex);
> +
>  	serio_close(serio);
>  	serio_set_drvdata(serio, NULL);
>  	input_unregister_device(psmouse->dev);
> ---
> 
> to fix the lock inversion but that might have the other problem of
> being racy by maybe ->reconnect() accessing psmouse->private in
> trackpoint_sync() outside of the psmouse_mutex lock and that won't be
> nice.
> 
> But someone more knowledgeable with this code should take a look and
> suggest a proper fix.
> 
> Thanks!
> 
> (Leaving in the rest for reference).

The splat still persists on up-to-date kernel. See below. That's for
current -tip tree, but it's in mainline too.

Nobody cares?

======================================================
WARNING: possible circular locking dependency detected
4.14.0-rc6-00555-g34aa400565bc #151 Tainted: G        W      
------------------------------------------------------
kworker/0:1/38 is trying to acquire lock:
 (kn->count#188){++++}, at: [<ffffffff8233ba60>] kernfs_remove_by_name_ns+0x40/0x80

but task is already holding lock:
 (psmouse_mutex){+.+.}, at: [<ffffffff82805b37>] psmouse_disconnect+0x67/0x160

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (psmouse_mutex){+.+.}:
       __mutex_lock+0x85/0x960
       psmouse_attr_set_helper+0x2d/0x140
       kernfs_fop_write+0x112/0x1a0
       __vfs_write+0x23/0x130
       vfs_write+0xc9/0x1d0
       SyS_write+0x45/0xb0
       entry_SYSCALL_64_fastpath+0x23/0xc2

-> #0 (kn->count#188){++++}:
       lock_acquire+0xc1/0x220
       __kernfs_remove+0x248/0x2b0
       kernfs_remove_by_name_ns+0x40/0x80
       remove_files.isra.0+0x31/0x70
       sysfs_remove_group+0x3d/0x80
       trackpoint_disconnect+0x20/0x40
       psmouse_disconnect+0x94/0x160
       serio_disconnect_driver+0x2d/0x40
       serio_driver_remove+0x11/0x20
       device_release_driver_internal+0x160/0x230
       serio_reconnect_subtree+0x4a/0xa0
       serio_handle_event+0x1af/0x270
       process_one_work+0x1ea/0x680
       worker_thread+0x4d/0x3e0
       kthread+0x145/0x180
       ret_from_fork+0x2a/0x40

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(psmouse_mutex);
                               lock(kn->count#188);
                               lock(psmouse_mutex);
  lock(kn->count#188);

 *** DEADLOCK ***

6 locks held by kworker/0:1/38:
 #0:  ((wq_completion)"events_long"){+.+.}, at: [<ffffffff8210f705>] process_one_work+0x165/0x680
 #1:  (serio_event_work){+.+.}, at: [<ffffffff8210f705>] process_one_work+0x165/0x680
 #2:  (serio_mutex){+.+.}, at: [<ffffffff827f3271>] serio_handle_event+0x21/0x270
 #3:  (&dev->mutex){....}, at: [<ffffffff826e9ac4>] device_release_driver_internal+0x34/0x230
 #4:  (&serio->drv_mutex){+.+.}, at: [<ffffffff827f235b>] serio_disconnect_driver+0x1b/0x40
 #5:  (psmouse_mutex){+.+.}, at: [<ffffffff82805b37>] psmouse_disconnect+0x67/0x160

stack backtrace:
CPU: 0 PID: 38 Comm: kworker/0:1 Tainted: G        W       4.14.0-rc6-00555-g34aa400565bc #151
Hardware name: LENOVO 20FXS09D2P/20FXS09D2P, BIOS R07ET71W (2.11 ) 09/26/2016
Workqueue: events_long serio_handle_event
Call Trace:
 dump_stack+0x7c/0xbe
 print_circular_bug+0x202/0x380
 ? lockdep_init_map_crosslock+0x20/0x20
 check_prev_add+0x43f/0x7b0
 ? __lock_acquire+0x133d/0x1550
 __lock_acquire+0x133d/0x1550
 lock_acquire+0xc1/0x220
 ? kernfs_remove_by_name_ns+0x40/0x80
 __kernfs_remove+0x248/0x2b0
 ? kernfs_remove_by_name_ns+0x40/0x80
 ? kernfs_name_hash+0x12/0x80
 ? kernfs_find_ns+0x89/0x100
 kernfs_remove_by_name_ns+0x40/0x80
 remove_files.isra.0+0x31/0x70
 sysfs_remove_group+0x3d/0x80
 trackpoint_disconnect+0x20/0x40
 psmouse_disconnect+0x94/0x160
 serio_disconnect_driver+0x2d/0x40
 serio_driver_remove+0x11/0x20
 device_release_driver_internal+0x160/0x230
 serio_reconnect_subtree+0x4a/0xa0
 serio_handle_event+0x1af/0x270
 process_one_work+0x1ea/0x680
 worker_thread+0x4d/0x3e0
 kthread+0x145/0x180
 ? process_one_work+0x680/0x680
 ? kthread_create_on_node+0x40/0x40
 ret_from_fork+0x2a/0x40
-- 
 Kirill A. Shutemov
