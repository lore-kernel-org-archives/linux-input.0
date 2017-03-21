From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Accutouch: Add driver for ELO Accutouch 2216 USB
 Touchscreens
Date: Tue, 21 Mar 2017 20:48:38 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703212046570.31814@cbobk.fhfr.pm>
References: <1487081876-9743-1-git-send-email-martyn.welch@collabora.co.uk> <alpine.LSU.2.20.1703211504180.31814@cbobk.fhfr.pm> <CAKdAkRSH0pVFwmnDzurbngNK0ea51c0+Omf0sjGx7RL-ZKx92g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRSH0pVFwmnDzurbngNK0ea51c0+Omf0sjGx7RL-ZKx92g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Martyn Welch <martyn.welch@collabora.co.uk>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, 21 Mar 2017, Dmitry Torokhov wrote:

> > > This patch adds a special driver for the device to correct the
> > > capabilities reported.
> >
> > Applied to for-4.12/accutouch. Thanks,
> 
> Hmm, can't we fix usage code from udev, like we do with other keymaps?

Sorry, I messed up. I exchanged this patch with another one that fixed 
report descriptor (which we can't yet, although I have been thinking about 
ways how to do this properly).

Thanks for catching my mistake, Dmitry. Martyn, remapping HID usage codes 
is possible via udev now, as we support setkeycodes in hid-input for quite 
some time. Could you please verify that it works for you?

-- 
Jiri Kosina
SUSE Labs
