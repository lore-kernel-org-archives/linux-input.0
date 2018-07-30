From: Teika Kazura <teika@gmx.com>
Subject: [PATCH v2 0/1] Input: synaptics - Enable RMI4 for Clevo P870DM
 laptops.
Date: Mon, 30 Jul 2018 20:35:19 +0900 (JST)
Message-ID: <20180730.203519.1216400263695142421.teika@gmx.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jan.steffens@gmail.com, Pablo Cholaky <waltercool@slash.cl>
List-Id: linux-input@vger.kernel.org

@Rosen Penev: Could you please test this patch for kernel >= 4.17, for a week or so? At least suspend/resume should not cause any problem.
------------------------------------------------------------------------
This patch enables SMBus/RMI4 for PCs with SYN1219, e.g. Clevo P870DM etc.

Three users have reported SYN1219 supports SMBus, in Jul and Aug 2017:
https://marc.info/?l=linux-input&m=150049625613055&w=2
https://marc.info/?l=linux-input&m=150284057602358&w=2
https://marc.info/?l=linux-input&m=150094561111026&w=2

No problem has been reported since then.

---
v2
  This patch was originally submitted by Rosen Penev in Jun 2018 [1], which modified the list forcepad_pnp_ids[]. The current version instead changes smbus_pnp_ids[].

  This version is yet to be tested.

[1] https://www.spinics.net/lists/linux-input/msg56884.html

Teika Kazura (1):
  Input: synaptics - Enable RMI4 for Clevo P870DM laptops.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Co-Developed-by: Teika Kazura <teika@gmx.com>
Signed-off-by: Teika Kazura <teika@gmx.com>
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

--
2.16.1
