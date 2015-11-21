From: Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V4 0/3] Input: goodix - add axis swapping and axis inversion support
Date: Sat, 21 Nov 2015 14:30:19 +0100
Message-ID: <1448112622-2062-1-git-send-email-merker@debian.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hello,

this is v4 of my "Input: goodix - add axis swapping and axis inversion
support" patchset.

The goodix touchscreen driver has gained device-tree support in kernel
4.1, but doesn't currently support the touchscreen-swapped-x-y,
touchscreen-inverted-x and touchscreen-inverted-y properties.
On systems which combine a portrait-mode display with a landscape-mode
touchscreen, such as e.g. the MSI Primo 81 tablet, support for these
features is necessary to have the touchscreen and the display use the
same coordinate system.

With support for axis inversion, the "rotated_screen" flag in the
driver can also be removed, as "rotated_screen" is just a special case
of x/y axis inversion.

This patchset sits on top of the "[PATCH v11 0/8] Goodix touchscreen
enhancements" series by Irina Tirdea:
https://www.spinics.net/lists/linux-input/msg42146.html

The axis swapping has successfully been tested on an MSI Primo 81
tablet and on a Wexler TAB7200 tablet; the x/y inversion resp. 
the rotated_screen functionality has successfully been tested on
a WinBook TW100.

Regards,
Karsten

Changelog:

v1: * Initial version (based von v6 of Irina Tirdea's "Goodix
      touchscreen enhancements" series).
      Reviewed-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>

v2: * Rebase against v8 of Irina Tirdea's "Goodix touchscreen
      enhancements" series.
    * Fix a typo in the commit message.
    * Add an update for the goodix dt bindings documentation
      (patch No. 3).
    * Reviews/Tests:
      Patch 1+2: Tested-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
                 Acked-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
      Patch 2+3: Reviewed-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

v3: * Rebase against v9 of Irina Tirdea's "Goodix touchscreen
      enhancements" series.
    * Address the review comments for patch No. 1 by Irina Tirdea
      (https://www.spinics.net/lists/linux-input/msg41536.html):
      - Move reading the dt properties from goodix_ts_probe to
        goodix_configure_dev to make them work properly in all
        configurations (with and without gpio declarations).
      - Use the new unified device properties API (device_property_*)
        instead of the classic DT API (of_property_*). This
        provides support for ACPI 5.1 DSD properties as well as
        for device-tree properties.
    * Reviews/Tests:
      Tested-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> (with ACPI DSD properties)
      Tested-by: Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> (with device-tree properties)

v4: * Rebase against v11 of Irina Tirdea's "Goodix touchscreen
      enhancements" series (no functional changes).

Karsten Merker (3):
  Input: goodix - add axis swapping and axis inversion support
  Input: goodix - use "inverted_[xy]" flags instead of "rotated_screen"
  Input: goodix - update dt bindings documentation (axis
    swapping/inversion)

 .../bindings/input/touchscreen/goodix.txt          |  5 ++++
 drivers/input/touchscreen/goodix.c                 | 31 ++++++++++++++++++----
 2 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
