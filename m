From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: How to properly extend uinput API
Date: Tue, 3 May 2016 19:22:47 +0200
Message-ID: <eab9d60a-9632-4478-1636-31ede3d1effa@m-reimer.de>
References: <51caa374-1fdc-bcc0-3aac-20292a77571b@m-reimer.de>
 <20160502183542.GC37394@dtor-ws>
 <74df5cb0-9bbb-835a-82ca-aa8527f4d024@m-reimer.de>
 <20160502225147.GD37394@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:47516 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933319AbcECRWv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 May 2016 13:22:51 -0400
In-Reply-To: <20160502225147.GD37394@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On 05/03/2016 12:51 AM, Dmitry Torokhov wrote:
> Nowhere in the memoryless code we have "2 motor values".

But it simulates a few supported events with FF_RUMBLE events.

> You are
> basically designing an API for single device and that is not a good
> idea.

Not for a single device, but for a big (if not the biggest) group of 
game controllers.

> Hmm, it should not, can you post some traces to show where it gets
> stuck so we can fix it?

Some time ago, Elias Vanderstuyft sent me a link to this thread:

http://comments.gmane.org/gmane.linux.kernel.input/44528

Maybe this helps to track down this problem?

> You should be able to take cues from the kernel code and create
> userspace library providing similar features, but in the way that is
> flexible and make sense in userspace.

Of course this should be possible. It just is far more difficult than 
just using what is already there.

While searching for examples to learn from, I've collected a few 
existing uinput projects using force feedback. 100% of them somehow try 
to drive two motors and would profit from some API making this common 
case more easy.

But if the recommended way is to do this in userspace, I will try to 
understand how ff-memless works to port it 1:1 to userspace. 
Unfortunately the kernel documentation 
(https://www.kernel.org/doc/Documentation/input/ff.txt) says:

| Note: In most cases you should use FF_PERIODIC instead of FF_RUMBLE.
|       *All* devices that support FF_RUMBLE support FF_PERIODIC
|       (square, triangle, sine) and the other way around.

So I guess game developers will not just send FF_RUMBLE and so I have to 
do some kind of simulation to get my rumble working.

If someone already has simple code which can be used from plain C, I 
would be happy to get a link to the repository.

Manuel
