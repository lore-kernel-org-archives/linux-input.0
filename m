From: Chase Douglas <chase.douglas@canonical.com>
Subject: elantech buttonpad devices
Date: Mon, 02 Apr 2012 11:43:56 -0700
Message-ID: <4F79F36C.8000503@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43164 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab2DBSnS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 14:43:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>, linux-input <linux-input@vger.kernel.org>

Hi JJ,

Now that we've added clickpad, or buttonpad, support in
xf86-input-synaptics, ensuring all the buttonpad devices are marked as
such by the linux drivers is important. Apparently, some Elantech
trackpads are buttonpads. What would it take to add support for setting
this input device property in the elantech driver?

Thanks!

-- Chase
