From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: even newer version of USB HID autosuspend
Date: Fri, 5 Oct 2007 18:36:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710051827040.25413@twin.jikos.cz>
References: <200710051329.23385.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710051329.23385.oliver@neukum.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Oliver Neukum <oliver@neukum.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-input@vger.kernel.org

On Fri, 5 Oct 2007, Oliver Neukum wrote:

> Please review and/or test.

Hi Oliver,

thanks a lot for taking care of this, I will look at it and give it some 
testing ASAP.

I am still surprised how large this patch has to be ...

> This leaves me with a planning difficulty. For keyboards it is not fully 
> transparent. The LEDs are switched off when then keyboard is suspended. 
> Should I now implement a mode where active LEDs block suspension and if 
> so, how do I switch it on?

Maybe module parameter of usbhid could be used to specify the desired 
behavior?

Thanks,

-- 
Jiri Kosina
