From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v2 3/3] Add sixaxis plugin: USB pairing and LEDs settings
Date: Fri, 03 Jun 2011 16:25:59 +0100
Message-ID: <1307114762.2669.125.camel@novo.hadess.net>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
	 <1298628292-8842-4-git-send-email-ospite@studenti.unina.it>
	 <1304644488.16101.28.camel@novo.hadess.net>
	 <20110507011412.ba0ad1e9.ospite@studenti.unina.it>
	 <1304787442.2427.11.camel@novo.hadess.net>
	 <20110603135904.096660bc.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110603135904.096660bc.ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Paris <jim-XrPbb/hENzg@public.gmane.org>, Ranulf Doswell <ralf-fD3LYpizeBGsTnJN9+BGXg@public.gmane.org>, "Pascal A . Brisset" <pascal44973-dXI0m6hRz7k@public.gmane.org>, Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>, Filipe Lopes <falktx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Mikko Virkkila <virkkila-/1wQRMveznE@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 2011-06-03 at 13:59 +0200, Antonio Ospite wrote:
> On Sat, 07 May 2011 17:57:07 +0100
> Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org> wrote:
> 
> > On Sat, 2011-05-07 at 01:14 +0200, Antonio Ospite wrote:
> > > On Fri, 06 May 2011 02:14:38 +0100
> > > Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org> wrote:
> > > 
> > > > On Fri, 2011-02-25 at 11:04 +0100, Antonio Ospite wrote:
> > > > > +                       [AC_LANG_PROGRAM([[
> > > > > +                               #include <sys/ioctl.h>
> > > > > +                               #include <linux/hidraw.h>
> > > > > +                               #if ! (defined(HIDIOCSFEATURE) &&
> > > > > defined(HIDIOCGFEATURE))
> > > > > +                               #error "HIDIOCSFEATURE and
> > > > > HIDIOCGFEATURE are required (linux-libc-dev >= 2.6.3x)"
> > > > > +                               #endif
> > > > > +                               ]], 
> > > > 
> > > > The only part of the patch I have a problem with is this one.
> > > > 
> > > > I'd rather the code had:
> > > > #ifndef HIDIOCSFEATURE
> > > > #define HIDIOCSFEATURE bleh
> > > > #endif
> > > > 
> [...]
> > Again, it's not compiling against older kernels. but compiling against
> > older kernel headers, which is a wildly different thing.
> > 
> > I'd like the plugin to be enabled, even if building with older kernel
> > headers, as those have no relation to the capabilities of the running
> > kernel.
> > 
> > It would also make the whole thing easier to test (just install a newer
> > kernel with the patches merged in, and voila, working sisaxis pairing).
> > 
> 
> Bastien, I'd fulfill your request on the lines of the following
> WIP patch, the intent is to make the plugin compile unconditionally
> still mentioning the soft dependency on 2.6.39-rc1.
> I could have set HAVE_HIDIOCxFEATURE in acinclude.m4 and checked for
> that in sixaxis.c in place of the explicit ifdefs, what is the common
> practice about that?
> 
> I still have to take care of the runtime check when running on older
> kernels.
> 
> Regards,
>    Antonio
> 
> diff --git a/acinclude.m4 b/acinclude.m4
> index 901bb4d..e3e0fdd 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -167,12 +167,12 @@ AC_DEFUN([AC_PATH_SIXAXIS], [
>  			)],[
>  				ac_cv_have_HIDIOCxFEATURE=yes
>  			],[
> -				ac_cv_have_HIDIOCxFEATURE="no, get linux-libc-dev >= 2.6.39-rc1"
> +				ac_cv_have_HIDIOCxFEATURE="no, emulating linux-libc-dev >= 2.6.39-rc1"
>  			]
>  		)]
>  	)
>  
> -	if ( test "${udev_found}" = "yes" && test "${ac_cv_have_HIDIOCxFEATURE}" = "yes" ); then
> +	if ( test "${udev_found}" = "yes" ); then
>  		sixaxis_plugin_deps_found=yes
>  	fi
>  ])

Just remove the macro check from acinclude.m4 altogether. It's not
needed, you already have the necessary checks in the plugin itself.

> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index 49aad25..fc12878 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -58,6 +58,16 @@
>  #include "storage.h"
>  #include "sdp_lib.h"
>  
> +/* Fallback definitions to compile with older headers */
> +#ifndef HIDIOCGFEATURE
> +#define HIDIOCGFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x07, len)
> +#endif
> +
> +#ifndef HIDIOCSFEATURE
> +#define HIDIOCSFEATURE(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x06, len)
> +#endif

Looks fine to me.

Cheers
