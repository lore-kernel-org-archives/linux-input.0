From: Vladis Dronov <vdronov@redhat.com>
Subject: Re: [PATCH] HID: debug: fix the ring buffer implementation
Date: Sat, 26 Jan 2019 10:44:41 -0500 (EST)
Message-ID: <1280032330.67094297.1548517481057.JavaMail.zimbra@redhat.com>
References: <20190125095744.3813-1-vdronov@redhat.com> <20190125130113.GA18589@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125130113.GA18589@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello, Oleg, all,

Thanks much, Oleg, these are really valuable additions:

> suspicious ;) if you add a comment the patch will be even better.

Great, will do.

> perhaps it make sense to move this check into the "if (kfifo_is_empty())"
> block.

Indeed, otherwise it kinda breaks the execution logic.

> is kfifo_is_empty() == T really possible here?

It looks like it is not. Reads are guarded by read_mutex and the only other
code which touches hid_debug_fifo is writer.

I will post v2 here soon. Lets see if it is ready for inclusion.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security | Senior Software Engineer
