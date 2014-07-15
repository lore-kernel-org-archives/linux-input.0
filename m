From: Chen Gang <gang.chen.5i5j-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Tue, 15 Jul 2014 08:34:45 +0800
Message-ID: <53C47725.8000005@gmail.com>
References: <201407130545.23004.marex@denx.de> <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com> <53C25551.1050909@nod.at> <53C288F0.3070001@metafoo.de> <53C28C4A.70907@nod.at> <53C29015.5070607@metafoo.de> <53C291C8.6050303@nod.at> <53C296C2.30304@metafoo.de> <20140713192202.GA19090@kroah.com> <53C2DF12.6040507@nod.at> <20140713201753.GA29955@kroah.com> <53C39569.9020802@nod.at> <53C3994C.1010309@metafoo.de> <53C39B66.4060500@nod.at> <5A40E1FC-CA61-4AFF-B205-4BAC175AA7AC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A40E1FC-CA61-4AFF-B205-4BAC175AA7AC-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, teg-B22kvLQNl6c@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Liqin Chen <liqin.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Mischa.Jonker-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 07/14/2014 05:22 PM, Chen Gang wrote:
>=20
> =E5=9C=A8 2014=E5=B9=B47=E6=9C=8814=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=88=
4:57=EF=BC=8CRichard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org> =E5=86=99=E9=81=93=EF=BC=
=9A
>=20
>> Am 14.07.2014 10:48, schrieb Lars-Peter Clausen:
>>> On 07/14/2014 10:31 AM, Richard Weinberger wrote:
>>>> Am 13.07.2014 22:17, schrieb Greg Kroah-Hartman:
>>>>> On Sun, Jul 13, 2014 at 09:33:38PM +0200, Richard Weinberger wrot=
e:
>>>>>> Maybe we could add COMPILE_TEST to the version string too?
>>>>>> Just to detect such kernels fast in user bug reports...
>>>>>
>>>>> What kind of bug report are you going to get?
>>>>
>>>> User manages to enable CONFIG_FOO by selecting COMPILE_TEST and
>>>> complains that it does not work. :)
>>>
>>> These drivers are typically drivers for some SoC peripheral and the=
 device will simply physically not exist on a platform that does not pr=
ovide HAS_IOMEM. This is not really any
>>> different from making the driver selectable via COMPILE_TEST for an=
y other platform. To hit the issue you'd have to instantiate a device d=
river instance for a device that
>>> physically does not exist. This will always result in a failure.
>>
>> Okay, you have convinced me. :)
>>

After search the history patches, I found one related patch which made
by myself (when I am in Asianux):

  "https://lkml.org/lkml/2013/7/1/641"

=46or me, it is a long discussion, and forced many members have to join
in. Please help check again.

Thanks.

>=20
> OK, thank all of you, and I shall send the related patch for it.=20
>=20
> I will try to finish it within this week.
>=20

--=20
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
