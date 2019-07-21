From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH 2/2] Input: applespi: fix warnings detected by sparse
Date: Sun, 21 Jul 2019 00:59:18 -0700
Message-ID: <20190721075918.GC7992@innovation.ch>
References: <20190721070629.24932-1-ronald@innovation.ch>
 <20190721072427.GB607@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190721072427.GB607@penguin>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>
List-Id: linux-input@vger.kernel.org


  Hi Dmitry,

On Sun, Jul 21, 2019 at 10:24:27AM +0300, Dmitry Torokhov wrote:
> On Sun, Jul 21, 2019 at 12:06:29AM -0700, Ronald Tschalär wrote:
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> > ---
> >  drivers/input/keyboard/applespi.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> > index d5defdefbc34..00cd8dccd4f5 100644
> > --- a/drivers/input/keyboard/applespi.c
> > +++ b/drivers/input/keyboard/applespi.c
> > @@ -998,10 +998,14 @@ static inline int le16_to_int(__le16 x)
> >  static void applespi_debug_update_dimensions(struct applespi_data *applespi,
> >  					     const struct tp_finger *f)
> >  {
> > -	applespi->tp_dim_min_x = min_t(int, applespi->tp_dim_min_x, f->abs_x);
> 
> Should we also make tp_dim_* u16? Then we won't need min_t here.

abs_x/abs_y are actually signed values and sometimes negative, and
hence tp_dim_min_* are negative here. But we can just replace the
min_t/max_t with min/max, since both args are now int's.


  Cheers,

  Ronald
