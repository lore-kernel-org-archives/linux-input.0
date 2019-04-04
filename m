From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND v4 1/4] input: sun4i-a10-lradc-keys:
 Add support for A83T
Date: Thu, 4 Apr 2019 11:49:15 -0700
Message-ID: <20190404184915.GB116898@dtor-ws>
References: <20190327023339.25975-1-megous@megous.com>
 <20190327023339.25975-2-megous@megous.com>
Reply-To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDP6N55ZUYDRBL5DTHSQKGQEJQAHTOY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20190327023339.25975-2-megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 27, 2019 at 03:33:36AM +0100, megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org wrote:
> From: Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Allwinner A83T SoC has a low res adc like the one in Allwinner A10 SoC,
> however, the A10 SoC's vref of lradc internally is divided by 2/3 and
> the A83T SoC's vref of lradc internally is divided by 3/4, thus add
> a hardware variant for it to be compatible with various devices.
> 
> Signed-off-by: Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Applied, this and binding patch; the dts changes should go through other
relevant trees I believe.

Thanks.

-- 
Dmitry
