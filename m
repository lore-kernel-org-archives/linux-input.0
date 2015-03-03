From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 4/4] thinkpad_acpi: Add support for more adaptive kbd
 buttons
Date: Tue, 3 Mar 2015 09:03:20 -0800
Message-ID: <20150303170320.GE83894@vmdeb7>
References: <1425303931.16791.35.camel@hadess.net>
 <1425316621.517951.234432209.03ABFEFA@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425316621.517951.234432209.03ABFEFA@webmail.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Bastien Nocera <hadess@hadess.net>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 02, 2015 at 02:17:01PM -0300, Henrique de Moraes Holschuh wrote:
> On Mon, Mar 2, 2015, at 10:45, Bastien Nocera wrote:
> > This commit adds new elements to the ThinkPad keymaps, and
> > will send key events for keys for which an input.h declaration
> > exists.
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> 
> Reviewed-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

As I understand it, and how I interpret these tags, Reviewed-by is a superset of
Acked-by. Acked implies acceptance of the general idea, Reviewed implies a
careful code review. No need for both.

I'm queueing these for testing in the pdx86 tree because we've been discussing
that approach. However, I've asked Henrique to let me know how he prefers to
handle this driver.

-- 
Darren Hart
Intel Open Source Technology Center
