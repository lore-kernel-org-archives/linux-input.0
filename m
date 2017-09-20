From: Teika Kazura <teika@gmx.com>
Subject: RMI4 support for synaptics (users, please test patch)
Date: Wed, 20 Sep 2017 09:22:18 +0900 (JST)
Message-ID: <20170920.092218.1849017994555826153.teika@gmx.com>
References: <20170818193436.GA31365@dtor-ws>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:50857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbdITAXX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Sep 2017 20:23:23 -0400
In-Reply-To: <20170818193436.GA31365@dtor-ws>
        <20170804.163222.1710020857391315492.teika@gmx.com>
        <1502840570.3706.5.camel@gmail.com>
        <ff2d9143-0312-1d9d-73a0-d8f5ac719cbb@markus-kaindl.de>
        <CACuduqo7g9fJbjR3d0DStKMaRCc8H5W39yjqUDXWV+Nb6FiXSA@mail.gmail.com>
        <CAD_UamUKvpQ_VEyH9i0MEBbG2S=FAx4zDdoCwYGNy05rwc+1-g@mail.gmail.com>
        <1500496250.4617.1.camel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rosenp@gmail.com, markus@markus-kaindl.de, adam@spicenitz.org, darrick.wong@oracle.com, lukas@5gsystems.com, waltercool@slash.cl, jan.steffens@gmail.com, kamil.54002@iskra.name, sibren.vasse@gmail.com, b.christopher.92@gmail.com

CC-ed folks, your devices need "psmouse.synaptics_intertouch=1". Let me follow up. (I'm not a kernel developer, but in a similar situation as yours.) The patch should apply to 4.13.x and 4.12.x.

@Lukas Prettenthaler, rosenp, Pablo Cholaky, jan.steffens, Darrick J. Wong:
 Could you please test the patch below? Make sure to delete "psmouse.synaptics_intertouch=1" from your boot parameter. If the patch has the same effect as the above boot parameter, it seems ok.

@Kamil Iskra: Maybe add "SYN3054" to the patch, and try?

@Sibren Vasse: I know your patch works for you, but could you try dropping SYN0100, SYN0002 and PNP0f13 from your patch? (Typical dmesg is like: "Your touchpad (PNP: SYN3221 PNP0f03) says it can support a different bus", and adding only the first of two, "SYN3221", suffices.)

@Adam Goode: As you know, your issue (freeze after resuming) is yet to be fixed. I haven't included your model in my patch.

@Christopher Bachner: What's the status of your PC? I'm subscribing linux-input@vger.kernel.org, and found your issue browsing linux-input archive, but you don't read this list, right? I think you've tried this patch: https://marc.info/?l=linux-input&m=149854999528878&w=2 

Best regards. Thank you for reporting.

---
 drivers/input/mouse/synaptics.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 5af0b7d..bc02040 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -169,10 +169,16 @@ static const char * const topbuttonpad_pnp_ids[] = {
 
 static const char * const smbus_pnp_ids[] = {
 	/* all of the topbuttonpad_pnp_ids are valid, we just add some extras */
+	"DLL075b",
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
+	"LEN004b", /* T460s */
+	"LEN006e", /* T470 */
 	"LEN200f", /* T450s */
+	/* "LEN2014", commented out, depending on resume bug fix */
+	"SYN1219", /* Used by many */
+	"SYN3221",
 	NULL
 };
 
