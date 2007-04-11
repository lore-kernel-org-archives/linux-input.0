From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH 0/7] usbhid: quirks cleanup, add dynamic quirks, ConfigFS
 interface
Date: Wed, 11 Apr 2007 12:43:18 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704111231010.28726@utopia.booyaka.com>
References: <Pine.LNX.4.64.0704110003460.28726@utopia.booyaka.com>
 <Pine.LNX.4.64.0704111440330.5079@jikos.suse.cz> <Pine.LNX.4.64.0704111635590.5079@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0704111635590.5079@jikos.suse.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 11 Apr 2007, Jiri Kosina wrote:

> On Wed, 11 Apr 2007, Jiri Kosina wrote:
>
>> - [7/7] I agree with using configfs. What is quite unfortunate is that
>>   adding a new quirk requires now another place that it is necessary to
>>   modify - forgetting to do it and keeping configfs values out-of-sync
>>   seems rather easy mistake to do. But I am not able to come with an idea
>>   immediately how to make it better.
>
> Maybe just reusing hid_blacklist and extending it with 'name' column for
> the purposes of configfs would suffice? (ca_mode and ca_owner could be
> made default implicitly I guess).

Hi Jiri,

You're talking about using another static struct hid_blacklist array in 
place of the struct hid_quirk_types array, right?  We could do that, but I 
don't see how it would solve the problem of having two places to update 
when a new quirk type is added - both the #defines and the new 
hid_blacklist array would still need to be changed.  But maybe I'm 
misunderstanding what you're proposing...

One other way to do it would be to remove the HID_QUIRK* #defines and to 
call find_quirk_bits_by_name() instead, which iterates over struct 
hid_quirk_types.  Comparatively slower than a preprocessor define, but 
then again this code isn't in a fast path anyway...


- Paul
