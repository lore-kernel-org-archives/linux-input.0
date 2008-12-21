From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] USBHID: Make Boot Protocol drivers depend on EMBEDDED
Date: Sun, 21 Dec 2008 23:44:51 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0812212344140.26265@jikos.suse.cz>
References: <f7848160812201911k7988221asd095ce873fd8105f@mail.gmail.com> <20081220221253.e09b1b1f.akpm@linux-foundation.org> <f7848160812202226w1f930c86vfd17a2b0163bfc56@mail.gmail.com> <494E20F7.7050106@gmail.com> <f7848160812210717w5e5cc7a2uc5571710f755ec99@mail.gmail.com>
 <alpine.LRH.1.10.0812211824350.11630@twin.jikos.cz> <alpine.DEB.2.00.0812211441300.7101@parag-desktop> <alpine.LNX.1.10.0812212247090.26265@jikos.suse.cz> <20081221140200.40c1fec1.akpm@linux-foundation.org> <alpine.LNX.1.10.0812212302400.26265@jikos.suse.cz>
 <alpine.DEB.2.00.0812211708450.7101@parag-desktop> <494EC082.2010207@gmail.com> <alpine.DEB.2.00.0812211720050.7101@parag-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:40051 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751439AbYLUWow (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Dec 2008 17:44:52 -0500
In-Reply-To: <alpine.DEB.2.00.0812211720050.7101@parag-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Parag Warudkar <parag.lkml@gmail.com>
Cc: Anssi Hannula <anssi.hannula@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Sun, 21 Dec 2008, Parag Warudkar wrote:

> > It may well be that Ubuntu has usbmouse blacklisted or employs udev 
> > rules that force usbhid to be loaded before usbmouse.
> Right - Ubuntu blacklists it and it works. Fedora doesn't blacklist it but 
> it is not a problem with the distro shipped kernel - somehow. The problem 
> happens only when using vanilla kernel on Fedora - not sure what's going 
> on there. 

Do they even compile usbmouse and usbkbd?

-- 
Jiri Kosina
SUSE Labs
