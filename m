From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/3] HID: google: whiskers: more robust tablet mode
 detection
Date: Tue, 1 Oct 2019 16:16:13 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1910011616020.13160@cbobk.fhfr.pm>
References: <20190913220317.58289-1-dtor@chromium.org> <CANMq1KALGLdZmOgcrrOROU5BXjwnXWSfq6fr85jfRn079JympQ@mail.gmail.com> <CAE_wzQ9U-Lu=Uce0jFjec9JMYMhsQZoTuB+xqDpkOdC+Ufq6Ng@mail.gmail.com> <nycvar.YFH.7.76.1909231108330.1459@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1909231108330.1459@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, 23 Sep 2019, Jiri Kosina wrote:

> > > > The USB interface may get detected before the platform/EC one, so let's
> > > > note the state of the base (if we receive event) and use it to correctly
> > > > initialize the tablet mode switch state.
> > > >
> > > > Also let's start the HID interface immediately when probing, this will
> > > > ensure that we correctly process "base folded" events that may be sent
> > > > as we initialize the base. Note that this requires us to add a release()
> > >
> > > s/release/remove/ ?
> > 
> > You are right.
> 
> I'll fix that up when I am applying it (once 5.4 merge window is over).

Now applied (with the fixup made). Thanks,

-- 
Jiri Kosina
SUSE Labs
