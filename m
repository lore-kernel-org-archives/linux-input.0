From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [Linux-usb-users] reset low speed USB device using uhci_hcd (fwd)
Date: Fri, 16 Mar 2007 10:06:24 -0400
Message-ID: <d120d5000703160706p67f51d31i5312df2de3c1a3cc@mail.gmail.com>
References: <Pine.LNX.4.44L0.0703160953100.3349-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.44L0.0703160953100.3349-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Jiri Kosina <jkosina@suse.cz>, Claas Langbehn <claas@rootdir.de>
List-Id: linux-input@vger.kernel.org

On 3/16/07, Alan Stern <stern@rowland.harvard.edu> wrote:
> Take a look at the message below.  It turned out that the USB errors went
> away when Claas removed a USB extension cable, but that doesn't explain
> the peculiar keyboard-mouse interaction -- especially since it's a PS/2
> keyboard.  Any ideas?
>

Going on a limb here - faulty USB cable causes USB resets which throws
off legacy emulation (which is done in SMM as well as KBC controller)
which causes KCB to lose bytes. I would expect also seeing some
keypresses not being registered but losing release is much more
visible...

-- 
Dmitry
