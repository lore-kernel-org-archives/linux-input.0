From: Andrey Utkin <andrey_utkin@fastmail.com>
Subject: Mainlining of Pyra nub joystick driver
Date: Tue, 14 Jun 2016 14:45:23 +0300
Message-ID: <20160614114523.GC4820@zver>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: linux-input@vger.kernel.org, devel@driverdev.osuosl.org, kernel-mentors@selenic.com, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Daniel Hung-yu Wu <hywu@google.com>, Moritz Fischer <moritz.fischer@ettus.com>, Geert Uytterhoeven <geert@linux-m68k.org>, S Twiss <stwiss.opensource@diasemi.com>, Rob Herring <robh@kernel.org>, Grant Grundler <grundler@chromium.org>
List-Id: linux-input@vger.kernel.org

There's a pair of "nub" devices on Pyra handheld PC
(https://pyra-handheld.com/), and there's driver for nub, which is going
to be reworked for upstreaming. While the device itself fits most to
"joystick" category, the computer itself lacks touchpad and mouse
buttons, and the existing driver is capable of switching between modes, in
which it shows up like one of the following:
 - scrolling wheel,
 - mouse buttons set,
 - pointer updating its absolute position (graphic pad alike AFAIU),
 - pointer device behaving like actual joystick / pointing stick.

Currently modes switching happens through r/w file in /proc, which is of
couse going to be changed.

I wonder if such mode switching mechanism is tolerable for inclusion to
upstream kernel in this case. I'd like some advice how to rearrange the
driver to save most of flexibility while matching upstream kernel
conventions. I am especially interested in comments from subsystem
maintainers.

Existing driver:
http://git.goldelico.com/?p=gta04-kernel.git;a=blob;f=drivers/input/misc/as5013.c;h=1bfb5243f692c0c0a9c93881968849cac947c92d;hb=refs/heads/work/hns/input/as5013
