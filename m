From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [4/4] input: dynamically allocate ABS information
Date: Wed, 19 May 2010 23:18:19 +0200
Message-ID: <4BF4559B.7020202@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([91.198.169.22]:43965 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab0ESVSW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 17:18:22 -0400
Received: from [192.168.0.183] (c83-248-196-134.bredband.comhem.se [83.248.196.134])
	by csmtp2.one.com (Postfix) with ESMTP id 96F3C1B003849
	for <linux-input@vger.kernel.org>; Wed, 19 May 2010 21:18:20 +0000 (UTC)
References: 1274289757-2723-5-git-send-email-daniel@caiaq.de
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Since the patches are fairly intrusive, it would be good to get a little bit of
background in the patch description. How much memory is saved? What calls for
doing this now? Any cpu cycle side effects?

Henrik
