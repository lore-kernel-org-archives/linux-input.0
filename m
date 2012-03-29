From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V3 0/2] Input: Add matrix_keypad_of_build_keymap()
Date: Thu, 29 Mar 2012 14:03:25 +0530
Message-ID: <cover.1333009670.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:49178 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751887Ab2C2Isf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 04:48:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: swarren@nvidia.com, spear-devel@list.st.com, viresh.linux@gmail.com, devicetree-discuss@lists.ozlabs.org, olof@lixom.net, linux-input@vger.kernel.org, sr@denx.de, Viresh Kumar <viresh.kumar@st.com>

This patchset adds matrix_keypad_of_build_keymap() routine for building keymap
directly from device tree.

V2->V3:
- Preference given to platform data over device tree in probe routine of
  drivers.
- Declaration of matrix_keypad_of_build_keymap() routine is changed.
- Range/Overflow checking is done on keys and column.

V1->V2:
- Introduced matrix_keypad_of_build_keymap() and removed fill and free keymap
  routines.
- Updated tegra-kbc.

Viresh Kumar (2):
  Input: of_keymap: Introduce matrix_keypad_of_build_keymap()
  Input: spear-keyboard: add device tree bindings

 .../devicetree/bindings/input/spear-keyboard.txt   |   21 +++++
 drivers/input/keyboard/Kconfig                     |    1 +
 drivers/input/keyboard/spear-keyboard.c            |   86 +++++++++++++++---
 drivers/input/keyboard/tegra-kbc.c                 |   48 +++++-----
 drivers/input/of_keymap.c                          |   94 +++++++++++---------
 include/linux/input/matrix_keypad.h                |   16 +---
 6 files changed, 180 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/spear-keyboard.txt

-- 
1.7.10.rc2.10.gb47606

