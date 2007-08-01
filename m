From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: Cleaning up the USBHID's blacklist.
Date: Wed, 1 Aug 2007 14:11:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708011409460.26230@twin.jikos.cz>
References: <200707240228.39421.chunkeey@web.de> <200707301611.08758.chunkeey@web.de>
 <Pine.LNX.4.64.0707311038400.5747@twin.jikos.cz> <200707312324.06116.chunkeey@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200707312324.06116.chunkeey@web.de>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Chr <chunkeey@web.de>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

On Tue, 31 Jul 2007, Chr wrote:

> But I have one (final?) question. Since I am sometimes stuck to 80x25 
> console...
>  can we alphabetically sort the blacklist by the Vendor (the first 
> field), instead of the quirk field(last field)? Or is there a 
> technical/theoretical reason behind it?

I find the blacklist sorted by quirk type more convenient - we typically 
want to know "who has this particular quirk", but we generally don't care 
"what quirks does this particular vendor have".

-- 
Jiri Kosina
