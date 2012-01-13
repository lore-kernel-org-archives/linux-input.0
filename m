From: Matthew Garrett <mjg@redhat.com>
Subject: Re: Handling special keys in platform drivers
Date: Fri, 13 Jan 2012 22:42:11 +0000
Message-ID: <20120113224211.GB29022@srcf.ucam.org>
References: <CAHR064jAJkQCd_Tsrx7NHe_RbaBbNcX4sMwy=zkZCZNUNo=fAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56065 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab2AMWmO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Jan 2012 17:42:14 -0500
Content-Disposition: inline
In-Reply-To: <CAHR064jAJkQCd_Tsrx7NHe_RbaBbNcX4sMwy=zkZCZNUNo=fAw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Mon, Jan 09, 2012 at 07:24:14AM +0100, Corentin Chary wrote:

> The real problem is that for keyboard backlight to work, it needs DE
> cooperation, and only gnome as implemented that right now, and other
> (except KDE) will probably neither have the resources to handle all
> the possible keys correctly. And of course, who should handle the keys
> when there is no DE running at all ?

The problem with handling this in kernel is that there isn't an 
obviously correct policy. ACPI will typically only expose 16 or so 
backlight levels so the behaviour is easy enough, but (depending on how 
the hardware is wired up) i915 may expose around 20,000. Further, one 
machine may expose different backlight controls for different displays, 
and in that situation you need to know which one the input event is 
expected to correspond to.

Doing backlight control properly involves a lot of policy work, and I'm 
reluctant to argue that that ought to be in the kernel.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
