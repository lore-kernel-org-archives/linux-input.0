From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH] input: change SysRq keycode for systems without SysRq
 key
Date: Fri, 17 Aug 2007 16:42:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708171638560.2460@twin.jikos.cz>
References: <alpine.LFD.0.999.0707151513550.20061@woody.linux-foundation.org>
 <d120d5000707160541k64c40d0dgf661226806fd98c8@mail.gmail.com>
 <469C647B.1000307@inwind.it> <d120d5000707170811l285d670aq3a9a1489a8cbb379@mail.gmail.com>
 <469E7E29.2050206@inwind.it> <d120d5000707191400w2725bbd1h64add33e3e227bdd@mail.gmail.com>
 <469FDA19.6020702@inwind.it> <d120d5000707191532x34ec7baen8e0de1155a4882cb@mail.gmail.com>
 <469FF3D9.4080307@inwind.it> <Pine.LNX.4.64.0707301556390.5747@twin.jikos.cz>
 <20070802212730.GA10153@suse.cz> <1187339112.3684.10.camel@localhost.localdomain>
 <Pine.LNX.4.64.0708171216160.2460@twin.jikos.cz> <1187361318.3684.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1187361318.3684.30.camel@localhost.localdomain>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Marvin Raaijmakers <marvin.nospam@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, federico ferri <xaero@inwind.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, mzxrlshmm@0pointer.de
List-Id: linux-input@vger.kernel.org

On Fri, 17 Aug 2007, Marvin Raaijmakers wrote:

> This code doesn't filter out the "status events" right? So that still
> needs to be done(?).

Hi Marvin,

I am not sure what you mean by that -- this patch is supposed to issue 
input_event(EV_MSC, MSC_SCAN) if and only if it would mean the change in 
key state.

-- 
Jiri Kosina
