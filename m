From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH 0/7] usbhid: quirks cleanup, add dynamic quirks, ConfigFS
 interface
Date: Thu, 12 Apr 2007 14:27:49 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704121419570.9207@utopia.booyaka.com>
References: <Pine.LNX.4.64.0704110003460.28726@utopia.booyaka.com>
 <Pine.LNX.4.64.0704111440330.5079@jikos.suse.cz> <Pine.LNX.4.64.0704111635590.5079@jikos.suse.cz>
 <Pine.LNX.4.64.0704111231010.28726@utopia.booyaka.com>
 <Pine.LNX.4.64.0704121737130.12991@twin.jikos.cz>
 <Pine.LNX.4.64.0704120945571.9207@utopia.booyaka.com>
 <Pine.LNX.4.64.0704121832020.19492@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0704121832020.19492@jikos.suse.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Joel Becker <joel.becker@oracle.com>
List-Id: linux-input@vger.kernel.org

On Thu, 12 Apr 2007, Jiri Kosina wrote:

> On Thu, 12 Apr 2007, Paul Walmsley wrote:
>
>> Now, another implementation approach would be to get rid of the quirk
>> type names entirely, to use a path such as:
>>
>>  /usbhid/quirks_runtime/<vendor_id>:<product_id>
>>
>> with the last component being a r/w configfs attribute containing the quirks
>> value.  Is that what you are proposing?  I considered it when I did the
>> initial implementation.  The problem with it is that there seems to be no way
>> for userspace to create new configfs files/attributes -- only configfs
>> directories.
>
> Yes, this was my very original thought - I really somehow don't think that
> having to duplicate every new quirk is a nice solution. Joel, is there any
> specific reason why configfs doesn't allow this please?

well, another approach would be to go to a layout like:

/usbhid/blacklist/<vendor_id>:<product_id>/quirks

in such a model, individual files would not have to be created or removed.

Personally I think that having the quirk names broken out as individual 
files is more in line with the idea of 'one file per config attribute' 
that comes up in both the sysfs and configfs documentation.  Besides, the 
worst thing that can happen if someone updates the HID_QUIRK #defines, but 
not hid_quirk_types[], is that the quirk won't be readable or modifiable 
from userspace, until someone fixes the mismatch.

But ultimately, I don't think the choice of approach matters all that 
much, really.  It's pretty marginal functionality.


- Paul
