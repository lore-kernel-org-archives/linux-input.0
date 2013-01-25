From: dturvene <dturvene@dahetral.com>
Subject: Question about psmouse alps driver patches
Date: Fri, 25 Jan 2013 10:47:46 -0500
Message-ID: <5102A922.4090203@dahetral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dahetral.com ([128.177.27.153]:45488 "EHLO dahetral.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757527Ab3AYQWI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jan 2013 11:22:08 -0500
Received: from [192.168.1.13] (pool-108-28-181-146.washdc.fios.verizon.net [108.28.181.146])
	(authenticated bits=0)
	by dahetral.com (8.13.8/8.13.8) with ESMTP id r0PFlk4M025623
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 25 Jan 2013 10:47:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I submitted normalized patches to Canonical Ubuntu in October for the 
alps psmouse touchpad.  The thread is long and confusing at

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/606238

Since then, I have maintained a psmouse dlkm that provides alps support 
for a number of new systems, primarily from Dell.

Recently, I have been asked by several people to submit the patches to 
linux-input to merge into the upstream kernel.  I am looking for advice 
on how to proceed.  The big problems are:

1) The alps touchpads seem to be mutating relatively quickly with 
several unrecognized signatures appearing over the last few months after 
I built my patches.

2) A number of people have submitted a patch for a particular alps 
touchpad signature, which will need to be reconciled and rolled-up into 
a single driver.  See the Jan 20 3-part submission by 
cernekee@gmail.com.  His patches look good, and clean up the code a good 
bit, but target a touchpad signature also reverse-engineered by 
bgarami.foss@gmail.com.  I integrated the bgarami fixes into my patches 
but the patches from cernekee@gmail.com are radically different.

3) I built the patches against the 3.2 kernel.  My understanding is they 
do not even compile against the kernel head - something like 3.5.x.

I feel bad submitting the patches I have.  They are big and rough 
because several of us reverse-engineered the ALPS interfaces but did not 
try to figure them out.  It will take a lot of merge+test work to 
reconcile the patch submissions for the various alps target platforms.

What do you suggest I do (e.g. submit a patch for only the new protocol 
I can test?)

