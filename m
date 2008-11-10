From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] Input: i8042 - add Dell XPS M1530 to nomux list
Date: Mon, 10 Nov 2008 14:34:04 -0200
Message-ID: <200811101434.04830.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from perninha.conectiva.com.br ([200.140.247.100]:48818 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbYKJQds (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Nov 2008 11:33:48 -0500
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 799553EB3
	for <linux-input@vger.kernel.org>; Mon, 10 Nov 2008 11:34:05 -0500 (EST)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id LmRPFuvfwaxP for <linux-input@vger.kernel.org>;
	Mon, 10 Nov 2008 11:34:05 -0500 (EST)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 25B443EB2
	for <linux-input@vger.kernel.org>; Mon, 10 Nov 2008 11:34:05 -0500 (EST)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id 7FF842F20B
	for <linux-input@vger.kernel.org>; Mon, 10 Nov 2008 13:33:45 -0300 (BRT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Dell XPS M1530 needs i8042.nomux=1 for ALPS touchpad to work as reported on
https://qa.mandriva.com/show_bug.cgi?id=43532

It is said that before A08 bios version this isn't needed (I don't have the
hardware so can't check), and suppose this will not break with bios versions
before A08.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index eec375c..5db1d0b 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -337,6 +337,13 @@ static struct dmi_system_id __initdata i8042_dmi_nomux_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
 		},
 	},
+	{
+		.ident = "Dell XPS M1530",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS M1530"),
+		},
+	},
 	{ }
 };
 
