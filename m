From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v5 0/2] Input: Add Cypress Gen5 Touchscreen driver
Date: Wed, 20 Dec 2017 11:08:41 +0100
Message-ID: <20171220100843.2759-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello,

Here is a V5 series to add the driver of the touchscreen Cypress,
TrueTouch Generation 5.
Based on last master branch of "input" kernel's tree.

This patch series has already been posted in several iterations:
    - v1: Sent on 2017/05/29
    - v2: Sent on 2017/08/18
    - v3: Sent on 2017/09/27
    - v4: Sent on 2017/12/01

As I did not have any comments on the last 3 versions, it would be
great to have some feedback in case there is something wrong with this
series?

Changes since v4:
   - Fixed kbuild errors about enum hid_cmd_state and .owner
Changes since v3:
   - Rebased on last input's branch
   - Changed the CRC table to use crc_itu_t_table instead of
   crc_ccitt_false_table which is not merged.
   - Added selection of CRC_ITU_T on KConfig
Changes since v2:
   - Removed pinctrl in dt-binding example which is uncessecary.
   - Added Acked-by and Reviewed-by received.
Changes since v1:
   - Updated the driver according to reviews. Most important modifications:
   removed unnecessary mutex, updated dev_err output, handled return cases
   in a better way, created a HID_ENUM, removed magic value, used an
   existing CRC table and used "linux-keycodes" instead of sub-nodes.
   - Updated the dt-bindings to use linux-keycodes and removed properties'
   description that comes from touchscreen's binding.

Patch 01: Add the basis of the driver for Cypress Gen5 Touchscreen.
Patch 02: Add the binding documentation for this driver.

Thank you in advance,
Mylène

Mylène Josserand (2):
  Input: Add driver for Cypress Generation 5 touchscreen
  dt-bindings: input: Add documentation for cyttsp5

 .../bindings/input/touchscreen/cypress,cyttsp5.txt |   39 +
 drivers/input/touchscreen/Kconfig                  |   16 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/cyttsp5.c                | 1112 ++++++++++++++++++++
 4 files changed, 1168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,cyttsp5.txt
 create mode 100644 drivers/input/touchscreen/cyttsp5.c

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
