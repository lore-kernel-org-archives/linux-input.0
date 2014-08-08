From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/1] Input: atmel_mxt_ts - Get IRQ edge/level flags on
 DT booting
Date: Fri, 8 Aug 2014 09:21:46 -0700
Message-ID: <20140808162146.GC26820@core.coreip.homeip.net>
References: <1407397492-17475-1-git-send-email-javier.martinez@collabora.co.uk>
 <53E4D9A5.908@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53E4D9A5.908@itdev.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Stephen Warren <swarren@nvidia.com>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Tomasz Figa <tomasz.figa@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 08, 2014 at 03:07:33PM +0100, Nick Dyer wrote:
> On 07/08/14 08:44, Javier Martinez Canillas wrote:
> > The Atmel maXTouch driver assumed that the IRQ type flags will
> > always be passed using platform data but this is not true when
> > booting using Device Trees. In these setups the interrupt type
> > was ignored by the driver when requesting an IRQ.
> > 
> > This means that it will fail if a machine specified other type
> > than IRQ_TYPE_NONE. The right approach is to get the IRQ flags
> > that was parsed by OF from the "interrupt" Device Tree propery.
> > 
> > Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> I'm happy for this to go in if Dmitry will accept it. It does seem to be a
> quirk of some platforms that it is necessary, but it's only one line.

I'd rather not as it masks the deeper platform issue. There might be
other drovers also expecting platform/OF code set up interrupt triggers
and working/not working by chance.

Can we figure out why the platform in question needs this change?

Thanks.

-- 
Dmitry
