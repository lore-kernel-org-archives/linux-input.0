From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: [PATCH 0/1] tsc2007: Cancel work sync, increase polling frequency,
 make exit platform hw callback optional
Date: Thu, 09 Jul 2009 18:52:58 +0200
Message-ID: <4A56206A.5020601@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:34620 "EHLO
	av10-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757792AbZGIQxH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 12:53:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, kwangwoo.lee@gmail.com, Thierry Reding <thierry.reding@avionic-design.de>, soni.trilok@gmail.com

This patch is to be applied after my previous two for the
TSC2007.

I send it as a new patch, since my previous two are applied
to the -mm-tree.

The idea is to:
cancel the work using the _sync version, to make sure any
running "work" is finished.
Increase the polling frequency while the screen is touched,
to reduce the risk of missing taps.
Make the exit_platform_hw callback optional since it's not
needed on all platforms.

The changes are one-liners so they are all in one patch.

--Richard
