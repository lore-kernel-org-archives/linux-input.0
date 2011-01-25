From: Andy Ross <andy.ross-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH 0/4] Pegatron Lucid tablet
	acceleromter/ALS
Date: Tue, 25 Jan 2011 09:09:04 -0800
Message-ID: <4D3F03B0.7030607@windriver.com>
References: <1295909288-32650-1-git-send-email-andy.ross@windriver.com>	<20110124230557.GA18135@core.coreip.homeip.net>	<AANLkTinfDR4TnVC-NPLsCqXsc9nP+UWXKO6n8jXuT7ne@mail.gmail.com>	<4D3EFDCF.7090308@windriver.com>
	<AANLkTi=tQpQ0wjfx-Cp13FuCSQNFitN7XAg-V2AcSHz2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTi=tQpQ0wjfx-Cp13FuCSQNFitN7XAg-V2AcSHz2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 01/25/2011 09:05 AM, Corentin Chary wrote:
> If everybody is ok with that, I think you should move the code back
> into asus-laptop.c. But if you do so, don't forget to modify the help
> text of ASUS_LAPTOP section in KConfig.

OK.  Though one gotcha I just realized is that this will pull input-polldev
into the dependency list for asus-laptop, which may not be desirable just to
support one obscure device.  But again, that's a small module...

I have a few things to take care of this morning first, hopefully I'll have
another version ready in a few hours.

Andy

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
