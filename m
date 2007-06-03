From: Jan Kratochvil <honza@jikos.cz>
Subject: Re: [PATCH 3/4] xpad.c - support for xbox360 wireless receiver
Date: Sun, 3 Jun 2007 18:23:52 +0200 (CEST)
Message-ID: <alpine.LRH.0.98.0706031818450.22353@twin.jikos.cz>
References: <alpine.LRH.0.98.0706031601390.22353@twin.jikos.cz>
 <20070603153723.GA14913@rcn.com> <20070603155330.GB14913@rcn.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070603155330.GB14913@rcn.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Brian Magnuson <bdmagnuson@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hello,

On Sun, 3 Jun 2007, Brian Magnuson wrote:
> * Brian Magnuson <bdmagnuson@gmail.com> [2007-06-03 11:37]:
>> I can tell you without even testing that it's not going to work.  The data
>> length returned by the wireless controller is alway 29 bytes, but as far
>> as I can tell there is no field that indicates that length.
>
> Ok, looks like I was a bit hasty.  Looking at the data again there does
> appear to be a length field in the returned data however.
>
> 1) It's 19 bytes rather than 20.  This is a internel data format length
> though.  The USB data returned is still 29 bytes long.
> 2) You still need to apply to four byte shift for it to be in the "right"
> place.

Oic. I somehow missed the shift. Sorry for that. So in your process packet 
function you got 19 on position 5? And what is on last five bytes? I 
suppose that the rest is the same as in wired controller.

Thanks Jan
