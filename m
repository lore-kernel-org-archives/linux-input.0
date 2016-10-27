From: "Simon Wood" <simon@mungewell.org>
Subject: Re: [RFC] HID:hid-lg4ff: Delay to allow wheels to center after
 plug-in
Date: Thu, 27 Oct 2016 17:30:38 -0600
Message-ID: <c91b066b6d35a18c149ec18f28a863b1.squirrel@mungewell.org>
References: <1477445172-2682-1-git-send-email-simon@mungewell.org>
    <24625977.TfGNBbEdyA@thora>
    <CAKdAkRQN2Kv7CLrmXzEjfPatgkmzBexzsBYdhzOLjunDTD0APg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRQN2Kv7CLrmXzEjfPatgkmzBexzsBYdhzOLjunDTD0APg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?utf-8?B?Ik1pY2hhbCBNYWzDvSI=?= <madcatxster@gmail.com>, Simon Wood <gitsend@mungewell.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Edwin Velds <edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

On Wed, October 26, 2016 11:00 am, Dmitry Torokhov wrote:
>
> Yeah, if device happens to be plugged at boot time it will wait that
> long before even getting to mount rootfs if driver is built into the
> kernel.

Not a case I had considered... that would probably be bad. I'll look at
coding up a work queue as Elias had suggested.

>
> This is also interesting way to say "msleep(8000)".

I'm a copy/paste guy, this was from the delay we have in hid-lg.c probe,
if one way or another is better I'll use that,
Simon
