From: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: [PATCH] Input: document the proper usage of EV_KEY and KEY_UNKNOWN
Date: Wed, 20 Jun 2007 12:21:16 +0200
Message-ID: <4678FF9C.2050700@aitel.hist.no>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <20070601012928.GD5407@khazad-dum.debian.net> <20070601014453.GA3711@srcf.ucam.org> <200705312333.11477.dtor@insightbb.com> <20070601040824.GA5042@srcf.ucam.org> <20070601141910.GB8211@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070601141910.GB8211@khazad-dum.debian.net>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Dmitry Torokhov <dtor@insightbb.com>, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Fri, 01 Jun 2007, Matthew Garrett wrote:
>   
>> On Thu, May 31, 2007 at 11:33:10PM -0400, Dmitry Torokhov wrote:
>>     
>>> On Thursday 31 May 2007 21:44, Matthew Garrett wrote:
>>>       
>>>> It's not trivial at all. You need to introduce a mechanism for noting a 
>>>> KEY_UNKNOWN keypress. It then needs to signal the user (dbus is probably 
>>>> the best layer for this), but you need to ensure that you only signal 
>>>> the user who is currently at the keyboard. This needs to be presented to 
>>>> the user via some sort of UI, which will then need to signal some sort 
>>>> of privileged process to actually change the keymap.
>>>>         
>>> Not necessarily priveleged - you most likely already change ownership
>>> of event devices to user who is logged at console (so your force feedback
>>> joysticks work).
>>>       
>> If you let users alter the kernel keymap, then you need to implement 
>> support for resetting the kernel keymap on exit. Otherwise it's a 
>> trivial DoS.
>>     
>
> True, and unfortunately this is not something that can be done right with
> what we have now and playing with udev.  Oh dear, I was too hasty to think
> that we had all the infrastructure needed already...
>
> Changing system-wide keymap should be a privileged operation.  Changing
> per-user keymaps should not screw up any system-wide keymap changes made by
> the administrator, and it needs to go away for the next user.
>
> And for multi-user systems, you likely need to be able to switch keyboard
> maps when VTs are switched.   This does not look like an easy thing to fix
> properly.
>   
 From a design standpoint, keyboard layour should obviously
be a per-VT thing. One mapping table per VT, switching happening
automatically as every keypress gets filtered throught the
current VT.

Simple design, but perhaps that is more work than anyone
care to do on the current stuff. It can also be argued that the
actual keyboard necessarily is the same for all VT's, so
they ought to all use the same layout. If my "x" is in an
odd place, then it is so for all VT's, if there are "volume control"
buttons, then they exist for all VT's and so on.

In the multiseat case there are several possibly dissimiliar
keyboards, but then they have separate event devices too.


Helge Hafting
