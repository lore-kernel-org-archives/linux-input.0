From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Reset ps/2 port  should psmouse_probe fail
	before	retrying
Date: Sat, 08 May 2010 18:01:27 +0200
Message-ID: <1273334487.7427.3.camel@lovely>
References: <1271723857.6652.6.camel@lovely>
	 <20100422215517.GB28213@core.coreip.homeip.net>
	 <1271983668.16254.44.camel@lovely>
	 <201004230953.52447.dmitry.torokhov@gmail.com>
	 <4BD1EB1C.1070200@canonical.com>
	 <20100428170721.GA6608@core.coreip.homeip.net>
	 <4BD897D4.4060405@canonical.com> <1272560268.3987.12.camel@lovely>
	 <4BDB5BA0.1080104@canonical.com> <1272769662.3315.36.camel@lovely>
	 <4BE45474.8040001@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:41345 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab0EHPzZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 May 2010 11:55:25 -0400
Received: by bwz19 with SMTP id 19so1052226bwz.21
        for <linux-input@vger.kernel.org>; Sat, 08 May 2010 08:55:24 -0700 (PDT)
In-Reply-To: <4BE45474.8040001@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>, Christopher Heiny <cheiny@synaptics.com>

On Fri, 2010-05-07 at 13:57 -0400, Peter M. Petrakis wrote:
> So where do we stand on this? Option #2 sounds like a good
> thing to implement regardless of whether synaptics is the
> victim device or not. Devices supported by the fall back driver
> will eventually get our attention again when users wish to use
> the extended features of the device. In the meanwhile, at least
> they'll have a reliable, minimum set of features.
> 
> I'm happy to continue instrumenting this mysterious synaptics
> device. Just keep the patches coming. Thanks.

You can wipe out this (maybe for firmware >7.5 obsolete) 0x47 check in
synaptics_capability() and see if it works with synaptics driver.


diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 026df60..6750dbb 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -138,7 +138,9 @@ static int synaptics_capability(struct psmouse *psmouse)
 		return -1;
 	priv->capabilities = (cap[0] << 16) | (cap[1] << 8) | cap[2];
 	priv->ext_cap = 0;
-	if (!SYN_CAP_VALID(priv->capabilities))
+	if (!SYN_CAP_VALID(priv->capabilities) &&
+		SYN_ID_MAJOR(priv->identity) < 7 &&
+		SYN_ID_MINOR(priv->identity) < 5)
 		return -1;
 
 	/*


