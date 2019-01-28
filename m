From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2] HID: debug: fix the ring buffer implementation
Date: Mon, 28 Jan 2019 12:18:19 +0100
Message-ID: <20190128111818.GA22143@redhat.com>
References: <20190126170722.8035-1-vdronov@redhat.com>
 <CAO-hwJJGux_5bQJmXgLrcj+v=n3n8hvqXfqPEu60aghYNJSfzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJJGux_5bQJmXgLrcj+v=n3n8hvqXfqPEu60aghYNJSfzw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Vladis Dronov <vdronov@redhat.com>, Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 01/28, Benjamin Tissoires wrote:
>
> Oleg, can you provide some feedback before I push this?

Looks good to me, feel free to add

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

> > +               set_current_state(TASK_RUNNING);

I still think that

		    __set_current_state(TASK_RUNNING);

will look a bit better, but this is really minor.

Oleg.
