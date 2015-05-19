From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH -fixes 0/2] vmmouse fixes
Date: Tue, 19 May 2015 04:37:03 -0700
Message-ID: <1432035425-45514-1-git-send-email-thellstrom@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([208.91.2.12]:58472 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754400AbbESLhS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2015 07:37:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com

Patch 1 fixes up joydev to not recognize the vmmouse as a joystick. The
mouse detection heuristics should be improved, but IMHO it's too late in the
release cycle to do that. The second patch just fixes a user-space driver
version in the Kconfig help text.

