From: dturvene <dturvene@dahetral.com>
Subject: +1 for Cernekee Input: ALPS patchset
Date: Mon, 11 Feb 2013 13:05:29 -0500
Message-ID: <511932E9.50106@dahetral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dahetral.com ([128.177.27.153]:60584 "EHLO dahetral.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758597Ab3BKSFa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2013 13:05:30 -0500
Received: from [192.168.1.13] (pool-108-28-181-146.washdc.fios.verizon.net [108.28.181.146])
	(authenticated bits=0)
	by dahetral.com (8.13.8/8.13.8) with ESMTP id r1BI5T49029954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 11 Feb 2013 13:05:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have rebased my psmouse touchpad efforts to use the Cernekee 14-part 
patchset labelled with a prefix of "Input: ALPS".  Along with 
stabilizing a popular variant of the ALPS touchpad, the patchset 
cleans-up/refactors the code and makes it more flexible. In addition it 
makes the code portable across kernel 3.2 to 3.7 releases, which the 
current psmouse does not do.  I am currently working on, and testing, 
the "Dolphin support" he could not test. There appear to be two variants 
of the Dolphin signature which need to be reconciled.

Please accept Kevin's patches upstream.

Dave Turvene
