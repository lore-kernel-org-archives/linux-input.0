From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 0/2] Input: VMMouse driver
Date: Sun, 12 Apr 2015 23:07:49 -0700
Message-ID: <1428905271-3416-1-git-send-email-thellstrom@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:45220 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751227AbbDMGIE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2015 02:08:04 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com, dmitry.torokhov@gmail.com

Hi!
The first patch adds a VMMouse protocol extension to the VMMouse driver=
=2E
The second patch stops the Joydev driver from recognizing the VMMouse a=
s a
Joystick. There might perhaps be better ways of doing this,
I'm open to suggestions.

Thanks,
Thomas Hellstr=C3=B6m


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
