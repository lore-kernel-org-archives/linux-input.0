From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] input: Add new sun4i-ts driver for
 Allwinner sunxi SoC's rtp controller
Date: Thu, 26 Dec 2013 15:30:00 -0800
Message-ID: <20131226233000.GE18562@core.coreip.homeip.net>
References: <1387923847-1294-1-git-send-email-hdegoede@redhat.com>
 <1387923847-1294-2-git-send-email-hdegoede@redhat.com>
 <20131226221558.GA18562@core.coreip.homeip.net>
 <52BCAEA2.6040607@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDP6N55ZUYDRB67X6KKQKGQELCS7QYA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <52BCAEA2.6040607-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 26, 2013 at 11:33:06PM +0100, Hans de Goede wrote:
> On 12/26/2013 11:15 PM, Dmitry Torokhov wrote:
> >
> >Are we 1000% sure that the device is quiesced here and we will not get a
> >stray interrupt? Even if we are sure I'd still rather allocate input
> >device earlier, together with ts structure.
> 
> I will change things to allocate the input device earlier. What about
> registering it, when is the best time to do that?

The common pattern for the most input drivers is to register it last,
but that usually matters when you are not using managed input devices
since it helps making error unwinding path simpler. I'd still register
it last just so it looks the same as the rest of the drivers.

-- 
Dmitry
