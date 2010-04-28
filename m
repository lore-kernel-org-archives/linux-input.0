From: Oliver Neukum <oneukum@suse.de>
Subject: question on releasing keys
Date: Wed, 28 Apr 2010 10:53:52 +0200
Message-ID: <201004281053.52598.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54093 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276Ab0D1Ix5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Apr 2010 04:53:57 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 22D5A86A2E
	for <linux-input@vger.kernel.org>; Wed, 28 Apr 2010 10:53:56 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I am seeing a generic problem with buttons on devices released during S3.
The input layer then assumes that the button is still pressed. It would be best
for drivers to either verify that a button is still held or alternatively, to release
all buttons upon resumption. Is there a generic way to do that?

	Regards
		Oliver
