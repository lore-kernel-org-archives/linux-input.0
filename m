From: megous via linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Subject: [PATCH RESEND v4 0/4] Add support for lradc on A83T
Date: Wed, 27 Mar 2019 03:33:35 +0100
Message-ID: <20190327023339.25975-1-megous@megous.com>
Reply-To: megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDXLF6FR5INBBDWC5PSAKGQEECPHFYI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>, Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org

From: Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>

(This is a re-send, with input subsystem maintainer added. Sorry,
for the extra noise, I did only send the v4 to the previous recipients
of v3, and didn't notice input subsystem was missing back then too.
Thank you wens for pointing it out.)

This series implements r_lradc (low res ADC) support for A83T.

This is a continuation of v3 patch series from 2017 by Ziping Chen. I've
rebased it on top of linux-next and changed the compatibe string as
requested back then.[1]

There was some talk of iio based lradc driver back then[2], but noone
stepped forward to make it. Let's finish this series, so that it's
at least possible to add support for tablet keys on various A83T tablets
as that's the main use of lradc module.

[1] https://lkml.org/lkml/2017/6/26/558

[2] https://lkml.org/lkml/2017/6/27/877

Please take a look, and apply the patches if you have no objections.

regards,
  Ondrej Jirman


Changes for v4:
- changed comaptible string to allwinner,sun8i-a83t-r-lradc
  (drop -keys suffix)
- dropped 0 prefix in the r_lradc DT node
- added sample A83T lradc user (TBS A711 tablet)

Changes for v3:
- Fix some issuses raised by Maxime.
- Added Rob's ACK.

Changes for v2:
- Add an A83T specific compatible.

Ondrej Jirman (1):
  ARM: dts: sun8i: tbs-a711: Add support for volume keys input

Ziping Chen (3):
  input: sun4i-a10-lradc-keys: Add support for A83T
  dt-bindings: input: Add R_LRADC support for A83T
  ARM: dts: sunxi: Add R_LRADC support for A83T

 .../bindings/input/sun4i-lradc-keys.txt       |  6 ++-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts     | 20 ++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  7 ++++
 drivers/input/keyboard/sun4i-lradc-keys.c     | 38 +++++++++++++++++--
 4 files changed, 65 insertions(+), 6 deletions(-)

-- 
2.21.0
