From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Trying to remap a wrongly labelled key
Date: Wed, 04 Feb 2009 12:52:11 +0000
Message-ID: <1233751931.30414.715.camel@cookie.hadess.net>
References: <1232640514.3330.665.camel@cookie.hadess.net>
	 <alpine.LRH.1.10.0902021329210.22097@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:54181 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757137AbZBDMwN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Feb 2009 07:52:13 -0500
In-Reply-To: <alpine.LRH.1.10.0902021329210.22097@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Mon, 2009-02-02 at 13:32 +0100, Jiri Kosina wrote:
<snip>
> Hi Bastien,

Hey Jiri,

> for HID devices, the 'scancode' is in fact the full usage as reported by 
> the device (i.e. including the HID usage page), not only the usage code 
> itself. I.e. in your case this should be 0xc0183.

Good catch, thanks. FYI, hal-info patch is now done:
http://thread.gmane.org/gmane.comp.freedesktop.hal/12792

Just need to move onto the next keyboard now :)

Cheers

