From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH 2/6] usbhid: move all quirk handling code and data to
 usb-quirks.[ch]
Date: Mon, 16 Apr 2007 10:21:30 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704161020340.25900@utopia.booyaka.com>
References: <Pine.LNX.4.64.0704111256240.28726@utopia.booyaka.com>
 <alpine.LRH.0.98.0704161109170.24673@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <alpine.LRH.0.98.0704161109170.24673@twin.jikos.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Mon, 16 Apr 2007, Jiri Kosina wrote:

> actually, this seems wrong to me. In case of Wacom or IOWarrior devices, we 
> want the usb_hid_configure() to return immediately, without claiming the 
> device (and propagate -ENODEV through hid_probe()). That's what the original 
> code does, and that is correct.
>
> After you patch, the usb_hid_configure() proceeds both for Wacom and 
> IOWarrior devices, just leaving the quirks mask empty. But that's not what it 
> should do, right?

Yes, you're right.  I'll fix that in the revision that I will send to you.


- Paul
