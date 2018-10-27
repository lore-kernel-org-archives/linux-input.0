From: Joe Perches <joe@perches.com>
Subject: Re: Another HID problem this merge window..
Date: Sat, 27 Oct 2018 12:36:05 -0700
Message-ID: <c6b7e5b26883c53db35454e9b0ffb44898517228.camel@perches.com>
References: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, 2018-10-27 at 11:13 -0700, Linus Torvalds wrote:
> Ok, so this is a much smaller issue than the i2c one that cause boot
> problems, but it's annoying.
> 
> We do *not* enable new random drivers by default. And we most
> *definitely* don't do it when they are odd-ball ones that most people
> have never heard of.
> 
> Yet the new "BigBen Interactive" driver that was added this merge
> window did exactly that.

In fairness, it seems many of the HID drivers do exactly that
and this could have been a "copy from example" addition.

$ git grep -P -i -B2 'default\s+\!EXPERT' -- drivers/hid/Kconfig
drivers/hid/Kconfig-    tristate "A4 tech mice"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Apple {i,Power,Mac}Books"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Belkin Flip KVM and Wireless keyboard"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Cherry Cymotion keyboard"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Chicony devices"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Cypress mouse and barcode readers"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Ezkey BTC 8193 keyboard"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "ITE devices"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Kensington Slimblade Trackball"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Logitech devices"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
