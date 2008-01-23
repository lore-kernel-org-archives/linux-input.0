From: "Girish" <girishsg@ti.com>
Subject: Keyboard issue
Date: Wed, 23 Jan 2008 17:15:08 +0530
Message-ID: <01fe01c85db5$67d00950$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:59856 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbYAWLpT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 06:45:19 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m0NBjAQJ028305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Wed, 23 Jan 2008 05:45:18 -0600
Received: from a0393109 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m0NBj8WC012094
	for <linux-input@vger.kernel.org>; Wed, 23 Jan 2008 17:15:09 +0530 (IST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


Hi,
I'm seeing some wrong key values displayed while in auto-repeat feature. I press the key and keep it pressed for some few seconds
and I start getting wrong key code values. I see the register value is changing when in auto-repeat, idealy the register value
should not change.
I'm enabling auto-repeat feature of input subsystem. Any idea why such behaviour? Is it that hardware has some issues?

Regards,
Girish

