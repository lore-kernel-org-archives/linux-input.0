From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: hid_parse error
Date: Fri, 27 Apr 2012 18:22:49 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91710BAD8@ORSMSX104.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58240 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760116Ab2D0SWx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Apr 2012 14:22:53 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

The hid_parse fails with error -22 (EINVAL) for the LOGICAL MAX value of 0xffffffff.
Basically when it gets
"0x27,0xff, 0xff, 0xff, 0xff"  it fails.

With opcode 0x27, we can have 4 bytes of payload.
I see that in  hid-core.h, the logical_maximum is defined __s32. It is interpreting 0xffffffff as -1.

Is this correct?


Thanks,
Srinivas


