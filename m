From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Communicating tablet mode status to userspace
Date: Tue, 2 Oct 2012 23:39:56 +0100
Message-ID: <20121002233956.71b805e4@pyramind.ukuu.org.uk>
References: <CAMLZHHS80_zdmgVtJ87w+fuQGC05yj+EoJt3C_zBC7hkyhnaoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:52860 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197Ab2JBWfF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Oct 2012 18:35:05 -0400
In-Reply-To: <CAMLZHHS80_zdmgVtJ87w+fuQGC05yj+EoJt3C_zBC7hkyhnaoQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, hadess@hadess.net, Carlos Garnacho <carlosg@gnome.org>

> The change event would (presumably) trigger libudev's udev_monitor,
> which would be used by the on-screen keyboard software (maliit) to
> change its behaviour according to the property value.
> 
> Does this sound like a sensible plan, would these udev and kernel
> changes be acceptable? Or is there a better option that I'm missing?

Seems reasonable to me - but remember that a device can be in both tablet
and non tablet modes at once to different users once you have a wireless
display.

ie it's really not "tablet mode" it's "does this particular interface
have a keyboard"



