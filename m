From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/4] mfd: stmpe: Move ADC related defines to header of
 mfd
Date: Sat, 8 Dec 2018 20:52:41 -0800
Message-ID: <20181209045241.GF211094@dtor-ws>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181128091532.GU4272@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181128091532.GU4272@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Philippe Schenker <dev@pschenker.ch>, jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch, Philippe Schenker <philippe.schenker@toradex.com>, Max Krummenacher <max.krummenacher@toradex.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Wed, Nov 28, 2018 at 09:15:32AM +0000, Lee Jones wrote:
> On Fri, 23 Nov 2018, Philippe Schenker wrote:
> 
> > Move defines that are ADC related to the header of the overlying mfd,
> > so they can be used from multiple sub-devices.
> > 
> > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> > ---
> > 
> > Changes in v3:
> >  - None
> > 
> > Changes in v2:
> >  - This is a new added commit. Separate commit for moving the defines out of
> >    drivers/input/touchscreen/stmpe-ts.c to overlying mfd-device drivers/mfd/stmpe.c
> >  - Pre-fix defines with STMPE_
> > 
> >  drivers/input/touchscreen/stmpe-ts.c | 34 +++++++++++-----------------
> >  include/linux/mfd/stmpe.h            | 11 +++++++++
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>

The series seem to be heading towards MFD or IIO, so I assume this patch
will be merged through one of these trees.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
