From: Joakim Plate <elupus@ecce.se>
Subject: Re: [PATCH v2 0/3] Another try for the Sixaxis plugin
Date: Sat, 30 Apr 2011 11:31:52 +0000 (UTC)
Message-ID: <loom.20110430T133058-501@post.gmane.org>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:56229 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318Ab1EDSzM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 May 2011 14:55:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1QHhE2-0008RE-3h
	for linux-input@vger.kernel.org; Wed, 04 May 2011 20:55:06 +0200
Received: from 104.9.95.91.static.g-va.siw.siwnet.net ([91.95.9.104])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 04 May 2011 20:55:06 +0200
Received: from elupus by 104.9.95.91.static.g-va.siw.siwnet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 04 May 2011 20:55:06 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Antonio Ospite <ospite <at> studenti.unina.it> writes:

> 
> Hi,
> 
> this is another attempt to get the sixaxis plugin merged upstream in
> bluez, now cable pairing is done without libusb, which is good because
> the hid driver does not need to be detached anymore.

A friendly bump on this. I would very much like to be able to get rid of our 
special python BTHID driver to run the sixaxis as a controller for XBMC.

/elupus

