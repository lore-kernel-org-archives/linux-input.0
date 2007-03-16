From: Claas Langbehn <claas@rootdir.de>
Subject: Re: [Linux-usb-users] reset low speed USB device using uhci_hcd (fwd)
Date: Fri, 16 Mar 2007 15:28:06 +0100
Message-ID: <45FAA976.5050307@rootdir.de>
References: <Pine.LNX.4.44L0.0703161015290.3349-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.44L0.0703161015290.3349-100000@iolanthe.rowland.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Hello!

>> Going on a limb here - faulty USB cable causes USB resets which throws
>> off legacy emulation (which is done in SMM as well as KBC controller)
>> which causes KCB to lose bytes. I would expect also seeing some
>> keypresses not being registered but losing release is much more
>> visible...
>>     
>
> It's possible.  But the USB drivers try to take control of the host 
> controllers away from the SMM BIOS.  How could legacy support work with 
> both SMM and the Linux USBHID system trying to handle it?
>   
Please tell me what I can do to help to debug this strange behaviour.
Repuducing the USB resets is easy, but reproducing the PS/2 influence
takes long, since its hardly visible.


many regards,
claas
