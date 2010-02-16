From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Key for tablet rotation?
Date: Tue, 16 Feb 2010 21:17:14 +0000
Message-ID: <20100216211714.GA5071@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49906 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933260Ab0BPVRQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2010 16:17:16 -0500
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.69)
	(envelope-from <mjg59@cavan.codon.org.uk>)
	id 1NhUnC-0001LF-45
	for linux-input@vger.kernel.org; Tue, 16 Feb 2010 21:17:14 +0000
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Many tablet PCs have a button to indicate that the screen should be 
rotated from landscape to portrait mode. There's currently no 
standardisation here - a couple of drivers seem to be using 
KEY_DIRECTION, and others are just being mapped to arbitrary F keys. So:

1) What is KEY_DIRECTION supposed to be for?
2) If it's not suitable, do we still have space for a KEY_ROTATE?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
