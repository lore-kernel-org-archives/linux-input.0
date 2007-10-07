From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: even newer version of USB HID autosuspend
Date: Sun, 7 Oct 2007 22:58:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710072256520.25413@twin.jikos.cz>
References: <200710051329.23385.oliver@neukum.org>
 <Pine.LNX.4.64.0710051827040.25413@twin.jikos.cz> <200710061115.53986.oliver@neukum.org>
 <200710071457.23780.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710071457.23780.dmitry.torokhov@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-input@vger.kernel.org

On Sun, 7 Oct 2007, Dmitry Torokhov wrote:

> I'd say do not autosuspend keyboards (and other led-equipped input 
> devices) unless user explicitely requested to do so 

Hi Dmitry,

we *must* do it this way anyway, due to too many USB keyboards being 
utterly broken when it comes to suspend support.

-- 
Jiri Kosina
