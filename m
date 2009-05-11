From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] hid: add force feedback support for SmartJoy PLUS PS2/USB
 adapter
Date: Mon, 11 May 2009 17:53:48 +0200
Message-ID: <4A084A0C.3070500@suse.cz>
References: <20090508074636.16912.55839.stgit@fate.lan> <alpine.LNX.2.00.0905111712410.22712@wotan.suse.de> <4A0848E7.9080301@suse.cz> <alpine.LNX.2.00.0905111749530.22712@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:14185 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598AbZEKPxr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2009 11:53:47 -0400
In-Reply-To: <alpine.LNX.2.00.0905111749530.22712@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On 05/11/2009 05:51 PM, Jiri Kosina wrote:
>> So I think, in this particular case, it is OK to have the conditional 
>> line in there.
> 
> Actually this should be the case at least for
> 
> - all drivers which implement only force feedback features
> - all drivers which only add additional key mappings

Yeah, this is correct point and it looks very scary. Let me think about it.
