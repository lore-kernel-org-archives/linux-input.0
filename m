From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: handle faulty Elo touch device
Date: Wed, 22 May 2019 12:38:10 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1905221237590.1962@cbobk.fhfr.pm>
References: <20190521133831.4436-1-benjamin.tissoires@redhat.com> <CAO-hwJJfRXEdwMq9KLXDMs37CnHXnVhUzD5sbd5uzoeVdKQdvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJJfRXEdwMq9KLXDMs37CnHXnVhUzD5sbd5uzoeVdKQdvw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Breno Leitao <leitao@debian.org>
List-Id: linux-input@vger.kernel.org

On Tue, 21 May 2019, Benjamin Tissoires wrote:

> On Tue, May 21, 2019 at 3:38 PM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > Since kernel v5.0, one single win8 touchscreen device failed.
> > And it turns out this is because it reports 2 InRange usage per touch.
> >
> > It's a first, and I *really* wonder how this was allowed by Microsoft in
> > the first place. But IIRC, Breno told me this happened *after* a firmware
> > upgrade...
> >
> > Anyway, better be safe for those crappy devices, and make sure we have
> > a full slot before jumping to the next.
> > This won't prevent all crappy devices to fail here, but at least we will
> > have a safeguard as long as the contact ID and the X and Y coordinates
> > are placed in the report after the grabage.
> 
> Grmbl, I forgot:
> Fixes: 01eaac7e5713 ("HID: multitouch: remove one copy of values")
> CC: stable@vger.kernel.org # v5.0+

I've now pushed this to for-5.2/fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
