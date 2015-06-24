From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH] input: axp20x-pek: Fix reporting button
 state as inverted
Date: Wed, 24 Jun 2015 14:28:57 -0700
Message-ID: <20150624212857.GA3636@dtor-ws>
References: <1434278541-21355-1-git-send-email-hdegoede@redhat.com>
 <20150622213051.GD2350@dtor-ws>
 <CAGb2v64AF3bnd-QBRCszjD7MSfCnGSvfu3wUT2W+7fNTE76d5g@mail.gmail.com>
 <CAOQ7t2a+3TvmgfW3dJBc=FJk1sXNAT+SE6qP0r5ovG7yx9fYHA@mail.gmail.com>
Reply-To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDP6N55ZUYDRBHWCVSWAKGQEK2OPASY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOQ7t2a+3TvmgfW3dJBc=FJk1sXNAT+SE6qP0r5ovG7yx9fYHA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jun 24, 2015 at 11:19:39AM +0200, Carlo Caione wrote:
> On Wed, Jun 24, 2015 at 3:42 AM, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> > On Tue, Jun 23, 2015 at 5:30 AM, Dmitry Torokhov
> > <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> On Sun, Jun 14, 2015 at 12:42:21PM +0200, Hans de Goede wrote:
> >>> Currently we are reporting the button state as inverted on all boards with
> >>> an axp209 pmic, tested on a ba10-tvbox, bananapi, bananapro, cubietruck and
> >>> utoo-p66 tablet.
> >>>
> >>> The axp209 datasheet clearly states that the power button must be connected
> >>> between the PWRON key and ground. Which means that on a press we will get
> >>> a falling edge (dbf) irq not a rising one, and likewise on release we will
> >>> get a rising edge (dbr) irq, not a falling one.
> >>>
> >>> This commit swaps the check for the 2 irqs fixing the inverted reporting of
> >>> the power button state.
> >>>
> >>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>
> >> Carlo, Chen-Yu, could you please give this patch a spin and let us know
> >> if it works on your boards?
> >
> > I've not actually tested this patch on my boards, but I can confirm that
> > the original code had the state inverted, by checking /proc/interrupts
> > counters, before and after releasing the power button.
> >
> > Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> 
> Same here (I don't have the board anymore)
> 
> Acked-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>

Applied, thank you.

-- 
Dmitry
