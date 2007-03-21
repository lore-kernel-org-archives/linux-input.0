From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH 0/7] usbhid: add load-time and run-time USB HID quirks
 configuration
Date: Wed, 21 Mar 2007 11:45:54 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0703211102480.13408@utopia.booyaka.com>
References: <Pine.LNX.4.64.0703182032400.21893@utopia.booyaka.com>
 <Pine.LNX.4.64.0703191408400.5030@twin.jikos.cz>
 <Pine.LNX.4.64.0703191322010.9906@utopia.booyaka.com>
 <Pine.LNX.4.64.0703201814560.5030@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0703201814560.5030@twin.jikos.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Jiri,

On Tue, 20 Mar 2007, Jiri Kosina wrote:

> What is your opinion on an alternative aproach - the hid_blacklist[] could
> stay intact, and the linked list in your patch will be used in a slightly
> different way - it will be used to define *exceptions* (which will be
> possible to be tuned in runtime) from hid_blacklist, rather than
> duplicating the information which is already present there?

That approach makes a lot of sense.  It provides runtime configurability, 
without the added memory costs involved with a big linked list or the 
product mask.  The best of both worlds.

> Anyway, I think that the possibility to modify the hid_blakclist[] in
> runtime could be useful. If you agree with the above and would care to
> redo the pathces in such way, I would be inclined to merge them.

Sounds good, I'll redo the patches.


- Paul
