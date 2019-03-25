From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Mon, 25 Mar 2019 11:30:24 -0700
Message-ID: <CAE_wzQ9iqOW6zrR8p3knhiPwf6YcdLXd5v=F28shNZwaXVfPZQ@mail.gmail.com>
References: <20190325125704.6585-1-hotwater438@tutanota.com>
 <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com>
 <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com> <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com>
 <Laq4ykv--3-1@tutanota.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Laq4ykv--3-1@tutanota.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hotwater438@tutanota.com
Cc: Hans de Goede <hdegoede@redhat.com>, Vladislav Dalechyn <vlad.dalechin@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Kai Heng Feng <kai.heng.feng@canonical.com>, Swboyd <swboyd@chromium.org>, Bigeasy <bigeasy@linutronix.de>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 25, 2019 at 11:23 AM <hotwater438@tutanota.com> wrote:
>
> Hi.
>
> Mar 25, 2019, 6:56 PM by dtor@chromium.org:
>
> If you want to keep on using edge you need to make sure that i2c-hid
> never loses edge, as replaying of previously disabled interrupts in
> not at all reliable. So you need to "kick" the device after
> enable_irq() by initiating read from it and be ready to not get any
> data or get valid data and process accordingly.
>
> I'm sorry, but how edge can be loosed? There is device ID and quirk's which are associated with that ID, and quirk will always trigger edge irq.

If edge arrives while interrupt is disabled and replay of the
interrupt does not work when it is reenabled (and I do not think it
ever works for GPIO, you can hunt for Thomas Gleixner emails to that
effect on LKML), then ISR in the driver will never be called, so
driver will never read from the device to reset the interrupt
condition and interrupt will never be reasserted again -> edge lost.

Thanks.

-- 
Dmitry
