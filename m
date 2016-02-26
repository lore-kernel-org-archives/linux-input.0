From: Stefan =?utf-8?b?TMO2d2Vu?= <stefan.loewen@gmail.com>
Subject: Re: Fake =?utf-8?b?S0VZXzU=?= continuous keydown events with Logitech wireless keyboard on Kernel 4.2
Date: Fri, 26 Feb 2016 10:50:46 +0000 (UTC)
Message-ID: <loom.20160226T114609-429@post.gmane.org>
References: <20151106115053.487d81b7@recife.lan> <CAN+gG=EOH==YHscYL6V5PNBNbzH-xZ3pdBLd3S=UqzFnsCykbQ@mail.gmail.com> <CAM4jgCqJ0A3xpg2OGa-3Yd_APnHW9kObfO_dvS_ZO_Nb0gOdpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38622 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753476AbcBZKzM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Feb 2016 05:55:12 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1aZG35-0003xn-8I
	for linux-input@vger.kernel.org; Fri, 26 Feb 2016 11:55:03 +0100
Received: from aftr-37-201-213-201.unity-media.net ([37.201.213.201])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 26 Feb 2016 11:55:03 +0100
Received: from stefan.loewen by aftr-37-201-213-201.unity-media.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Fri, 26 Feb 2016 11:55:03 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hey,

I experience the same bug on openSUSE 42.1

$ uname -a
Linux suse 4.1.15-8-default #1 SMP PREEMPT Wed Jan 20 16:41:00 UTC 2016 
(0e3b3ab) x86_64 x86_64 x86_64 GNU/Linux

Keyboard: Logiteck MK700

Also posted my info to https://bugzilla.redhat.com/show_bug.cgi?id=1278818

Has any progress been made on this? Can I support any data for debugging?

