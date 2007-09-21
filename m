From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: detecting when keys are being pressed on a keyboard
Date: Fri, 21 Sep 2007 14:47:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709211444560.22331@twin.jikos.cz>
References: <200709211033.09698.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200709211033.09698.oliver@neukum.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

On Fri, 21 Sep 2007, Oliver Neukum wrote:

> I got the strange case of a keyboard going into autosuspend while a key 
> was being pressed. The key release never arrived and I had to unplug the 
> keyboard to get the key unstuck. Is there a clean way to learn from 
> hid-core.c if a keyboard has keys pressed?

Hi Oliver,

HID doesn't keep any permanent state by itself. If you want to know 
whether a given key is currently pressed or not, you'd have to inspect the 
bitfields inside input_dev*, I am afraid.

-- 
Jiri Kosina
