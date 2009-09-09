From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: question about defkeymap.map "compose"
Date: Wed, 09 Sep 2009 16:12:32 +0800
Message-ID: <4AA76370.3010108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:45772 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbZIIITF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 04:19:05 -0400
Received: by yxe1 with SMTP id 1so42939yxe.21
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2009 01:19:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi list:
from defkeymap.map----------
compose '`' 'A' to '=E0=A4=A2'
compose '`' 'a' to '=E0=A5=86'
compose '\'' 'A' to '=E0=A4=A3'
compose '\'' 'a' to '=E0=A5=87'
compose '^' 'A' to '=E0=A4=A4'
compose '^' 'a' to '=E0=A5=88'
compose '~' 'A' to '=E0=A4=A5'

there is always three keys to generate '=E0=A4=A2''
is this possible to use two keys?




--=20
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
