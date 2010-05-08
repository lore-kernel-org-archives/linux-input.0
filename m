From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 0/2 v2] elantech: Additional info reporting with version 2
Date: Sat, 08 May 2010 18:34:51 +0200
Message-ID: <4BE592AB.7040801@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:42607 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab0EHQjS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 May 2010 12:39:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hello,

Will follow a second version of my patches to support more information
in the hardware version 2 of elantech. The main changes is that I've
done much further reverse engineering on the protocol, and found out that:
 * the width is acutally reported on 6 bits (not just 4)
 * the coordinates of the three finger touch are rerported as a one
finger touch
 * it's possible to differentiate between 3 and 4 fingers touch

The second patch to add MT support has only be adapted to work better
with mousedev, as suggested by Dmitry.

Patches are against git input-linux for-linus.

See you,
Eric
