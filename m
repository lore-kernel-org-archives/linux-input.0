From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH 0/7] mfd: AXP20x: Add support for AXP202
 and AXP209
Date: Wed, 5 Mar 2014 21:46:38 +0100
Message-ID: <CAOQ7t2bx1u73kxQVa3AeQ-hZ9nP3GSukEdXk-jRNwbT0vUH4+A@mail.gmail.com>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
	<53121151.9050804@redhat.com>
	<CAOQ7t2ae35E-eiQW4DFspdTe3H7AWGzRpw4B_1t27p0OSkX_Uw@mail.gmail.com>
	<53123507.6020607@redhat.com>
	<531782DF.6090209@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDWJTUUC5UCBBV4232MAKGQEE2T5HZY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <531782DF.6090209-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 5, 2014 at 9:02 PM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
> So I've added your patches to my sunxi-devel tree and they work as advertised :)

Thank you for keeping the tree updated :)

> I've also added dt support for the axp209 to the cubietruck dts file, to avoid
> things becoming a copy and paste fest I've introduced a new axp209.dtsi file,
> as well as did some fixes to the existing sun?i-a*.dtsi files, see my tree here:
> https://github.com/jwrdegoede/linux-sunxi/commits/sunxi-devel

That was also my idea (creating a new axp20x.dtsi) but it has been
turned down by Maxime and Lee

> If you agree this is a good idea feel free to steal it all for the next
> revision of your patch-set :)

I will do for sure, thanks

> Note that I've still left some copy-paste parts inside the per board dts files,
> specifically things which may differ per board, ie we know already that A10
> boards will have a different interrupt parent for the interrupt.

Yep, no prob.

> Thanks for your work on this!

Thank you!

-- 
Carlo Caione
