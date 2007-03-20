From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH 0/7] usbhid: add load-time and run-time USB HID quirks
 configuration
Date: Tue, 20 Mar 2007 18:26:07 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0703201814560.5030@twin.jikos.cz>
References: <Pine.LNX.4.64.0703182032400.21893@utopia.booyaka.com>
 <Pine.LNX.4.64.0703191408400.5030@twin.jikos.cz>
 <Pine.LNX.4.64.0703191322010.9906@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0703191322010.9906@utopia.booyaka.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Paul Walmsley <paul@booyaka.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Mon, 19 Mar 2007, Paul Walmsley wrote:

> > Also your solution cosumes significantly more memory (adding 16 bits to
> > every hid_blacklist entry, duplicating the information into list that in
> > most cases will stay intact and just mirror the contents of
> > hid_blacklist). Not that it's a big issue, but still worth noting.
> Right now there are about 160 entries in the hid_blacklist, so adding the mask
> costs about 320 bytes extra.  If that's a concern, a bigger issue is the
> list_head added to each hid_blacklist entry - two pointers per entry - so,
> 1280 bytes on a 32-bit machine (not counting the list head itself)

Hi Paul,

What is your opinion on an alternative aproach - the hid_blacklist[] could 
stay intact, and the linked list in your patch will be used in a slightly 
different way - it will be used to define *exceptions* (which will be 
possible to be tuned in runtime) from hid_blacklist, rather than 
duplicating the information which is already present there?

> If you'd rather not to have the mask code in the patch, I'll drop it. It's
> only in there to remove the runtime-immutable special-case code for Wacom and
> Codemercs devices, so it's not really useful for my specific concern.

My opinion is that two exceptions (wacom and codemercs) can be easily 
handled by few lines of code, and extending the hid_blacklist[] just 
because of these two users looks maybe a little bit over-generalized to 
me.

Anyway, I think that the possibility to modify the hid_blakclist[] in 
runtime could be useful. If you agree with the above and would care to 
redo the pathces in such way, I would be inclined to merge them.

Thanks,

-- 
Jiri Kosina
