From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 2/4] lib/hexdump.c: factor out generic hexdump
 formatting for reuse.
Date: Wed, 27 Mar 2019 09:46:48 +0200
Message-ID: <CAHp75VebbroyOt6DPnqKVk99RowZsxgjuHbi6HoXf-tAuZLMqA@mail.gmail.com>
References: <20190327014807.7472-1-ronald@innovation.ch> <20190327014807.7472-3-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327014807.7472-3-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 27, 2019 at 3:49 AM Ronald Tschal=C3=A4r <ronald@innovation.ch>=
 wrote:
>
> This introduces print_hex_dump_to_cb() which contains all the hexdump
> formatting minus the actual printk() call, allowing an arbitrary print
> function to be supplied instead. And print_hex_dump() is re-implemented
> using print_hex_dump_to_cb().
>
> This allows other hex-dump logging functions to be provided which call
> printk() differently or even log the hexdump somewhere entirely
> different.

No Sign-off?

In any case, don't do it like this. smaller non-recursive printf() is
better than one big receursive call.
When it looks like an optimization, it's actually a regression.

And yes, debugfs idea is not bad.

P.S. Also check %*ph specifier.

--=20
With Best Regards,
Andy Shevchenko
