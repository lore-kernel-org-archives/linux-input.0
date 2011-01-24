From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] Pegatron Lucid tablet
	acceleromter/ALS
Date: Mon, 24 Jan 2011 15:05:57 -0800
Message-ID: <20110124230557.GA18135@core.coreip.homeip.net>
References: <1295909288-32650-1-git-send-email-andy.ross@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1295909288-32650-1-git-send-email-andy.ross-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andy Ross <andy.ross-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 24, 2011 at 02:48:04PM -0800, Andy Ross wrote:
> Resubmission and update of the Pegatron Lucid tablet accelerometer and
> ambient light sensor drivers.
> 
> Patches 1-3 are against asus-laptop, and apply in order.
> 
> Patch 4 is against input, and can be commited separately (obviously
> relies on the detection code in asus-laptop at runtime, but will build
> and load independently).
> 

I am happy with the input part but I wonder if it really needs to be
separate? If you roll it up into asus-laptop you would not need a new
platform device and then it would be what - 20 lines of code?

Corentin, what do you think?

Thanks.

-- 
Dmitry

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
