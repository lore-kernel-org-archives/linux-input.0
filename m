From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: Gyration wireless USB mouse; key repeat problem
Date: Wed, 19 Sep 2007 16:45:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709191643480.24429@twin.jikos.cz>
References: <1190157109598@dmwebmail.japan.chezphil.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1190157109598@dmwebmail.japan.chezphil.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Phil Endecott <spam_from_linux_input@chezphil.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 19 Sep 2007, Phil Endecott wrote:

> I have attempted to reconcile the data from /dev/input/event with usbmon 
> traces, without much luck, i.e. I can't determine yet whether there is a 
> release event in the USB data.  Does anyone know how the timestamps in 
> usbmon and in /dev/input/event are related?  They are both microseconds, 
> but must be based differently I think.  I need to work out how to get 
> the actual data in the usbmon output rather than just "<"; I think this 
> might be a kernel version thing.

Hi Phil,

in this case, it might be much easier for you to look at the HID debug 
data, rather than the raw USB data given by usbmon.

I would suggest the following:

- grab any recent kernel (anything >= 2.6.23-rc1 is advised)
- compile the kernel with CONFIG_HID_DEBUG and modprobe the hid module 
  with 'debug=1' parameter

Then you'd get HID debugging data from the kernel. If you'd send them to 
me, I can have a look whether the release event arrived from the mouse or 
not.

Thanks,

-- 
Jiri Kosina
