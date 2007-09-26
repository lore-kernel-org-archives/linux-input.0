From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] - drivers/hid/hid-debug.c  - trivial - add KERN_DEBUG
 prefix, fix typo, constify
Date: Wed, 26 Sep 2007 17:10:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709261708080.7567@jikos.suse.cz>
References: <1190771098.17052.12.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1190771098.17052.12.camel@localhost>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Joe Perches <joe@perches.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 25 Sep 2007, Joe Perches wrote:

> Also, exported symbol hid_resolv_event is unused by the current kernel 
> tree and perhaps should be removed.

This is not true, hid_resolv_event() is called from the code that 
establishes the mapping between HID and input, see 
hidinput_configure_usage().

Anyway, I applied your cleanup patch, thanks.

-- 
Jiri Kosina
SUSE Labs
