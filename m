From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: hid-related 5.2-rc1 boot hang
Date: Tue, 28 May 2019 19:45:15 +0200
Message-ID: <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com> <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Hans de Goede <hdegoede@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, May 28, 2019 at 7:15 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 28 May 2019, Dave Hansen wrote:
>
> > I have a system that works fine on 5.1.  When updating to 5.2-rc1, it
> > hangs at boot waiting on an instance of systemd-udevd.  The kernel
> > backtrace (https://photos.app.goo.gl/EV8rf7FofWouvdeE8) looks like it's
> > doing an finit_module() that dives into the hid code and is waiting on a
> > request_module().
>
> Dave,
>
> thanks for the report.
>
> Just to confirm -- I guess reverting 4ceabaf79 and a025a18fe would work
> this around, right?
>

It would be also interesting to know which distribution and which
systemd version you are running (if you are on systemd).

This rings a bell as I recall  playing with
request_module/request_firmware a while ago, but Hans convinced me
that no such delay would be induced.

Cheers,
Benjamin
