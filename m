From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH] usbhid: add ASUS LCM to the blacklist
Date: Mon, 30 Jul 2007 14:45:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707301440020.5747@twin.jikos.cz>
References: <200707240228.39421.chunkeey@web.de> <20070726152709.6daa1c96.akpm@linux-foundation.org>
 <200707270110.01135.chunkeey@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200707270110.01135.chunkeey@web.de>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Christian Lamparter <chunkeey@web.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Fri, 27 Jul 2007, Christian Lamparter wrote:

> Some of ASUS' notebooks (e.g G Series) include a tiny oled display, which is 
> attached to an internal USB bus. Unfortunatly the device reports a wrong
> DeviceDescriptor and is therefore identified as a HID device...

Hi Christian,

I have slightly modified your patch (let's keep the hid_blacklist[] 
properly sorted) and applied it into my tree.

Thanks,

-- 
Jiri Kosina
