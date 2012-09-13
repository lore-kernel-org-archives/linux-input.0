From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 05/20] Input: Send events one packet at a time
Date: Thu, 13 Sep 2012 19:59:31 +0200
Message-ID: <20120913175931.GA3178@polaris.bitmath.org>
References: <1346528835-363-1-git-send-email-rydberg@euromail.se>
 <1346528835-363-6-git-send-email-rydberg@euromail.se>
 <20120913065613.GG17105@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120913065613.GG17105@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> Filter handlers do not typically have ->event() methods, that's the
> reason for reported panic.

If we decide to rewind the tree, I will amend the fix here.

Thanks,
Henrik
