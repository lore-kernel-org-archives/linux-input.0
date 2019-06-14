From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: mask out extra flags in event_type
Date: Fri, 14 Jun 2019 12:19:02 -0700
Message-ID: <20190614191902.GA150432@dtor-ws>
References: <20190614065438.142867-1-phoenixshen@chromium.org>
 <CAPR809sASD=MrQkJULVBgc_iqiPKE2xr8eUR0d4qymQkLUYRaw@mail.gmail.com>
 <20190614185533.GA142889@dtor-ws>
 <20190614190957.GA243443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190614190957.GA243443@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benson Leung <bleung@google.com>
Cc: Enrico Granata <egranata@google.com>, Ting Shen <phoenixshen@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Pi-Hsun Shih <pihsun@chromium.org>, Enrico Granata <egranata@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Heiko Stuebner <heiko@sntech.de>, Guenter Roeck <groeck@chromium.org>, Brian Norris <briannorris@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, gwendal@chromium.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 14, 2019 at 12:09:57PM -0700, Benson Leung wrote:
> Hi Dmitry,
> 
> On Fri, Jun 14, 2019 at 11:55:33AM -0700, Dmitry Torokhov wrote:
> > On Fri, Jun 14, 2019 at 11:27:03AM -0700, Enrico Granata wrote:
> > > On Thu, Jun 13, 2019 at 11:54 PM Ting Shen <phoenixshen@chromium.org> wrote:
> > > >
> > > > http://crosreview.com/1341159 added a EC_MKBP_HAS_MORE_EVENTS flag to
> > > > the event_type field, the receiver side should mask out this extra bit when
> > > > processing the event.
> > > >
> > > > Signed-off-by: Ting Shen <phoenixshen@chromium.org>
> > > 
> > > Reviewed-by: Enrico Granata <egranata@google.com>
> > 
> > EC_MKBP_EVENT_TYPE_MASK is not in Linus' tree. It would be better to
> > merge this path through whatever tree that is bringing in that
> > definition.
> > 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Yup, this looks like it's coming in through Lee's MFD tree, a series from
> Gwendal to update cros_ec_commands.h.
> 
> 784dd15c930f mfd: cros_ec: Fix event processing API
> 
> That commit is in the immutable branch for v5.3 here:
>  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-cros-v5.3
> 
> I'd recommend the chrome-platform tree since we'll be pulling in that IB too
> for some other refactoring Enric is working on.

Yeah, I'm fine with this going through chrome-platform.

Thanks.

-- 
Dmitry
