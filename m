From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] HID: debug: fix the ring buffer implementation
Date: Fri, 25 Jan 2019 14:01:14 +0100
Message-ID: <20190125130113.GA18589@redhat.com>
References: <20190125095744.3813-1-vdronov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125095744.3813-1-vdronov@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladis Dronov <vdronov@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/25, Vladis Dronov wrote:
>
> Ring buffer implementation in hid_debug_event() and hid_debug_events_read()
> is strange allowing lost or corrupted data. After commit 717adfdaf147
> ("HID: debug: check length before copy_to_user()") it is possible to enter
> an infinite loop in hid_debug_events_read() by providing 0 as count, this
> locks up a system. Fix this by rewriting the ring buffer implementation
> with kfifo and simplify the code.
>
> This fixes CVE-2019-3819.

To me this looks like a good cleanup even if we forget about bugfix. Cosmetic
nits, feel free to ignore...

> +	if (kfifo_is_empty(&list->hid_debug_fifo)) {
> +		add_wait_queue(&list->hdev->debug_wait, &wait);
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		while (kfifo_is_empty(&list->hid_debug_fifo)) {
> +			if (file->f_flags & O_NONBLOCK) {
> +				ret = -EAGAIN;
> +				break;
> +			}
> +
> +			if (signal_pending(current)) {
> +				ret = -ERESTARTSYS;
> +				break;
> +			}
> +
> +			if (!list->hdev || !list->hdev->debug) {
> +				ret = -EIO;
> +				set_current_state(TASK_RUNNING);
> +				goto out;

Can't resist... Yes, this is what the current code does. But you know that it looks
suspicious ;) if you add a comment the patch will be even better.

> +			}
> +
> +			/* allow O_NONBLOCK from other threads */
> +			mutex_unlock(&list->read_mutex);
> +			schedule();
> +			mutex_lock(&list->read_mutex);
> +			set_current_state(TASK_INTERRUPTIBLE);
> +		}
> +
> +		set_current_state(TASK_RUNNING);

you can use __set_current_state() here, mb() is not needed.

> +		remove_wait_queue(&list->hdev->debug_wait, &wait);
> +	}
> +
> +	if (ret)
> +		goto out;
> +

perhaps it make sense to move this check into the "if (kfifo_is_empty())" block.

> +	if (kfifo_is_empty(&list->hid_debug_fifo))
> +		goto out;

is kfifo_is_empty() == T really possible here?

Oleg.
