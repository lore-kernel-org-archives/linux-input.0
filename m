From: Jiri Kosina <jkosina@suse.cz>
Subject: Need for 'nomux' has been rising lately ...
Date: Tue, 14 Oct 2008 16:55:22 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810141652090.26779@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:58692 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751317AbYJNOzY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 10:55:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Carlos Tonussi <tonussi@farmaco.ufsc.br>

Hi Dmitry,

lately, I have been seeing a couple of bug reports in which touchpad of 
certain notebooks misbehaved, and i8042.nomux solved the problem. Most 
recently, this happened on [1]. Do you have any idea what might be the 
cause of the need for nomux rising so much lately? Apparently, some older 
kernels behaved correctly even without this workaround, at least on Acer 
Aspire 5710, as referenced in the bugreport.

Thanks.

[1] https://bugzilla.novell.com/show_bug.cgi?id=404881

-- 
Jiri Kosina
SUSE Labs
