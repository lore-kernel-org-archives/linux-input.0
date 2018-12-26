From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 92/97] Input: synaptics - enable SMBus for HP EliteBook 840 G4
Date: Wed, 26 Dec 2018 17:35:52 -0500
Message-ID: <20181226223557.149329-92-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Mantas Mikulėnas <grawity@gmail.com>

[ Upstream commit 7a71712293ba303aad928f580b89addb0be2892e ]

dmesg reports that "Your touchpad (PNP: SYN3052 SYN0100 SYN0002 PNP0f13)
says it can support a different bus."

I've tested the offered psmouse.synaptics_intertouch=1 with 4.18.x and
4.19.x and it seems to work well. No problems seen with suspend/resume.

Also, it appears that RMI/SMBus mode is actually required for 3-4 finger
multitouch gestures to work -- otherwise they are not reported at all.

Information from dmesg in both modes:

  psmouse serio3: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1,
      caps: 0xf00123/0x840300/0x2e800/0x0, board id: 3139, fw id: 2000742

  psmouse serio3: synaptics: Trying to set up SMBus access
  rmi4_smbus 6-002c: registering SMbus-connected sensor
  rmi4_f01 rmi4-00.fn01: found RMI device,
      manufacturer: Synaptics, product: TM3139-001, fw id: 2000742

Signed-off-by: Mantas Mikulėnas <grawity@gmail.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7bdf8fc2c3b5..b6da0c1267e3 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -179,6 +179,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */
+	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
 	NULL
 };
-- 
2.19.1
