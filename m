From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: Accutouch: Add driver for ELO Accutouch 2216 USB Touchscreens
Date: Tue, 21 Mar 2017 12:45:38 -0700
Message-ID: <CAKdAkRSH0pVFwmnDzurbngNK0ea51c0+Omf0sjGx7RL-ZKx92g@mail.gmail.com>
References: <1487081876-9743-1-git-send-email-martyn.welch@collabora.co.uk> <alpine.LSU.2.20.1703211504180.31814@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.20.1703211504180.31814@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Martyn Welch <martyn.welch@collabora.co.uk>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Mar 21, 2017 at 7:04 AM, Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 14 Feb 2017, Martyn Welch wrote:
>
> > The Accutouch 2216 is reporting BTN_LEFT/BTN_MOUSE rather than BTM_TOUCH
> > in it's capabilities, which is what user space expects a touchscreen
> > device to report. This is causing udev to consider the device to be a
> > "VMware's USB mouse" rather than as a touchscreen, which results in a
> > mouse cursor being displayed in Weston.
> >
> > This patch adds a special driver for the device to correct the
> > capabilities reported.
>
> Applied to for-4.12/accutouch. Thanks,

Hmm, can't we fix usage code from udev, like we do with other keymaps?
Kernel memory is quite precious.

Thanks.

-- 
Dmitry
