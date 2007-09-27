From: Thomas Rohwer <tr@tng.de>
Subject: Re: Problem with appletouch driver in Linux version 2.6.23-rc7
Date: Thu, 27 Sep 2007 23:08:20 +0200
Message-ID: <46FC1BC4.5050405@tng.de>
References: <46F54D92.7000300@tng.de>	 <d120d5000709240540ic91832em277a6bcbb399cd45@mail.gmail.com>	 <1190638998.12782.0.camel@localhost> <46F7BA08.6000201@tng.de>	 <1190836596.1359.33.camel@localhost>	 <d120d5000709261313j16f9612fx7d445b707df7784b@mail.gmail.com> <1190915501.7636.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1190915501.7636.4.camel@localhost>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-input@vger.kernel.org

>>> I think there is another bug in this. I mean whenever a mouse button is
>>> pressed or the mouse is moved the counter should be reset - no?
>>>
>>> Currently the idle counter is just increased...
>>>
>>> I mean shouldn't it be
>>>
>>> if (x || y || key)
>>>        dev->idlecount=0;
>>>
>>> if (!x && !y && !key)
>>> {
>>>        dev->idlecount++;
>>>        if (dev->idlecount == 10) {
>>>                dev->valid = 0;
>>>                schedule_work(&dev->work);
>>>        }
>>> }

Hello,

I agree that this is makes sense. I was wondering if one can remove the whole
idlecount logic. I tried replacing 10 with 1. This almost works; only if you press
the touchpad button, after a reset happened, you first get a usb packet with the
button state still 0 and after that one with button 1. I.e. with count 1 instead of 10
you reset the device another time in this case. But one could handle this case separately.
I am currently working with 2 instead of 10.

I was also wondering when the procedure atp_reinit is executed after using schedule_work.
Can it happen that atp_complete is called (even multiple times) before atp_reinit is executed?

Sincerely,

Thomas Rohwer
