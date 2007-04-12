From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH 0/7] usbhid: quirks cleanup, add dynamic quirks, ConfigFS
 interface
Date: Thu, 12 Apr 2007 17:39:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704121737130.12991@twin.jikos.cz>
References: <Pine.LNX.4.64.0704110003460.28726@utopia.booyaka.com>
 <Pine.LNX.4.64.0704111440330.5079@jikos.suse.cz> <Pine.LNX.4.64.0704111635590.5079@jikos.suse.cz>
 <Pine.LNX.4.64.0704111231010.28726@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0704111231010.28726@utopia.booyaka.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Paul Walmsley <paul@booyaka.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 11 Apr 2007, Paul Walmsley wrote:

> You're talking about using another static struct hid_blacklist array in 
> place of the struct hid_quirk_types array, right?  

Hi Paul,

no, in fact I was just thinking about extending the hid_blacklist[] with 
additional field 'name', which will be used for the purpose of configfs. 

This way we would not have to duplicate the entries anywhere. All the 
other fields you are currently keeping in hid_quirk_types[] could be made 
implicitly default, only 'name' is the one that matters, right?

Thanks,

-- 
Jiri Kosina
