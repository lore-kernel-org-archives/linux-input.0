From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] HID: multitouch: prevent memleak with the allocated name
Date: Wed, 29 May 2013 23:12:54 +0300
Message-ID: <CAHp75VcpdQqd+evBNhwMGHvXwCoVdaXYdBqQeSDGwt25dLkpGQ@mail.gmail.com>
References: <1369817109-4277-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369817109-4277-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, May 29, 2013 at 11:45 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> mt_free_input_name() was never called during .remove():
> hid_hw_stop() removes the hid_input items in hdev->inputs, and so the
> list is therefore empty after the call. In the end, we never free the
> special names that has been allocated during .probe().
>
> Restore the original name before freeing it to avoid acessing already
> freed pointer.
>

> I just spotted this one yesterday... My guess is that this way is safe (without
> a locking mechanism to prevent accessing hi->input->name), but I'm not 100% sure.

Hi Jiri, Benjamin.

What do you think about patch I just sent?

P.S. Benjamin, I re-used your commit message, I think you have no objections.

--
With Best Regards,
Andy Shevchenko
