From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: AM335x touchscreen issues
Date: Wed, 27 May 2015 09:36:35 +0530
Message-ID: <556542CB.80106@ti.com>
References: <20150526181157.GA8009@deathray> <20150526183713.GU26599@saruman.tx.rr.com> <20150526205310.GA2104@deathray> <8F29D6B095ED194EA1980491A5E029710C89C445@DFLE08.ent.ti.com> <20150526212851.GA12224@deathray> <8F29D6B095ED194EA1980491A5E029710C89C4E0@DFLE08.ent.ti.com> <912A29987EAE174BA6CF187D7CDFA9CE270A8C43@DLEE08.ent.ti.com> <20150526215049.GC12224@deathray> <8F29D6B095ED194EA1980491A5E029710C89C70D@DFLE08.ent.ti.com> <20150526230649.GB24948@deathray>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150526230649.GB24948@deathray>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, "Cooper Jr., Franklin" <fcooper-l0cyMroinI0@public.gmane.org>
Cc: "Griffis, Brad" <bgriffis-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "GWilson-+8BKOH/0X5NWk0Htik3J/w@public.gmane.org" <GWilson-+8BKOH/0X5NWk0Htik3J/w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Michael,

On Wednesday 27 May 2015 04:36 AM, Michael Welling wrote:
> On Tue, May 26, 2015 at 10:31:32PM +0000, Cooper Jr., Franklin wrote:
>>

[snip]

> 
> Perhaps there is coupling between the LCD lines and the ADC lines?

On Beaglebone Black with BB-View 4.3" Cape from Farnell, the LCD lines
and TSCADC lines are placed close to one another, hence the analog
signals are affected by digital LCD signals, leading to above issue.

This was reported when I submitted the patches in question. Please see
http://thread.gmane.org/gmane.linux.kernel.iio/14710/focus=121321
http://thread.gmane.org/gmane.linux.kernel.iio/14710/focus=15242

I did document this in my cover letter. Please see
http://thread.gmane.org/gmane.linux.kernel.iio/15583

I think its the same issue that you are facing.

Regards
Vignesh
