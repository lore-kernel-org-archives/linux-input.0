From: "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3] input/misc: new ADXL345/346
	driver
Date: Fri, 25 Jun 2010 14:59:24 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E66DFEF69@LIMKCMBX1.ad.analog.com>
References: <1255517680-30733-1-git-send-email-vapier@gentoo.org>
	<1256028039-15044-1-git-send-email-vapier@gentoo.org>
	<20100625071425.GA631@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20100625071425.GA631-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, Chris Verges <chrisv-TDbMi1wZJFNf2ZY+IB7+a9BPR1lH4CV8@public.gmane.org>, Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote on 2010-06-25:
> Hi Mike, Michael,
>
> On Tue, Oct 20, 2009 at 04:40:39AM -0400, Mike Frysinger wrote:
>> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>
>> This is a driver for the ADXL345/346 Three-Axis Digital Accelerometers.
>>
>
> As I mentioned in one of the threads I decided to pull 3-axis
> acceleromenetrs into input and I am finally getting around to apply
> the patch... However I messed a bit with it so I was wondering if
> someone could give it a short spin to see if I broke it or not.
>
> Thanks!
>

Hi Dmitry,

Thanks for merging this driver.
I gave it a quick spin. And there is one issue.
There is a code path that is taken with the mutex held,
which is also trying to acquire the mutex.

Take a look at

adxl34x_input_close() -> __adxl34x_disable()
or
adxl34x_disable() -> __adxl34x_disable()

I think __adxl34x_disable() should not acquire the mutex!

Besides that the driver seems to work fine.

We have some local enhancements for this driver which hasn't been submitted yet.

Mike,

Can you please send Dmitry the patches?

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
