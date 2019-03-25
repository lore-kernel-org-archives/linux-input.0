From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Mon, 25 Mar 2019 09:56:21 -0700
Message-ID: <CAE_wzQ8sYcMVYLmnctw_UQuvn0B8U2CU2dNeg-9sh85AL_CfgQ@mail.gmail.com>
References: <20190325125704.6585-1-hotwater438@tutanota.com>
 <CAE_wzQ8Aep1FOONeCUxvjBFbgKcVRWP5mUuwQnDxzfemUw-eaA@mail.gmail.com> <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a2952bc4-0ad0-c8a0-5a5b-13a279023455@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Vladislav Dalechyn <vlad.dalechin@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, kai.heng.feng@canonical.com, swboyd@chromium.org, bigeasy@linutronix.de, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, hotwater438@tutanota.com
List-Id: linux-input@vger.kernel.org

Hi Hans,

On Mon, Mar 25, 2019 at 9:38 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Dmitry,
>
> On 25-03-19 17:02, Dmitry Torokhov wrote:
> > Hi Vladislav,
> >
> > On Mon, Mar 25, 2019 at 5:57 AM Vladislav Dalechyn
> > <vlad.dalechin@gmail.com> wrote:
> >>
> >> From: Vladislav Dalechyn <hotwater438@tutanota.com>
> >>
> >> Description: The ELAN1200:04F3:303E touchpad exposes several issues, all
> >> caused by an error setting the correct IRQ_TRIGGER flag:
> >> - i2c_hid incoplete error flood in journalctl;
> >> - Five finger tap kill's module so you have to restart it;
> >> - Two finger scoll is working incorrect and sometimes even when you
> >> raised one of two finger still thinks that you are scrolling.
> >>
> >> Fix all of these with a new quirk that corrects the trigger flag
> >> announced by the ACPI tables. (edge-falling).
> >
> > I do not believe this is right solution. The driver makes liberal use
> > of disable_irq() and enable_irq() which may lead to lost edges and
> > touchpad stopping working altogether.
> >
> > Usually the "extra" report is caused by GPIO controller clearing
> > interrupt condition at the wrong time (too early), or in unsafe or
> > racy fashion. You need to look there instead of adding quirk to
> > i2c-hid.
>
> The falling-edge solution was proposed by Elan themselves.
>
> Also if you look at: https://bugzilla.redhat.com/show_bug.cgi?id=1543769
>
> And esp. the "cat /proc/interrupts" output there, then you will see
> that the interrupt seems to be stuck at low level, which according
> to the ACPI tables is its active level.

So how does it generate a new edge if it is stuck at low?

Is it bad touchpad firmware that does not deassert interrupt quickly
enough? I scrolled through the bug but I do not see if it had been
confirmed that original windows installation actually uses edge (it
may very well be using it; Elan engineers pushed us to use edge in a
few cases, but they all boiled down to an issue with pin control/GPIO
implementation).

>
> As for this being a GPIO chip driver problem, this is using standard
> Intel pinctrl stuff, which is not showing this same issue with many
> other i2c-hid touchpads.

Well, there have been plenty of issues in intel drivers, coupled with
"interesting" things done by firmware and boards.

If you want to keep on using edge you need to make sure that i2c-hid
never loses edge, as replaying of previously disabled interrupts in
not at all reliable. So you need to "kick" the device after
enable_irq() by initiating read from it and be ready to not get any
data or get valid data and process accordingly.

Thanks.

-- 
Dmitry
