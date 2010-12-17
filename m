From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [GIT PULL] input: mt updates for 2.6.38
Date: Fri, 17 Dec 2010 11:34:19 -0800
Message-ID: <20101217193419.GA2576@core.coreip.homeip.net>
References: <4D09F9E2.6060900@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D09F9E2.6060900@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Dec 16, 2010 at 12:37:06PM +0100, Henrik Rydberg wrote:
> Dmitry,
> 
> Please pull from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rydberg/input-mt.git next
> 
> to re-receive input-mt updates for 2.6.38.
> 
> As a one-time measure, the tree has been rewound all the way to 2.6.37-rc1, to
> keep our trees at a common checkpoint. Hereafter, the branch will be kept stable
> and synchronized at a common checkpoint.
> 
> Content-wise, the filename change has been folded into the first commit. The
> finger-count report and the trkid documentation have been folded into the commit
> where they are introduced. Furthermore, MT_TOOL_ENVELOPE has been dropped
> completely, and is going to be replaced by an input device quirk. The overall
> documentation changes have been held back for another respin. Lastly, another
> device patch has been added to hid-egalax.
> 

Pulled, thanks Henrik.

-- 
Dmitry
