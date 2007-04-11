From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/7] usbhid: quirks cleanup, add dynamic quirks, ConfigFS
 interface
Date: Wed, 11 Apr 2007 16:37:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704111635590.5079@jikos.suse.cz>
References: <Pine.LNX.4.64.0704110003460.28726@utopia.booyaka.com>
 <Pine.LNX.4.64.0704111440330.5079@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0704111440330.5079@jikos.suse.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Paul Walmsley <paul@booyaka.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 11 Apr 2007, Jiri Kosina wrote:

> - [7/7] I agree with using configfs. What is quite unfortunate is that 
>   adding a new quirk requires now another place that it is necessary to 
>   modify - forgetting to do it and keeping configfs values out-of-sync 
>   seems rather easy mistake to do. But I am not able to come with an idea 
>   immediately how to make it better.

Maybe just reusing hid_blacklist and extending it with 'name' column for 
the purposes of configfs would suffice? (ca_mode and ca_owner could be 
made default implicitly I guess).

Thanks,

-- 
Jiri Kosina
SUSE Labs
