From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2] Input: evdev - Add EVIOC mechanism to extract the MT
 slot state
Date: Fri, 6 Jan 2012 20:18:35 +0100
Message-ID: <20120106191835.GA2998@polaris.bitmath.org>
References: <1325863019-2242-1-git-send-email-rydberg@euromail.se>
 <CAN+gG=FUEH851Um4Lco0avqdE2Eup3Jo79Ti4T7XhxT=PO6WeQ@mail.gmail.com>
 <20120106181845.GA22653@core.coreip.homeip.net>
 <20120106185544.GB2795@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:52326 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab2AFTSk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2012 14:18:40 -0500
Content-Disposition: inline
In-Reply-To: <20120106185544.GB2795@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chase Douglas <chase.douglas@canonical.com>

On Fri, Jan 06, 2012 at 07:55:44PM +0100, Henrik Rydberg wrote:
> > 2 different processes should be fine; the problem would be if 2 threads
> > of the same process share the same file descriptor. So far the rest of
> > evdev copes just fine with multiple threads using the same fd (all
> > operations are atomic in this regard), setting ABS_MT_SLOT before
> > fetching the state break this property.
> 
> Are we talking about the need for a per-client mutex, or something
> more subtle, like introducing indirect coupling between threads
> through per-client states? The former ought to be easily remedied.

Ok, maybe not to so easy after all, which probably answers my own
question. Looks like a EVIOCGMTSLOT, taking both slot and event code
as argument, would be the cleaner route to take. Another ioctl, how do we
feel about that?

Henrik
