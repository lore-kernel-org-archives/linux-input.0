From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [2.6 patch] drivers/hid/hid-debug.c should #include <linux/hid-debug.h>
Date: Wed, 21 Feb 2007 14:35:48 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0702211435430.10496@twin.jikos.cz>
References: <20070221115730.GG13958@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070221115730.GG13958@stusta.de>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 21 Feb 2007, Adrian Bunk wrote:

> Every file should include the headers containing the prototypes for
> it's global functions.

Applied, thanks.

-- 
Jiri Kosina
