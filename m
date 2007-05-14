From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: [PATCH] Make appletouch shut up when it has nothing to say
Date: Mon, 14 May 2007 02:19:55 +0200
Message-ID: <1179101995.25125.5.camel@localhost>
References: <1178995886.4168.10.camel@localhost>
	 <20070513172052.GA26712@srcf.ucam.org>
	 <20070513114626.d943999a.zaitcev@redhat.com>
	 <20070513195724.GA28493@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070513195724.GA28493@srcf.ucam.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-input@atrey.karlin.mff.cuni.cz, nicolas@boichat.ch, linux-usb-devel@lists.sourceforge.net, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, 2007-05-13 at 20:57 +0100, Matthew Garrett wrote:
> Ok, I've tidied this up a little. I've separated the actual mode init 
> code into a separate function in order to avoid code duplication, and no 
> longer creating a new workqueue. The only other change is something that 
> I /think/ is actually a bug in the driver to begin with, but I'd like 
> some more feedback on that first - the first packet sent after the mode 
> change has 0x20 in the final byte. This seems to be interpreted as a 
> left mouse button press. As a result, moving the touchpad sends a false 
> press after every reinitialisation, or (approximately) every time the 
> pointer is moved. As far as I can tell this also happens with the 
> existing code, but is probably not noticable there because it won't 
> appear again after the first touch on the pad. Just skipping that case 
> seems to work fine.

This patch indeed fixes the problem and I have yet to observe problems
with it... However I don't know whether a re-init is the intended way of
dealing with it...

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
