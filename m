From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: debug: fix the ring buffer implementation
Date: Tue, 29 Jan 2019 10:33:22 +0100
Message-ID: <CAO-hwJK_WoimsUMR19GR_qEUCk0ZMaKGham3DSJ5SDqtc8oCzw@mail.gmail.com>
References: <20190126170722.8035-1-vdronov@redhat.com> <CAO-hwJJGux_5bQJmXgLrcj+v=n3n8hvqXfqPEu60aghYNJSfzw@mail.gmail.com>
 <20190128111818.GA22143@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190128111818.GA22143@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>, Vladis Dronov <vdronov@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Vlad,

On Mon, Jan 28, 2019 at 12:18 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 01/28, Benjamin Tissoires wrote:
> >
> > Oleg, can you provide some feedback before I push this?
>
> Looks good to me, feel free to add
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>
> > > +               set_current_state(TASK_RUNNING);
>
> I still think that
>
>                     __set_current_state(TASK_RUNNING);
>
> will look a bit better, but this is really minor.

Would you mind sending a v3 with this change? I'll apply it ASAP.

Cheers,
Benjamin
