From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v2] Input: atmel_mxt_ts - fix double free of input
 device
Date: Wed, 10 Sep 2014 11:07:45 -0700
Message-ID: <20140910180745.GA38736@core.coreip.homeip.net>
References: <541060D8.9020707@itdev.co.uk>
 <1410359581-16284-1-git-send-email-nick.dyer@itdev.co.uk>
 <54108A30.80003@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54108A30.80003@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: nick.dyer@itdev.co.uk, Yufeng Shen <miletus@google.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-input@vger.kernel.org

On Wed, Sep 10, 2014 at 11:28:16AM -0600, Stephen Warren wrote:
> On 09/10/2014 08:33 AM, nick.dyer@itdev.co.uk wrote:
> >From: Stephen Warren <swarren@wwwdotorg.org>
> >
> >[reworked after comments by Dmitry Torokhov. Move free of input device into
> >separate function. Only call in paths that require it.]
> >Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> 
> I re-tested this, and see no issues after inserting/removing the
> module a few times.

Applied, thank you.

-- 
Dmitry
