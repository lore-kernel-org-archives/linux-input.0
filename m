From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [1/2] Revert "HID: multitouch: enable palm rejection if device
 implements confidence usage"
Date: Wed, 29 Jun 2016 13:31:47 -0500
Message-ID: <57741413.5050009@dell.com>
References: <1466670690-77458-1-git-send-email-allen_hung@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:12954 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbcF2Sbw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2016 14:31:52 -0400
In-Reply-To: <1466670690-77458-1-git-send-email-allen_hung@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Allen Hung <allen_hung@dell.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

> I've applied the series to hid.git#for-4.7/upstream-fixes

Hi Jiri,

Would you also submit this to -stable? 
I think it should be generally applicable at least a few releases back
since Allen's original submit.

Thanks,
