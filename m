From: "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fwd: [RFC] [PATCH] Input: ADP5588 -
 Support gpio function on unused pin
Date: Mon, 2 Aug 2010 10:37:12 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E7EC8592A@LIMKCMBX1.ad.analog.com>
References: <4c459b70.0aee8c0a.1c29.3e9e@mx.google.com>
	<4C4DADA7.9000201@gmail.com>
	<20100726173844.GC14609@core.coreip.homeip.net>
	<AANLkTi=qHUknGZdoj75Nr9gCKe-TRPMf3cgtsHejSrOc@mail.gmail.com>
	<544AC56F16B56944AEC3BD4E3D5917712E7EC2301D@LIMKCMBX1.ad.analog.com>
	<20100730170854.GA22450@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20100730170854.GA22450-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
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
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Xiaolong Chen <xiaolong.chen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Xiaolong CHEN <a21785-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, TAO HU <taohu-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org>, "Yuan.Bo YE" <yuan-bo.ye-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote on 2010-07-30:
> Hi Michael,
>
> On Fri, Jul 30, 2010 at 09:29:36AM +0100, Hennerich, Michael wrote:
>> Hi Dmitry,
>>
>> I took a look at the driver in your next tree.
>>
>> Two issues:
>> -Avoid NULL pointer dereference in adp5588_gpio_add(), set
>> clientdata before call to adp5588_gpio_add().
>
> Ah, I see. However, now that you pointed this out, I do not like that
> we pass 'struct dev ice *' and use dev_get_drvdata() when adding and
> removing gpios. I'd rather pass keypad structre there, as in the patch
> below. What do you think?
>

Hi Dmitry,

Your patch looks good.
However there is another problem.
The pin_used array must be cleared before it is used.

+ memset(pin_used, false, sizeof(pin_used));


Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
