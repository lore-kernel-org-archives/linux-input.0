From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mt: Interface and MT_TOOL documentation updates
Date: Fri, 10 Dec 2010 10:52:12 -0800
Message-ID: <20101210185211.GD1630@core.coreip.homeip.net>
References: <1291929732-5989-1-git-send-email-rydberg@euromail.se>
 <AANLkTi=mqMY_VG=0RdN5O0fDh6wpTRb5Z59L6440hvX6@mail.gmail.com>
 <4D026DB1.8070100@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D026DB1.8070100@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Ping Cheng <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Dec 10, 2010 at 07:13:05PM +0100, Henrik Rydberg wrote:
> >
> 
> > Can we make MT_TOOL_ENVELOPE cover a bit more cases by:
> > 
> > 1. Removing ", and is only used for legacy hardware";
> > 2. Adding "Or the number of contacts inside the bounding rectangle is
> > reported if hardware provides the number but not the real contact
> > positions" to the end of the paragraph.
> 
> 
> You might disagree, but "old" is still somewhat apt in this situation. How would
> you suggest we report the number of fingers?
> 

BTN_TOOL_xxxTAP I guess...

-- 
Dmitry
