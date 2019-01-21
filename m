From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/7] Input: document meanings of KEY_SCREEN and KEY_ZOOM
Date: Mon, 21 Jan 2019 11:41:32 +0100
Message-ID: <CAO-hwJLMKyOeuFyCyaR+zO9BNTDA1pXe35yRF_4nK7ZpOY=3GQ@mail.gmail.com>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com> <nycvar.YFH.7.76.1901211110190.6626@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1901211110190.6626@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 21, 2019 at 11:11 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Fri, 18 Jan 2019, Dmitry Torokhov wrote:
>
> > It is hard to say what KEY_SCREEN and KEY_ZOOM mean, but historically DVB
> > folks have used them to indicate switch to full screen mode. Later, they
> > converged on using KEY_ZOOM to switch into full screen mode and KEY)SCREEN
> > to control aspect ratio (see Documentation/media/uapi/rc/rc-tables.rst).
> >
> > Let's commit to these uses, and define:
> >
> > - KEY_FULL_SCREEN (and make KEY_ZOOM its alias)
> > - KEY_ASPECT_RATIO (and make KEY_SCREEN its alias)
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >
> > Please let me know how we want merge this. Some of patches can be applied
> > independently and I tried marking them as such, but some require new key
> > names from input.h
>
> Acked-by: Jiri Kosina <jkosina@suse.cz>

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>
> for the HID changes, and feel free to take it through your tree as a
> whole, I don't expect any major conflicts rising up from this.

Works for me too. My tests showed no issues, so that's OK from me.

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
