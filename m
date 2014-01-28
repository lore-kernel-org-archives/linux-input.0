From: Tom Gundersen <teg@jklm.no>
Subject: Re: [RFC][PATCH] module: allow multiple calls to MODULE_DEVICE_TABLE()
 per module
Date: Tue, 28 Jan 2014 13:38:16 +0100
Message-ID: <CAG-2HqXuwcQ_FFaD50QS2AR08yCoDVkdF4WTogBUcH_GYynnVA@mail.gmail.com>
References: <1390849795-2155-1-git-send-email-teg@jklm.no> <87k3dkzy4t.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87k3dkzy4t.fsf@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Kay Sievers <kay@vrfy.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

Hi Rusty,

On Tue, Jan 28, 2014 at 2:35 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Tom Gundersen <teg@jklm.no> writes:
>> Commit 78551277e4df5: "Input: i8042 - add PNP modaliases" had a bug, where the
>> second call to MODULE_DEVICE_TABLE() overrode the first resulting in not all
>> the modaliases being exposed.
>
> No Signed-off-by?

Sorry about that, I'll resend in a minute with the signoff.

Cheers,

Tom
