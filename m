From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: psmouse - disable automatic probing of BYD touchpads
Date: Sat, 12 Nov 2016 23:13:31 -0800
Message-ID: <CAKdAkRSiE9mWRdq9+4UiyE0hDVKeeWs=JunQH3LcoqDzKtgnaw@mail.gmail.com>
References: <20161112191545.GA19531@dtor-ws> <201611122039.33245@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201611122039.33245@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Chris Diamand <chris@diamand.org>, Frederick Billings <phonesyfreakies@gmail.com>, Michael Shell <list1@michaelshell.org>, Eric Wong <normalperson@yhbt.net>, Ondrej Zary <linux@rainbow-software.org>, Christophe TORDEUX <christophe@tordeux.net>, Richard Pospesel <pospeselr@gmail.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Nov 12, 2016 at 11:39 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> On Saturday 12 November 2016 20:15:45 Dmitry Torokhov wrote:
>> BYD automatic protocol detection is extremely unreliable and is often
>> triggers false positives on regular mice, Sentelic touchpads, and
>> other devices. BYD has several documents that have recommended
>> detection sequence, but they conflict with each other and, as far as
>> I can see, still would not produce unique enough output to reliably
>> differentiate BYD from other PS/2 devices.
>>
>> OEMs sourcing BYD devices also do not do us any favors by not
>> supplying any reasonable DMI data and instead leaving turds like "To
>> Be Filled By O.E.M." in place of vendor data, or "System Serial
>> Number" as serial number.
> ...
>>       echo -n "byd" > /sys/bus/serio/devices/serio1/drvctl
>
> I agree, if we cannot detect BYD devices correctly without breaking
> other non-BYD devices then detection must be done by user...
>
> So you can add my Reviewed-by: Pali Roh=C3=A1r to this patch.
>
> Anyway, BYD show Linux as supported OS for their devices. It is really
> rude from BYD that they show Linux as supported OS, but Linux driver is
> reverse-engineered by community and they do not want to cooperate and at
> least provide some useful documentation for detection...

I am not even sure they have a good way of detecting their devices.
The Windows model is that vendor supplies OEM with their driver and it
just works (I do not think these devices have external PS/2 ports so
there is no concern with mis-detection).

Thanks.

--=20
Dmitry
