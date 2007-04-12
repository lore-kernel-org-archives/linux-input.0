From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/7] usbhid: quirks cleanup, add dynamic quirks, ConfigFS
 interface
Date: Thu, 12 Apr 2007 18:51:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704121832020.19492@jikos.suse.cz>
References: <Pine.LNX.4.64.0704110003460.28726@utopia.booyaka.com>
 <Pine.LNX.4.64.0704111440330.5079@jikos.suse.cz> <Pine.LNX.4.64.0704111635590.5079@jikos.suse.cz>
 <Pine.LNX.4.64.0704111231010.28726@utopia.booyaka.com>
 <Pine.LNX.4.64.0704121737130.12991@twin.jikos.cz>
 <Pine.LNX.4.64.0704120945571.9207@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0704120945571.9207@utopia.booyaka.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Paul Walmsley <paul@booyaka.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Joel Becker <joel.becker@oracle.com>
List-Id: linux-input@vger.kernel.org

On Thu, 12 Apr 2007, Paul Walmsley wrote:

> Now, another implementation approach would be to get rid of the quirk 
> type names entirely, to use a path such as:
> 
>  /usbhid/quirks_runtime/<vendor_id>:<product_id>
> 
> with the last component being a r/w configfs attribute containing the quirks
> value.  Is that what you are proposing?  I considered it when I did the
> initial implementation.  The problem with it is that there seems to be no way
> for userspace to create new configfs files/attributes -- only configfs
> directories.

Yes, this was my very original thought - I really somehow don't think that 
having to duplicate every new quirk is a nice solution. Joel, is there any 
specific reason why configfs doesn't allow this please?

Or we could reconsider going back to the idea of using sysfs.

Thanks a lot,

-- 
Jiri Kosina
SUSE Labs
