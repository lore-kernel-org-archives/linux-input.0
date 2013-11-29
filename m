From: Matt Walker <matt.g.d.walker@gmail.com>
Subject: [Patch] Fix for so that recent Elantech touchpads are recognized as such
Date: Thu, 28 Nov 2013 19:00:17 -0500
Message-ID: <CA+X2d=AuAm3ENDbrfk7L5fXoSiLwVU5xxKVo+MbbCf_aWu=cyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7bd6b9acf5373904ec458348
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37971 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab3K2AAT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Nov 2013 19:00:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: backports@vger.kernel.org, linux-input@vger.kernel.org

--047d7bd6b9acf5373904ec458348
Content-Type: text/plain; charset=ISO-8859-1

Hello,

Attached is a patch for drivers/input/mouse/elantech.c.  It allows
recent Elantech touchpads to be detected.  I have tested it on the
touchpad that comes with the Acer Aspire S7-392 (released ~August
2013)

I figure it could be backported with little effort and no danger,
since all it does it add one to the number of values that were
previously recognized as valid "firmware version numbers".

Begin Patch:
1315a1316
>         case 8:
End Patch

Best,
Matt

--047d7bd6b9acf5373904ec458348
Content-Type: text/x-patch; charset=US-ASCII; name="elantech.patch"
Content-Disposition: attachment; filename="elantech.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hoknzxnr0

MTMxNWExMzE2Cj4gCQljYXNlIDg6Cg==
--047d7bd6b9acf5373904ec458348--
