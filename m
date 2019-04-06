From: =?UTF-8?Q?=27Ond=C5=99ej_Jirman=27_via_linux=2Dsunxi?= <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Subject: Re: Re: [PATCH RESEND v4 1/4] input:
 sun4i-a10-lradc-keys: Add support for A83T
Date: Sat, 6 Apr 2019 18:57:39 +0200
Message-ID: <20190406165739.bati4leqghmehi2l@core.my.home>
References: <20190327023339.25975-1-megous@megous.com>
 <20190327023339.25975-2-megous@megous.com>
 <20190404184915.GB116898@dtor-ws>
Reply-To: megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDXLF6FR5INBBBVVUPSQKGQETRBAINY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190404184915.GB116898@dtor-ws>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello,

On Thu, Apr 04, 2019 at 11:49:15AM -0700, Dmitry Torokhov wrote:
> On Wed, Mar 27, 2019 at 03:33:36AM +0100, megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org wrote:
> > From: Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > 
> > Allwinner A83T SoC has a low res adc like the one in Allwinner A10 SoC,
> > however, the A10 SoC's vref of lradc internally is divided by 2/3 and
> > the A83T SoC's vref of lradc internally is divided by 3/4, thus add
> > a hardware variant for it to be compatible with various devices.
> > 
> > Signed-off-by: Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> 
> Applied, this and binding patch; the dts changes should go through other
> relevant trees I believe.

Thank you very much. Yes, the rest should go through the sunxi tree.

regards,
   Ondrej

> Thanks.
> 
> -- 
> Dmitry
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.
