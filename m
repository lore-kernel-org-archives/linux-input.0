From: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] input: cros_ec_keyb_clear_keyboard() depends on CONFIG_PM_SLEEP
Date: Wed, 8 May 2013 21:25:56 -0600
Message-ID: <CAPnjgZ3Akf0+LKBt4c5HQX5c8PhL+zuvvHWrDpVj0W++GiOanA@mail.gmail.com>
References: <1368049529-8168-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368049529-8168-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lk <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, May 8, 2013 at 3:45 PM, Geert Uytterhoeven <geert@linux-m68k.or=
g> wrote:
> If CONFIG_PM_SLEEP is not set:
>
> drivers/input/keyboard/cros_ec_keyb.c:211: warning: =91cros_ec_keyb_c=
lear_keyboard=92 defined but not used
>
> Move the definition of cros_ec_keyb_clear_keyboard() inside the secti=
on
> protected by #ifdef CONFIG_PM_SLEEP to fix this.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Simon Glass <sjg@chromium.org>
