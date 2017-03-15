From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH v14 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Wed, 15 Mar 2017 22:10:45 +0100 (CET)
Message-ID: <365485304.502411.1489612245583@email.1und1.de>
References: <cover.1488380468.git.ksenija.stanojevic@gmail.com>
 <b568984a536229aab4e5d704be1c1de388d4222a.1488380468.git.ksenija.stanojevic@gmail.com>
 <282870591.38324.1488399050890@email.1und1.de>
 <20170301204855.GG30349@dtor-ws> <20170314110545.54jz53xx36vsc3bo@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170314110545.54jz53xx36vsc3bo@dell>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Ksenija,

> Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> hat am 14. März 2017 um 12:05 geschrieben:
> 
> 
> On Wed, 01 Mar 2017, Dmitry Torokhov wrote:
> 
> > On Wed, Mar 01, 2017 at 09:10:50PM +0100, Stefan Wahren wrote:

...

> > > 
> > > Since touchscreen is optional it doesn't make to try to register it, notice in the touchscreen driver there is no touchscreen, give the user a confusing error and finally disable the clock.
> > > 
> > > Here are my suggestions:
> > > 
> > > 1) Use the solution from Patch V6 but with an explaining comment that touchscreen is optional
> > > 
> > > if (!lradc->touchscreen_wire)
> > > 	return 0;
> > > 
> > > 2) Return a special error from touchscreen registration so mfd knowns this result is expected.
> > > 
> > > I'm open for better solutions.
> > > 
> > > @Lee: What's your opinion?
> > 
> > I am not Lee, but given that this module already parses touchscreen
> > properties and knows whether there is touchscreen or not, #1 seems
> > simple and logical.
> 
> Sorry for the delay, I'm currently behind on my mail due to vacation
> and conferences.
> 
> +1
> 

could you please submit a V15? It would be great to get this into 4.12.

Thanks
Stefan
