From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: psmouse - when comparing PNP IDs ignore case
Date: Mon, 2 Mar 2015 14:19:47 -0800
Message-ID: <20150302221947.GA30717@dtor-glaptop>
References: <20150228001852.GA18983@dtor-ws>
 <20150302221435.GA668@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150302221435.GA668@unpythonic.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jeff,

On Mon, Mar 02, 2015 at 04:14:37PM -0600, Jeff Epler wrote:
> On Fri, Feb 27, 2015 at 04:18:52PM -0800, Dmitry Torokhov wrote:
> > PNP IDs are supposed to be case-insensitive and so we should compare
> > them as such.
> 
> Have specific systems popped up which need this fix, or is it just in
> the interests of being correct?  If there are specific system(s) that
> are affected, it would be valuable to list them or at least say so.

It is needed by another patch identifying SYN300D as a forcepad whereas in
BIOS it is actually SYN300d. While we could change the kernel to match against
SYN300d I am not sure if somebody else won't use SYN300D in some other BIOS.

Thanks.

-- 
Dmitry
