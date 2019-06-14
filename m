From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: mask out extra flags in event_type
Date: Fri, 14 Jun 2019 11:55:33 -0700
Message-ID: <20190614185533.GA142889@dtor-ws>
References: <20190614065438.142867-1-phoenixshen@chromium.org>
 <CAPR809sASD=MrQkJULVBgc_iqiPKE2xr8eUR0d4qymQkLUYRaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPR809sASD=MrQkJULVBgc_iqiPKE2xr8eUR0d4qymQkLUYRaw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enrico Granata <egranata@google.com>
Cc: Ting Shen <phoenixshen@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Pi-Hsun Shih <pihsun@chromium.org>, Enrico Granata <egranata@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Heiko Stuebner <heiko@sntech.de>, Guenter Roeck <groeck@chromium.org>, Brian Norris <briannorris@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, Colin Ian King <colin.king@canonical.com>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 14, 2019 at 11:27:03AM -0700, Enrico Granata wrote:
> On Thu, Jun 13, 2019 at 11:54 PM Ting Shen <phoenixshen@chromium.org> wrote:
> >
> > http://crosreview.com/1341159 added a EC_MKBP_HAS_MORE_EVENTS flag to
> > the event_type field, the receiver side should mask out this extra bit when
> > processing the event.
> >
> > Signed-off-by: Ting Shen <phoenixshen@chromium.org>
> 
> Reviewed-by: Enrico Granata <egranata@google.com>

EC_MKBP_EVENT_TYPE_MASK is not in Linus' tree. It would be better to
merge this path through whatever tree that is bringing in that
definition.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
