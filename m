From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] fix apple alu keyboard with numpad
Date: Thu, 8 May 2008 18:42:55 +0100
Message-ID: <20080508174255.GA8136@srcf.ucam.org>
References: <4814612F.5030606@bakke.com> <20080506125406.dc047710.akpm@linux-foundation.org> <20080506234307.GA27714@srcf.ucam.org> <4823386A.6000501@bakke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:56631 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1760427AbYEHRnM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2008 13:43:12 -0400
Content-Disposition: inline
In-Reply-To: <4823386A.6000501@bakke.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dag Bakke <dag@bakke.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Diego 'Flameeyes' Petteno <flameeyes@gmail.com>

On Thu, May 08, 2008 at 07:29:14PM +0200, Dag Bakke wrote:
> Matthew Garrett wrote, On 05/07/2008 01:43 AM:
> >On Tue, May 06, 2008 at 12:54:06PM -0700, Andrew Morton wrote:
> >
> >>>-static int hid_apple_fnmode = 1;
> >>>+static int hid_apple_fnmode = 2;
> >
> >Regardless of anything else, we don't want this hunk.
> >
> 
> Was my reasoning for this change off ("F-keys used more often that 
> multimediakeys, ergo make that the default"), or is your resistance to 
> this change due to some kind of policy?

It's a change in behaviour of a wide range of keyboards, and it's in a 
patch that is supposed to be fixing a single keyboard. Personally, I 
suspect that the people who are going to want the F-keys by default are 
the people who are easily able to change this behaviour and the ones who 
aren't are the ones who are going to expect their keyboard to behave 
like it did under MacOS. But that's a separate argument for a separate 
patch :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
