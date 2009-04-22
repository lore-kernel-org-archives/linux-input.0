From: Alessio Sangalli <alesan@manoweb.com>
Subject: Re: "soft" USB keyboard and mouse driver
Date: Wed, 22 Apr 2009 09:01:38 -0700
Message-ID: <49EF3F62.6020300@manoweb.com>
References: <49ED8857.9010809@manoweb.com> <alpine.LRH.2.00.0904221319520.18261@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59770 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbZDVQBt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Apr 2009 12:01:49 -0400
In-Reply-To: <alpine.LRH.2.00.0904221319520.18261@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Jiri Kosina wrote:

> I am not really sure I understand very well. So you have the device the 
> provides some "crippled" implementation of USB and provides some HID 
> devices on top of it, and you would like to have this compliant with the 
> kernel Input/HID infrastructure?

Yeah we can define it that way. It basically provides a low-speed USB
port to chips that do not have a USB controller and PHY. Yes, it sounds
disgusting, but sometimes it's the only way to use USB input devices to
embedded systems that do not have USB connectivity.

> If the devices are really HID (i.e. the protocol on the wire is proper HID 
> as defined by HID specification), you'd only need to implement a 
> specialized "transport" HID code for this transport protocol, and let the 
> HID core do the rest.

Well those are standard USB keyboard and mice, so what goes on the wire
is what is expected by those devices.


> Currently there are implementations for USB and Bluetooth which you can 
> look at.

Could you point me to a more specific example?

Thank you
Alessio


