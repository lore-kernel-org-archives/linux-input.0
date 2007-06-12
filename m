From: "Giel de Nijs" <giel@caffeinetrip.com>
Subject: Re: [PATCH] input: fix broken behaviour of Dell Latitude special keys
Date: Tue, 12 Jun 2007 22:15:37 +0200
Message-ID: <929318d30706121315n3d2d20efp6fd3ff590cce894c@mail.gmail.com>
References: <929318d30706101042q25418f9aif7c1a609fd792830@mail.gmail.com>
	 <200706120127.25581.dtor@insightbb.com>
Reply-To: giel@caffeinetrip.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200706120127.25581.dtor@insightbb.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, Vojtech Pavlik <vojtech@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, Matt Domsch <matt_domsch@dell.com>, Rezwanul Kabir <rezwanul_kabir@dell.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 6/12/07, Dmitry Torokhov <dtor@insightbb.com> wrote:

> Thank you for the patch. Is there any way I could see data coming from i8042
> when you press on these special keys? If you could do:
>
> echo 1 > /sys/module/i8042/parameters/debug
> tehn presses and released all these keys
> echo 0 > /sys/module/i8042/parameters/debug
>
> and send me dmesg I woudl appreciate that.

Here's the data from i8042 of, in order, Fn-F1, Fn-F3, Fn-F7, Fn-F8, Fn-Up,
Fn-Down, and Fn-Left:

drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, 0, 1) [2277118]
drivers/input/serio/i8042.c: 0a <- i8042 (interrupt, 0, 1) [2277118]
drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, 0, 1) [2277643]
drivers/input/serio/i8042.c: 07 <- i8042 (interrupt, 0, 1) [2277643]
drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, 0, 1) [2277987]
drivers/input/serio/i8042.c: 0f <- i8042 (interrupt, 0, 1) [2277988]
drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, 0, 1) [2278175]
drivers/input/serio/i8042.c: 0b <- i8042 (interrupt, 0, 1) [2278175]
drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, 0, 1) [2279806]
drivers/input/serio/i8042.c: 06 <- i8042 (interrupt, 0, 1) [2279806]
drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, 0, 1) [2279940]
drivers/input/serio/i8042.c: 05 <- i8042 (interrupt, 0, 1) [2279940]
drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, 0, 1) [2280101]
drivers/input/serio/i8042.c: 13 <- i8042 (interrupt, 0, 1) [2280102]

As you can see, no release events :).

There's also Fn-End, Fn-PgUp, Fn-PgDown (all audio related) and the wireless
switch at the side, those do generate release events. Also, the Fn
combinations for num lock, scroll lock, sysrq and pause/break seem to act
normal. There's also Fn-Esc, but that's an ACPI key.

Hope this helps.

Greetings,
Giel
