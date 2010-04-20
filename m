From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Reset ps/2 port should psmouse_probe
	fail	before	retrying
Date: Tue, 20 Apr 2010 02:37:37 +0200
Message-ID: <1271723857.6652.6.camel@lovely>
References: <4BC8EA42.6030507@canonical.com>
	 <1271502098.4155.27.camel@lovely>  <4BC9D444.3090802@canonical.com>
	 <1271523195.3676.5.camel@lovely>  <4BCC77B4.5030703@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:45004 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454Ab0DTAcL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Apr 2010 20:32:11 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2227708fga.1
        for <linux-input@vger.kernel.org>; Mon, 19 Apr 2010 17:32:09 -0700 (PDT)
In-Reply-To: <4BCC77B4.5030703@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: linux-input@vger.kernel.org, rubini@cvml.unipv.it

Hi Peter,

 does this work for you?

I8042_CMD_AUX_ENABLE gets now triggered during pm_restore.

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 6440a8f..1af5a58 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1151,8 +1151,10 @@ static int i8042_pm_restore(struct device *dev)
 			printk(KERN_WARNING
 				"i8042: failed to resume active multiplexor, "
 				"mouse won't work.\n");
-	} else if (i8042_ports[I8042_AUX_PORT_NO].serio)
+	} else if (i8042_ports[I8042_AUX_PORT_NO].serio) {
+		i8042_toggle_aux(true);
 		i8042_enable_aux_port();
+	}
 
 	if (i8042_ports[I8042_KBD_PORT_NO].serio)
 		i8042_enable_kbd_port();


