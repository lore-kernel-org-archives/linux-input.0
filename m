From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 1/3] m68k/mac: Make mac_hid_mouse_emulate_buttons() declaration visible
Date: Fri, 20 Jul 2007 13:47:36 -0400
Message-ID: <d120d5000707201047y2d22167co882a10176d79fce4@mail.gmail.com>
References: <20070720164043.523003359@mail.of.borg>
	 <20070720164323.625963918@mail.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070720164323.625963918@mail.of.borg>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
List-Id: linux-input@vger.kernel.org

Hi Geert,

On 7/20/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> From: Geert Uytterhoeven <geert@linux-m68k.org>
>
> m68k/mac: Make mac_hid_mouse_emulate_buttons() declaration visible
>
> drivers/char/keyboard.c: In function 'kbd_keycode':
> drivers/char/keyboard.c:1142: error: implicit declaration of function 'mac_hid_mouse_emulate_buttons'
>
> The forward declaration of mac_hid_mouse_emulate_buttons() is not visible on
> m68k because it's hidden in the middle of a big #ifdef block.
>
> Move it to <linux/hid.h>, correct the type of the second parameter, and
> include <linux/hid.h> where needed.

linux/hid.h contains definitions needed for drivers speaking HID
protocol, I don't think we want to put quirks for legacy keyboard
driver there. I'd just move the #ifdef within drivers/char/keyboard.c
for now.

BTW, I don't think that mac button emulation will work well when x86
evdev-based driver gains popularity - it "grabs" the device and so no
event will flow through keyboard driver... We'd need a new solution...

-- 
Dmitry
