From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH 2/2] Input: sparse-keymap - report KEY_UNKNOWN for unknown scan codes
Date: Fri, 25 Mar 2011 08:40:01 -0500
Message-ID: <1301060403-19229-1-git-send-email-seth.forshee@canonical.com>
References: <20110325073554.GD2590@core.coreip.homeip.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110325073554.GD2590@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Mar 25, 2011 at 12:35:54AM -0700, Dmitry Torokhov wrote:
> Hi Seth,
> 
> On Wed, Mar 23, 2011 at 04:13:43PM -0500, Seth Forshee wrote:
> >  
> > +	/* Report an unknown key event as a debugging aid */
> > +	unknown_ke.type = KE_KEY;
> > +	unknown_ke.code = code;
> > +	unknown_ke.keycode = KEY_UNKNOWN;
> > +	sparse_keymap_report_entry(dev, &unknown_ke, value, autorelease);
> 
> I think it should not depend on autorelease but always automatically
> release KEY_UNKNOWN.
> 
> Otherwise I think I'll apply both patches.

Great! Here are the patches with that changed.
