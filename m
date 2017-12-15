From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] input - leds: fix bugs found by fuzzing
Date: Fri, 15 Dec 2017 09:04:04 +0100
Message-ID: <CAO-hwJKWqyD8EYN8k+TE0XfBOAC0Bzcj87BNnxHiGbpVgKnDTg@mail.gmail.com>
References: <20171214132522.20346-1-benjamin.tissoires@redhat.com> <20171215001615.tmcbq4v6fcum2ngj@var.youpi.perso.aquilenet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171215001615.tmcbq4v6fcum2ngj@var.youpi.perso.aquilenet.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Dec 15, 2017 at 1:16 AM, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> Hello,
>
> Benjamin Tissoires, on jeu. 14 déc. 2017 14:25:20 +0100, wrote:
>> I marked them as stable as I believe eventhough not many
>> people discovered those and reported them, they should
>> still be fixed in current kernels.
>
> Well, the quoted source lines are not in any stable tree, I don't even
> find them in the mainline tree.  Where do these lines come from?

Oops, indeed, the patch 1/2 fixes a local commit I wrote to fix the
LED not being updated after the connect, that has already been
rejected upstream. (FWIW, it was
https://patchwork.kernel.org/patch/9542397/)

Dmitry, please disregard 1/2 and only have a look at 2/2.

Cheers,
Benjamin

>
> Samuel
