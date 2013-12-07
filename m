From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: synaptics: PS/2 touchpad isn't detected if a keyboard key is
 held down on boot
Date: Sat, 7 Dec 2013 08:02:46 -0800
Message-ID: <20131207160246.GA11635@core.coreip.homeip.net>
References: <CABWXVkMdyDNxG3QFOvyx4=6EiJQ5ik9aJxa7jQvtO+UJKwc8Fw@mail.gmail.com>
 <CABWXVkMUFdRKNm76Vc3oJ+Ef9M_MS1xU2TKh=rdyv-t9Cq5V1w@mail.gmail.com>
 <CABWXVkNXzxrZJiYshhsWFRf4fDgUL3=tmFtv23w=sZtZM7Rxgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hotplug-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABWXVkNXzxrZJiYshhsWFRf4fDgUL3=tmFtv23w=sZtZM7Rxgg@mail.gmail.com>
Sender: linux-hotplug-owner@vger.kernel.org
To: Andrey Moiseev <o2g.org.ru@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hotplug@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Dec 07, 2013 at 05:47:09PM +0400, Andrey Moiseev wrote:
> I inserted a printk into ps2_handle_response(struct ps2dev *ps2dev,
> unsigned char data) in "drivers/input/serio/libps2.c" and other
> functions in the file.
> It really eats scancodes from the keyboard, as I see (0x23 is the 'H'
> press scancode). Seems like the scancodes are mixed with reasonable
> values. Is it a bug in the controller? 

Not necessarily... Can you boot with i8042.debug=1 and post full dmesg?

Thanks.

-- 
Dmitry
