From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Reset ps/2 port should psmouse_probe fail before
	retrying
Date: Sat, 17 Apr 2010 13:01:38 +0200
Message-ID: <1271502098.4155.27.camel@lovely>
References: <4BC8EA42.6030507@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:13863 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756577Ab0DQK4S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Apr 2010 06:56:18 -0400
Received: by fg-out-1718.google.com with SMTP id d23so807284fga.1
        for <linux-input@vger.kernel.org>; Sat, 17 Apr 2010 03:56:17 -0700 (PDT)
In-Reply-To: <4BC8EA42.6030507@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: linux-input@vger.kernel.org, rubini@ipvvis.unipv.it

Am Freitag, den 16.04.2010, 18:52 -0400 schrieb Peter M. Petrakis:
> I filed a bug on this too:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=15780
> 
> This particular laptop will lose it's synaptics touch
> pad on return from suspend state.

> I came up with the attached work around which simply calls
> psmouse_reset on the port should the initial probe fail.

In i8042.c i8042_controller_selftest() gets also called after
suspending: So give it a try and add "i8042.reset=1" to your
kernel-parameters. If that works for you, add your device to the
i8042_dmi_reset_table in i8042-x86ia64io.h or tell us the output
of:
 cat /sys/class/dmi/id/product_name
 cat /sys/class/dmi/id/sys_vendor



