From: Daniel Martin <daniel.martin@secunet.com>
Subject: synaptics: match PNP-Id is not sufficient for min/max quirks
Date: Thu, 22 Jan 2015 17:46:35 +0100
Message-ID: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:59049 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbbAVQlH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2015 11:41:07 -0500
Received: from localhost (alg1 [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id F17751A00AE
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2015 17:40:55 +0100 (CET)
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hnJnNXBmIF_E for <linux-input@vger.kernel.org>;
	Thu, 22 Jan 2015 17:40:54 +0100 (CET)
Received: from mail-essen-01.secunet.de (unknown [10.53.40.204])
	by a.mx.secunet.com (Postfix) with ESMTP id A60F91A00A9
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2015 17:40:54 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi folks,

these patches fix the problem described at:
    https://bugzilla.kernel.org/show_bug.cgi?id=91541#c0

I verified that the following models have the min/max dimensions we want
them to have afterwards:
    T440s (2013 and 2014),
    T440p (2014),
    T540p (2013 and 2014),
    X240 (2013),
    Helix (2013?) and
    X1 Carbon (2013, LEN0030).


Any comments are welcome,
    Daniel Martin
