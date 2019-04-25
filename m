From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 2/2] HID: wacom: Don't report anything prior to the tool
 entering range
Date: Thu, 25 Apr 2019 10:47:50 -0700
Message-ID: <CANRwn3Ru+7FGtsY=GaDa7pAJkuagdb6nFtvrFq1qhTWJR0rF9A@mail.gmail.com>
References: <20190424221258.19992-2-jason.gerecke@wacom.com> <20190425121506.7EBEC218B0@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190425121506.7EBEC218B0@mail.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: Jason Gerecke <jason.gerecke@wacom.com>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, "# v3.17+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

I can produce a version of this patch specific to v4.14.113. Please
let me know the proper process for submitting such a patch.

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

On Thu, Apr 25, 2019 at 5:15 AM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: a48324de6d4d HID: wacom: Bluetooth IRQ for Intuos Pro shou=
ld handle prox/range.
>
> The bot has tested the following trees: v5.0.9, v4.19.36, v4.14.113.
>
> v5.0.9: Build OK!
> v4.19.36: Build OK!
> v4.14.113: Failed to apply! Possible dependencies:
>     87046b6c995c ("HID: wacom: Add support for 3rd generation Intuos BT")
>     c947218951da ("HID: wacom: Add support for One by Wacom (CTL-472 / CT=
L-672)")
>
>
> How should we proceed with this patch?
>
> --
> Thanks,
> Sasha
