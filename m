From: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: [PATCH 0/2] input: Driver for Goodix GT801 2+1 touchscreen
Date: Mon,  7 Dec 2015 09:25:59 +0200
Message-ID: <1449473161-3535-1-git-send-email-plaes@plaes.org>
Reply-To: plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJLTBEBXENBBGHJSSZQKGQEMVRTE4A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This series adds support for Goodix GT801 2+1 touchscreen controller
and hooks it up on Gemei G9 tablet.

Now about GT801 2+1 - I initially tried to implement this inside the
existing Goodix driver, but unfortunately there are too many small
bits and pieces that would make the otherwise simple driver a
complicated mess:
  - endianness differences of coordinate readouts
  - totally different touch protocol
  - configuration layout and version information
  - I2C register differences (2 bytes vs single byte)

To apply the patchset, you need both linux-input/next and
linux-sunxi/next merged.

Patch 1 (Gemei G9 devicetree bits) should go via linux-sunxi tree.
Patch 2 (GT801 2+1 driver implementation) via linux-input

Priit Laes (2):
  ARM: dts: sun4i: gemei-g9: Add touchscreen (Goodix gt801x2) support
  input: gt801_2plus1 - Add initial support for Goodix GT801 2+1

 .../bindings/input/touchscreen/gt801_2plus1.txt    |  23 ++
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |  26 +-
 drivers/input/touchscreen/Kconfig                  |  19 +-
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/gt801_2plus1.c           | 375 +++++++++++++++++++++
 6 files changed, 445 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/gt801_2plus1.txt
 create mode 100644 drivers/input/touchscreen/gt801_2plus1.c

-- 
2.6.3
