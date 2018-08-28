From: Harry Cutts <hcutts@chromium.org>
Subject: Re: [PATCH 1/3] Add the `REL_WHEEL_HI_RES` event code
Date: Tue, 28 Aug 2018 10:49:32 -0700
Message-ID: <CA+jURcua9vc_L0AJG5cDuPYY=LH3TcHB+QA_J1+74b97QXXkFw@mail.gmail.com>
References: <20180823183057.247630-1-hcutts@chromium.org> <20180823183057.247630-2-hcutts@chromium.org>
 <20180823185722.GA24777@bombadil.infradead.org> <20180823190124.GB53155@dtor-ws>
 <nycvar.YFH.7.76.1808281101500.25787@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1808281101500.25787@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: dmitry.torokhov@gmail.com, willy@infradead.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiri.kosina@suse.cz, benjamin.tissoires@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net
List-Id: linux-input@vger.kernel.org

Benjamin says he prefers micrometres, and I think I do to now that I
think about it (sticking with SI seems like a good idea), so I'll
update it in a V2.

Harry Cutts
Chrome OS Touch/Input team
Harry Cutts
Chrome OS Touch/Input team


On Tue, 28 Aug 2018 at 02:02, Jiri Kosina <jikos@kernel.org> wrote:
>
> On Thu, 23 Aug 2018, Dmitry Torokhov wrote:
>
> > > > +  - If a vertical scroll wheel supports high-resolution scrolling, this code
> > > > +    will be emitted in addition to REL_WHEEL. The value is the (approximate)
> > > > +    distance travelled by the user's finger, in 256ths of a millimeter.
> > >
> > > Is it too late to change this to an actual unit like micrometres?
> >
> > No love for imperial roots? Sure, micrometers would work too I think.
>
> I don't really care strongly :) Is either of you going to update the
> patch? Otherwise I'll just apply as-is.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
