From: Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] Add device tree support for Goodix GT9xx series touchscreen controller
Date: Wed,  4 Mar 2015 11:32:10 +0300
Message-ID: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This patch set adds device tree support and binding information for Goodix
GT9xx series touchscreen controller.
It also adds support for 5-finger chips, like GT911 and GT912, which
can be found on ARM tablets, like Wexler TAB7200 and MSI Primo73.

Aleksei Mamlin (2):
  input: goodix: Add device tree support
  input: goodix: Add device tree support for 5-finger chips

 .../bindings/input/touchscreen/goodix.txt          | 29 +++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/input/touchscreen/Kconfig                  |  2 +-
 drivers/input/touchscreen/goodix.c                 | 49 ++++++++++++++++++++--
 4 files changed, 76 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/goodix.txt

-- 
2.0.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
