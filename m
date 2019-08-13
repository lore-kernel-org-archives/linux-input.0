From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] Fix support of a few Logitech devices broken in 5.3
Date: Tue, 13 Aug 2019 16:36:01 +0200
Message-ID: <CAO-hwJL+u+ELM4W5hwzGmh-sDO33wk1yxjqoqf9wz=qn88ROsg@mail.gmail.com>
References: <20190813133807.12384-1-benjamin.tissoires@redhat.com> <d558b953e88558b8d7955e591fefbe898edeb3ae.camel@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d558b953e88558b8d7955e591fefbe898edeb3ae.camel@archlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 13, 2019 at 4:21 PM Filipe Laíns <lains@archlinux.org> wrote:
>
> On Tue, 2019-08-13 at 15:38 +0200, Benjamin Tissoires wrote:
> > Hi Jiri,
> >
> > another set of patches to send to Linus ASAP.
> > It turns out that we have been breaking devices, so this should
> > be sent before 5.3 final.
> >
> > Cheers,
> > Benjamin
> >
> > Benjamin Tissoires (2):
> >   Revert "HID: logitech-hidpp: add USB PID for a few more supported
> >     mice"
> >   HID: logitech-hidpp: remove support for the G700 over USB
> >
> >  drivers/hid/hid-logitech-hidpp.c | 22 ----------------------
> >  1 file changed, 22 deletions(-)
> >
>
> Reviewed-by: Filipe Laíns <lains@archlinux.org>

Thanks.

I have schedule those 2 patches into for-5.3/upstream-fixes.

Cheers,
Benjamin
