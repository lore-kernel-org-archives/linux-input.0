From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH 0/7] usbhid: quirks cleanup, add dynamic quirks, ConfigFS
 interface
Date: Thu, 12 Apr 2007 10:14:13 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704120945571.9207@utopia.booyaka.com>
References: <Pine.LNX.4.64.0704110003460.28726@utopia.booyaka.com>
 <Pine.LNX.4.64.0704111440330.5079@jikos.suse.cz> <Pine.LNX.4.64.0704111635590.5079@jikos.suse.cz>
 <Pine.LNX.4.64.0704111231010.28726@utopia.booyaka.com>
 <Pine.LNX.4.64.0704121737130.12991@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0704121737130.12991@twin.jikos.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Thu, 12 Apr 2007, Jiri Kosina wrote:

> On Wed, 11 Apr 2007, Paul Walmsley wrote:
>
>> You're talking about using another static struct hid_blacklist array in
>> place of the struct hid_quirk_types array, right?
>
> no, in fact I was just thinking about extending the hid_blacklist[] with
> additional field 'name', which will be used for the purpose of configfs.
>
> This way we would not have to duplicate the entries anywhere. All the
> other fields you are currently keeping in hid_quirk_types[] could be made
> implicitly default, only 'name' is the one that matters, right?

Your last statement is correct.  The problem is that I don't see how the 
rest of what you describe would work in the current arrangement.  Maybe 
you could send an example of how your idea would work in terms of 
configfs.

Right now, there's only one configfs attribute (= filename) per quirk type 
- 23 of these.  Even if multiple dynamic device quirks are added, no new 
configfs attributes are created for each file; the old ones are simply 
reused.  The patch's current configfs directory structure is:

  /usbhid/quirks_runtime/<vendor_id>:<product_id>/<quirk type name>

...

Now, another implementation approach would be to get rid of the quirk type 
names entirely, to use a path such as:

  /usbhid/quirks_runtime/<vendor_id>:<product_id>

with the last component being a r/w configfs attribute containing the 
quirks value.  Is that what you are proposing?  I considered it when I did 
the initial implementation.  The problem with it is that there seems to be 
no way for userspace to create new configfs files/attributes -- only 
configfs directories.


- Paul
