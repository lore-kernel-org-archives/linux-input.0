From: Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH] HID: rmi: Make sure the HID device is opened on resume
Date: Mon, 24 Jul 2017 13:45:13 -0400
Message-ID: <1500918313.6243.1.camel@redhat.com>
References: <20170723011509.23651-1-lyude@redhat.com>
         <CAHp75VcZxAEr+ARw0U1nxtXR1fgWrQ1w=dhpZbm+DRiDbwajYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcZxAEr+ARw0U1nxtXR1fgWrQ1w=dhpZbm+DRiDbwajYA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, stable@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, 2017-07-23 at 12:54 +0300, Andy Shevchenko wrote:
> On Sun, Jul 23, 2017 at 4:15 AM, Lyude <lyude@redhat.com> wrote:
> 
> > So, call hid_hw_open() in rmi_post_resume() so we make sure that
> > the
> > device is alive before we try talking to it.
> > 
> > This fixes RMI device suspend/resume over HID.
> > -       int ret;
> > +       int ret = 0;
> 
> What's the point?
So that we can use the same out: label at the end of the function that
calls hid_hw_close() to return success. This being said though I just
realized that setting ret will initialize it to 0 anyway, so I guess
this can be dropped
> 
> > 
> >         if (!(data->device_flags & RMI_DEVICE))
> >                 return 0;
> > 
> > -       ret = rmi_reset_attn_mode(hdev);
> > +       /* Make sure the HID device is ready to receive events */
> > +       ret = hid_hw_open(hdev);
> >         if (ret)
> >                 return ret;
> 
> 
