From: <michael.hennerich@analog.com>
Subject: [PATCH v2 2/6] input: misc: AD714x: Fix up input configuration.
Date: Thu, 12 May 2011 10:45:07 +0200
Message-ID: <1305189911-24769-2-git-send-email-michael.hennerich@analog.com>
References: <1305189911-24769-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:40696
	"EHLO AM1EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751567Ab1ELIyk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2011 04:54:40 -0400
In-Reply-To: <1305189911-24769-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeff.dagenais@gmail.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Add missing input name, phys and parent dev.

Changes since V1:
input: misc: AD714x: Drop input phys completely

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/misc/ad714x.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index eb352fb..847d6d3 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -1152,6 +1152,8 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 			input[alloc_idx]->id.bustype = bus_type;
 			input[alloc_idx]->id.product = ad714x->product;
 			input[alloc_idx]->id.version = ad714x->version;
+			input[alloc_idx]->name = "ad714x_captouch_slider";
+			input[alloc_idx]->dev.parent = dev;
 
 			error = input_register_device(input[alloc_idx]);
 			if (error)
@@ -1182,6 +1184,8 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 			input[alloc_idx]->id.bustype = bus_type;
 			input[alloc_idx]->id.product = ad714x->product;
 			input[alloc_idx]->id.version = ad714x->version;
+			input[alloc_idx]->name = "ad714x_captouch_wheel";
+			input[alloc_idx]->dev.parent = dev;
 
 			error = input_register_device(input[alloc_idx]);
 			if (error)
@@ -1215,6 +1219,8 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 			input[alloc_idx]->id.bustype = bus_type;
 			input[alloc_idx]->id.product = ad714x->product;
 			input[alloc_idx]->id.version = ad714x->version;
+			input[alloc_idx]->name = "ad714x_captouch_pad";
+			input[alloc_idx]->dev.parent = dev;
 
 			error = input_register_device(input[alloc_idx]);
 			if (error)
@@ -1243,6 +1249,8 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 		input[alloc_idx]->id.bustype = bus_type;
 		input[alloc_idx]->id.product = ad714x->product;
 		input[alloc_idx]->id.version = ad714x->version;
+		input[alloc_idx]->name = "ad714x_captouch_button";
+		input[alloc_idx]->dev.parent = dev;
 
 		error = input_register_device(input[alloc_idx]);
 		if (error)
-- 
1.6.0.2


