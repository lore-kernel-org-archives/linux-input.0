From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: [PATCH 27] drivers/input/serio/gscps2.c: kmalloc + memset conversion to kzalloc
Date: Tue, 31 Jul 2007 19:48:11 +0200
Message-ID: <200707311948.11520.m.kozlowski@tuxland.pl>
References: <200707311845.48807.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200707311845.48807.m.kozlowski@tuxland.pl>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/input/serio/gscps2.c | 11696 -> 11607 (-89 bytes)

 drivers/input/serio/gscps2.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.23-rc1-mm1-a/drivers/input/serio/gscps2.c	2007-07-26 13:07:44.000000000 +0200
+++ linux-2.6.23-rc1-mm1-b/drivers/input/serio/gscps2.c	2007-07-30 00:12:31.000000000 +0200
@@ -340,8 +340,8 @@ static int __init gscps2_probe(struct pa
 	if (dev->id.sversion == 0x96)
 		hpa += GSC_DINO_OFFSET;

-	ps2port = kmalloc(sizeof(struct gscps2port), GFP_KERNEL);
-	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	ps2port = kzalloc(sizeof(struct gscps2port), GFP_KERNEL);
+	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!ps2port || !serio) {
 		ret = -ENOMEM;
 		goto fail_nomem;
@@ -349,8 +349,6 @@ static int __init gscps2_probe(struct pa

 	dev_set_drvdata(&dev->dev, ps2port);

-	memset(ps2port, 0, sizeof(struct gscps2port));
-	memset(serio, 0, sizeof(struct serio));
 	ps2port->port = serio;
 	ps2port->padev = dev;
 	ps2port->addr = ioremap_nocache(hpa, GSC_STATUS + 4);
