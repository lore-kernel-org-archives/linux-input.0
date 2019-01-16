From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH] input_event: Provide override for sparc64
Date: Tue, 15 Jan 2019 16:10:55 -0800
Message-ID: <CB606530-0E31-449D-8E04-CDFC1FF068CA@gmail.com>
References: <20181229183514.24644-1-deepa.kernel@gmail.com> <CAK8P3a1YG0+iMBiNy-g7KCusX3myV0tsuCEg1YLWW0cXrjk7PA@mail.gmail.com> <20190115.132928.900198180655535613.davem@davemloft.net> <CAKdAkRQdO14OP7SgE=D4x5RG7=cjDoCAOmtnCcWw_DrToeEmhA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRQdO14OP7SgE=D4x5RG7=cjDoCAOmtnCcWw_DrToeEmhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, David Miller <davem@davemloft.net>
List-Id: linux-input@vger.kernel.org



> On Jan 15, 2019, at 2:32 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com> w=
rote:
>=20
>> On Tue, Jan 15, 2019 at 1:29 PM David Miller <davem@davemloft.net> wrote:=

>>=20
>> From: Arnd Bergmann <arnd@arndb.de>
>> Date: Tue, 15 Jan 2019 22:19:27 +0100
>>=20
>>> The correct check appears to be
>>>=20
>>> #if defined(__sparc__) && defined(__arch64__)
>>=20
>> That is correct.
>=20
> OK. Deepa, could you please send me a fixup as I already pushed out
> the original patch?

Ok, I=E2=80=99m traveling. I will post an update in a couple of days.

Thanks,
Deepa=
