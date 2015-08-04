From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH] Input: axp20x-pek: Add module alias
Date: Tue, 4 Aug 2015 10:46:01 -0700
Message-ID: <20150804174601.GB37185@dtor-ws>
References: <1438588080-15477-1-git-send-email-wens@csie.org>
 <1438677749.8734.28.camel@tiscali.nl>
 <CAGb2v669M53AOjcohKt13ih1VW=eKQOKdRSbyeXDbs1RNLBm6w@mail.gmail.com>
Reply-To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDP6N55ZUYDRBXHUQOXAKGQECPRCKGA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v669M53AOjcohKt13ih1VW=eKQOKdRSbyeXDbs1RNLBm6w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 04, 2015 at 05:04:55PM +0800, Chen-Yu Tsai wrote:
> On Tue, Aug 4, 2015 at 4:42 PM, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org> wrote:
> > On ma, 2015-08-03 at 15:48 +0800, Chen-Yu Tsai wrote:
> >> Add a proper module alias so the driver can be autoloaded when the
> >> parent axp20x mfd driver registers its cells.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> >
> >> --- a/drivers/input/misc/axp20x-pek.c
> >> +++ b/drivers/input/misc/axp20x-pek.c
> >
> >> +MODULE_ALIAS("platform:axp20x-pek");
> >
> > Should this eventually go into stable?
> >
> > The AXP20x Power Enable Key driver was added in v4.0, so this patch
> > could currently be relevant for the v4.1.y tree. (In that tree a "parent
> > MFD driver" appears to be present too.)
> 
> (Since I forgot to add the stable tag,) I can submit it for inclusion
> into stable after it's merged into Linus' tree.

OTOH do we have many general users needing this driver as a
automatically loaded module? If not that many then it is OK to just
merge it in mainline and skip stable.

Thanks.

-- 
Dmitry
