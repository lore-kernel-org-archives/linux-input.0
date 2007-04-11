From: Peter Osterlund <petero2@telia.com>
Subject: Re: Fix sudden warps in mousedev
Date: Wed, 11 Apr 2007 23:51:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704112349490.4764@p4.localdomain>
References: <20070324001610.724a820a.zaitcev@redhat.com>
 <d120d5000703261230h1724e453je2c14769fc099ad3@mail.gmail.com>
 <20070326144206.93805eeb.zaitcev@redhat.com> <200703262114.45287.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200703262114.45287.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Mon, 26 Mar 2007, Dmitry Torokhov wrote:

> On Monday 26 March 2007 17:42, Pete Zaitcev wrote:
>>
>> I don't think that you need to concern yourself with this too much
>> at present. If X11 people (e.g. Kristian) present evidence that kernel
>> fails to deliver an event, then we'll look at it. However it might
>> help if evtest continued to work when X11 reads from /dev/input/eventN.
>> It was an unpleasant surprise that it doesn't.
>
> The driver grabs tochpad with EVIOCGRAB ioctl to prevent input events
> from bveing delivered to X through /dev/input/mice which is still in
> whidespread use. That's why evtest does not work. We could as Peter
> (CCed) to implement an option to turn off grabbing so users who don't
> use mousedev multiplexor can use evtest and other commands.

That sounds like a useful option. Implemented in my git tree:

git clone http://web.telia.com/~u89404340/touchpad/synaptics/.git

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
