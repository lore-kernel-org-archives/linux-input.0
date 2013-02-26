From: Jean-Michel Bruenn <jean.bruenn@ip-minds.de>
Subject: Re: Solution to get Gigabyte K8100 Aivia USB Gaming Keyboard
 working in Linux
Date: Tue, 26 Feb 2013 09:38:17 +0100
Message-ID: <20130226093817.47cb864c4616d1856ed98ca5@ip-minds.de>
References: <20130224171937.1bf957f01fb482186cbb134d@ip-minds.de>
	<20130224180432.ad426fe776ea113f2ec65d37@ip-minds.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from alia.ip-minds.de ([84.201.38.2]:48334 "EHLO alia.ip-minds.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759635Ab3BZIiU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Feb 2013 03:38:20 -0500
Received: from vulkan (p5B10A914.dip.t-dialin.net [91.16.169.20])
	by alia.ip-minds.de (Postfix) with ESMTPA id D37D2C32092
	for <linux-input@vger.kernel.org>; Tue, 26 Feb 2013 09:39:00 +0100 (CET)
In-Reply-To: <20130224180432.ad426fe776ea113f2ec65d37@ip-minds.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hey,

so the fix using shift+ctrl+alt+n works; However, I have to do that on
every boot. Is there some way to debug what happens if I press shift
+ctrl+alt+n / +g so that one could add a patch which allows the use of
this keyboard in linux without pressing shift+ctrl+alt+n? And should
the "gaming"-mode be fixed as well (would require to higher the
HID_MAX_USAGES value) would it be possible to add an if or something
(I'm not a kernel-/driver developer, so I really don't know if that's
bad practise or something) like "if keyboard == .. HID_MAX_USAGES.."
That'd solve the gaming-mode of the keyboard and it wouldn't require
the key-combo to make it work in Linux.

Thanks in advance,
jean
