From: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Sun, 13 Jul 2014 15:40:26 +0200
Message-ID: <53C28C4A.70907@nod.at>
References: <53C1F7DE.3060102@gmail.com>	<201407130545.23004.marex@denx.de> <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com> <53C25551.1050909@nod.at> <53C288F0.3070001@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53C288F0.3070001-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Chen Gang <gang.chen.5i5j-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, teg-B22kvLQNl6c@public.gmane.org, Mischa.Jonker-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liqin Chen <liqin.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am 13.07.2014 15:26, schrieb Lars-Peter Clausen:
> On 07/13/2014 11:45 AM, Richard Weinberger wrote:
>> Am 13.07.2014 11:27, schrieb Lennox Wu:
>>> As I said before, some configurations don't make sense.
>>
>> If such a configuration can be achieved using allmod/yesconfig it has to be fixed.
>> Chen's fixes seem reasonable as not all architectures support iomem.
> 
> Maybe we should stub out ioremap() and friends when COMPILE_TEST is enabled to avoid these linker errors. That's in my opinion better than turning most of the 'depends on
> COMPILE_TEST' into 'depends on COMPILE_TEST && HAS_IOMEM'. The issue comes up quite a lot and it is often overlooked when adding a driver that can be build when COMPILE_TEST is
> enabled.

And what should this stub do?
Except calling BUG()...

Thanks,
//richard
