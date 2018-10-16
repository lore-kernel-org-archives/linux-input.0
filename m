From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: uinput - fix Spectre v1 vulnerability
Date: Tue, 16 Oct 2018 11:09:56 -0700
Message-ID: <26EEA6BC-43B0-42F7-A237-572D32EB2309@gmail.com>
References: <20181016111313.GA28307@embeddedor.com> <20181016172107.GA230131@dtor-ws> <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On October 16, 2018 10:52:58 AM PDT, "Gustavo A=2E R=2E Silva" <gustavo@emb=
eddedor=2Ecom> wrote:
>Hi Dmitry,
>
>On 10/16/18 7:21 PM, Dmitry Torokhov wrote:
>> Hi Gustavo,
>>=20
>> On Tue, Oct 16, 2018 at 01:13:13PM +0200, Gustavo A=2E R=2E Silva wrote=
:
>>> setup=2Ecode can be indirectly controlled by user-space, hence leading
>to
>>> a potential exploitation of the Spectre variant 1 vulnerability=2E
>>>
>>> This issue was detected with the help of Smatch:
>>>
>>> drivers/input/misc/uinput=2Ec:512 uinput_abs_setup() warn: potential
>>> spectre issue 'dev->absinfo' [w] (local cap)
>>>
>>> Fix this by sanitizing setup=2Ecode before using it to index
>dev->absinfo=2E
>>=20
>> So we are saying that attacker, by repeatedly calling ioctl(=2E=2E=2E,
>> UI_ABS_SETUP, =2E=2E=2E) will be able to poison branch predictor and
>discover
>> another program or kernel secrets? But uinput is a privileged
>interface
>> open to root only, as it allows injecting arbitrary keystrokes into
>the
>> kernel=2E And since only root can use uinput, meh?
>>=20
>
>Oh I see=2E=2E=2E in that case this is a false positive=2E
>
>Although, I wonder if all these operations are only accessible to root:
>
>static const struct file_operations uinput_fops =3D {
>        =2Eowner          =3D THIS_MODULE,
>        =2Eopen           =3D uinput_open,
>        =2Erelease        =3D uinput_release,
>        =2Eread           =3D uinput_read,
>        =2Ewrite          =3D uinput_write,
>        =2Epoll           =3D uinput_poll,
>        =2Eunlocked_ioctl =3D uinput_ioctl,
>#ifdef CONFIG_COMPAT
>        =2Ecompat_ioctl   =3D uinput_compat_ioctl,
>#endif
>        =2Ellseek         =3D no_llseek,
>};

/dev/uinput must be 0600, or accessible to equally privileged user, or you=
'll be opening your system to much mischief=2E


Thanks=2E

--=20
Dmitry
