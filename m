From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Thu, 12 Apr 2007 18:04:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704121800000.19492@jikos.suse.cz>
References: <1176330232.27324.7.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1176330232.27324.7.camel@johannes.berg>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>, Bart Massey <bart@cs.pdx.edu>
List-Id: linux-input@vger.kernel.org

On Thu, 12 Apr 2007, Johannes Berg wrote:

> This is not true. With this X configuration:
> 
>     Section "InputDevice"
>         Identifier  "EvDev"
>         Driver      "evdev"
>         Option      "SendCoreEvents"    "true"
>         Option      "evBits"            "+1-2"
>         Option      "keyBits"           "~272-287"
>         Option      "relBits"           "~0-2 ~6 ~8"
>         Option      "Pass"              "3"
>     EndSection
> I can scroll up in a window by moving my finger up, and scroll left in a
> window by moving my finger right. That makes no sense, this patch therefore
> removes the INVERT_HWHEEL quirk from the USB mightymouse.

Johannes, Bart, 

I unfortunately don't have the hardware in question to test with. This X 
configuration is of course perfectly valid.

Bart, as you wrote the original patch which inverted the wheel, could you 
provide some more information please? It seems to me that you guys have 
different versions of mightymouse ... but I wouldn't believe they would 
have the same PID :)

Thanks,

-- 
Jiri Kosina
SUSE Labs
