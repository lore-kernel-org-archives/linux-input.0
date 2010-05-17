From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Extended scancodes and input filtering
Date: Mon, 17 May 2010 16:58:11 +0100
Message-ID: <20100517155811.GA27311@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41705 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab0EQP6P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 May 2010 11:58:15 -0400
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.69)
	(envelope-from <mjg59@cavan.codon.org.uk>)
	id 1OE2ho-00078K-0u
	for linux-input@vger.kernel.org; Mon, 17 May 2010 16:58:12 +0100
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

If an i8042 input filter returns false then the byte will be dropped. 
This is unfortunate if it's the second byte of an extended scancode. 
We'd like to be able to drop some events if a platform driver consumes 
them, but right now it looks like bad things will happen in that case. 
The filtering is done at the i8042 layer, which has no knowledge of 
extended scancodes - and teaching it would look like a layering 
violation.

The simplest approach would seem to be to pass the data byte by 
reference rather than by value and then let the filter code change it to 
something that would then be an invalid scancode, but that presupposes 
that there's such a thing as an invalid scancode. Is there anything 
suitable here?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
