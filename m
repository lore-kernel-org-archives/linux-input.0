From: Mark Lord <mlord@pobox.com>
Subject: Recent change to hid-core.c
Date: Sun, 15 Dec 2013 00:26:12 -0500
Message-ID: <52AD3D74.90905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3LOF0Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Dec 2013 00:26:24 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Jiri,

The recent update 08ec2dcc3527a20c619aca2fb36f800908256bac
 "Merge branches 'for-3.11/multitouch', 'for-3.11/sony' and 'for-3.11/upstream' into for-linus"
included an unexpected change to the return code handing for ->raw_event() calls.

A HID driver's raw_event() method previously could return these values:
   0 --> keep processing.
   1 --> no further processing required.
   <0 --> error.

Now, "1" and "0" are both treated as "keep processing",
so a lower level HID driver has to return a negative error code
to achieve the "no further processing required" state.

Was this intentional?  Doesn't that have side-effects for some drivers?

Thanks
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
