From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: Re: [PATCH] Input: axp20x-pek: Add module alias
Date: Thu, 6 Aug 2015 10:39:21 +0800
Message-ID: <CAGb2v671UU5PteKvTMAHH5Wx4Vs7WHSQ0kRK_geF4nBENwyGsA@mail.gmail.com>
References: <1438588080-15477-1-git-send-email-wens@csie.org>
 <1438677749.8734.28.camel@tiscali.nl> <CAGb2v669M53AOjcohKt13ih1VW=eKQOKdRSbyeXDbs1RNLBm6w@mail.gmail.com>
 <20150804174601.GB37185@dtor-ws>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBB4ERROXAKGQEEX5AROY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150804174601.GB37185@dtor-ws>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 5, 2015 at 1:46 AM, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Aug 04, 2015 at 05:04:55PM +0800, Chen-Yu Tsai wrote:
>> On Tue, Aug 4, 2015 at 4:42 PM, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org> wrote:
>> > On ma, 2015-08-03 at 15:48 +0800, Chen-Yu Tsai wrote:
>> >> Add a proper module alias so the driver can be autoloaded when the
>> >> parent axp20x mfd driver registers its cells.
>> >>
>> >> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>> >
>> >> --- a/drivers/input/misc/axp20x-pek.c
>> >> +++ b/drivers/input/misc/axp20x-pek.c
>> >
>> >> +MODULE_ALIAS("platform:axp20x-pek");
>> >
>> > Should this eventually go into stable?
>> >
>> > The AXP20x Power Enable Key driver was added in v4.0, so this patch
>> > could currently be relevant for the v4.1.y tree. (In that tree a "parent
>> > MFD driver" appears to be present too.)
>>
>> (Since I forgot to add the stable tag,) I can submit it for inclusion
>> into stable after it's merged into Linus' tree.
>
> OTOH do we have many general users needing this driver as a
> automatically loaded module? If not that many then it is OK to just
> merge it in mainline and skip stable.

This is a driver for the power button found on most sunxi devices.
I assume distros would build this as a module, and most normal users
would want the power button to work out of the box.


ChenYu
