From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/7] usbhid: quirks cleanup, add dynamic quirks, ConfigFS
 interface
Date: Wed, 11 Apr 2007 14:49:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704111440330.5079@jikos.suse.cz>
References: <Pine.LNX.4.64.0704110003460.28726@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0704110003460.28726@utopia.booyaka.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Paul Walmsley <paul@booyaka.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 11 Apr 2007, Paul Walmsley wrote:

> Much of this code could probably be shared with the Bluetooth HID 
> subsystem. I guess there's been some discussion about this recently.  
> If this code seems more appropriate to drivers/hid/, I'd be happy to 
> reshuffle it.

Hi Paul,

thanks a lot for taking care of this. I am really willing to have this 
functionality, so as soon as we settle it down, I am going to merge this.

Currently the handling of quirky HID devices in Bluetooth is rather 
trivial - I have added some time ago handling for bluetooth version of 
mighty mouse into bluetooth hid code (commit cb3fecc in Linus' tree). It 
is not clear now whether there will be a big overlap for usbhid and hidp 
quirk handling, or they are going to be different. So it's probably fine 
to leave it usbhid-specific for now. Later we will see what is the better 
option to reflect real world.

> Jiri, I think I've cleaned up most of the other coding style issues that you
> mentioned.  Please let me know if there's more that needs to be done.

I have a few rather simple notes to your patches. The most disturbing one 
for you probably is a query to do one more round of respinning, against 
current hid tree - there have been lots of code changes in the area you 
touch, which are queued for 2.6.22 merge window to open, so I would get 
huge reject when I just apply your patches. Sorry for that.

I could redo this myself, but I am not sure if I'll manage to find time 
for it by the end of the week. Thanks a lot.

- [2/7] it would help if you could respin against current hid.git tree. I 
  have already performed some time ago some of the tasks you did (like 
  consolidating the defines scattered around the hid-core.c (I also made 
  the blacklist sorted again), etc.). Also new quirks have been queued, 
  etc. I can do this myself, but it will take some time, before I process 
  other things in my queue :)
- [3/7] the same as above - there have been changes in this area which I 
  have queued for mainline merge in my tree, so just simple respin against 
  hid tree would help a lot. I'd also probably rename 
  usbhid_lookup_any_quirk() just to usbhid_lookup_quirk()  but that's not 
  a big deal
- at least [5/7] and [6/7] seem to have mangled whitespaces on some 
  certain places on a first sight, could you fix that please in the next 
  round?
- [7/7] I agree with using configfs. What is quite unfortunate is that 
  adding a new quirk requires now another place that it is necessary to 
  modify - forgetting to do it and keeping configfs values out-of-sync 
  seems rather easy mistake to do. But I am not able to come with an idea 
  immediately how to make it better.

Thanks,

-- 
Jiri Kosina
SUSE Labs
