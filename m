From: Andrey Utkin <andrey_utkin@fastmail.com>
Subject: Re: [Kernel] Mainlining of Pyra nub joystick driver
Date: Tue, 14 Jun 2016 20:02:06 +0300
Message-ID: <20160614170206.GE4820@zver>
References: <20160614114523.GC4820@zver>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160614114523.GC4820@zver>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, devel@driverdev.osuosl.org, kernel-mentors@selenic.com, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Daniel Hung-yu Wu <hywu@google.com>, Moritz Fischer <moritz.fischer@ettus.com>, Geert Uytterhoeven <geert@linux-m68k.org>, S Twiss <stwiss.opensource@diasemi.com>, Rob Herring <robh@kernel.org>, Grant Grundler <grundler@chromium.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 14, 2016 at 02:45:23PM +0300, Andrey Utkin wrote:
> There's a pair of "nub" devices on Pyra handheld PC
> ...

Update: found drivers/input/joystick/as5011.c in mainline kernel,
will look how it works with as5013 hardware.
